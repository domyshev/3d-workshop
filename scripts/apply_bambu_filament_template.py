#!/usr/bin/env python3

import argparse
import json
import os
import tempfile
import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path


PROJECT_SETTINGS = "Metadata/project_settings.config"
MODEL_SETTINGS = "Metadata/model_settings.config"


def load_settings(archive_path):
    with zipfile.ZipFile(archive_path) as archive:
        return json.loads(archive.read(PROJECT_SETTINGS))


def find_white_filament(settings):
    colours = settings.get("filament_colour", [])
    for index, colour in enumerate(colours):
        if colour.upper().startswith("#FFFFFF"):
            return index
    raise ValueError("reference project has no white filament")


def profile_search_roots():
    return (
        Path.home()
        / "Library/Application Support/BambuStudio/system/BBL/filament",
        Path(
            "/Applications/BambuStudio.app/Contents/Resources/profiles/BBL/filament"
        ),
    )


def index_profiles():
    profiles = {}
    for root in profile_search_roots():
        if not root.is_dir():
            continue
        for path in root.glob("*.json"):
            try:
                data = json.loads(path.read_text())
            except (OSError, json.JSONDecodeError):
                continue
            name = data.get("name")
            if name:
                profiles.setdefault(name, data)
    return profiles


def resolve_profile(name, profiles, active=None):
    active = set() if active is None else active
    if name in active:
        raise ValueError(f"cyclic Bambu profile inheritance: {name}")
    if name not in profiles:
        return {}

    active.add(name)
    profile = profiles[name]
    parent_name = profile.get("inherits")
    resolved = (
        resolve_profile(parent_name, profiles, active)
        if parent_name
        else {}
    )
    resolved.update(profile)
    active.remove(name)
    return resolved


def single_filament_settings(reference_settings, filament_index):
    result = dict(reference_settings)
    profile_names = reference_settings.get("filament_settings_id", [])
    if filament_index >= len(profile_names):
        raise ValueError("white filament has no settings profile")

    profile = resolve_profile(profile_names[filament_index], index_profiles())
    filament_keys = set(profile)
    filament_keys.update(
        key for key in reference_settings if key.startswith("filament_")
    )
    filament_keys.update(
        {
            "activate_air_filtration",
            "additional_cooling_fan_speed",
            "additional_fan_full_speed_layer",
            "chamber_temperatures",
            "close_additional_fan_first_x_layers",
            "close_fan_the_first_x_layers",
            "complete_print_exhaust_fan_speed",
            "default_filament_colour",
            "during_print_exhaust_fan_speed",
            "extruder_ams_count",
            "first_x_layer_fan_speed",
            "first_x_layer_part_fan_speed",
            "full_fan_speed_layer",
            "ironing_fan_speed",
            "no_slow_down_for_cooling_on_outwalls",
            "overhang_fan_speed",
            "overhang_fan_threshold",
            "pre_start_fan_time",
            "reduce_fan_stop_start_freq",
            "slow_down_for_layer_cooling",
            "slow_down_layer_time",
            "slow_down_min_speed",
        }
    )

    for key in filament_keys:
        value = result.get(key)
        if isinstance(value, list) and filament_index < len(value):
            result[key] = [value[filament_index]]

    result["flush_volumes_matrix"] = ["0"]
    reference_flush = reference_settings.get("flush_volumes_vector", [])
    flush_start = filament_index * 2
    result["flush_volumes_vector"] = reference_flush[
        flush_start : flush_start + 2
    ] or ["140", "140"]
    result["filament_map"] = ["1"]
    result["filament_volume_map"] = ["0"]
    return result


def replace_archive_entries(target_path, replacements):

    with tempfile.NamedTemporaryFile(
        dir=target_path.parent,
        prefix=f".{target_path.name}.",
        suffix=".tmp",
        delete=False,
    ) as temporary:
        temporary_path = Path(temporary.name)

    try:
        with zipfile.ZipFile(target_path, "r") as source:
            with zipfile.ZipFile(temporary_path, "w") as destination:
                for item in source.infolist():
                    data = replacements.get(
                        item.filename,
                        source.read(item.filename),
                    )
                    destination.writestr(item, data)
        os.replace(temporary_path, target_path)
    finally:
        temporary_path.unlink(missing_ok=True)


def encode_project_settings(settings):
    return json.dumps(
        settings,
        ensure_ascii=False,
        indent=4,
        sort_keys=True,
    ).encode("utf-8")


def apply_strong_object_settings(model_settings, source_files):
    root = ET.fromstring(model_settings)
    matched = []

    for object_node in root.findall("object"):
        object_sources = {
            metadata.get("value")
            for part in object_node.findall("part")
            for metadata in part.findall("metadata")
            if metadata.get("key") == "source_file"
        }
        matching_sources = object_sources.intersection(source_files)
        if not matching_sources:
            continue

        settings = {
            "sparse_infill_density": "100%",
            "sparse_infill_pattern": "zig-zag",
            "wall_loops": "5",
        }
        metadata_by_key = {
            metadata.get("key"): metadata
            for metadata in object_node.findall("metadata")
            if metadata.get("key")
        }
        insert_at = len(object_node.findall("metadata"))
        for key, value in settings.items():
            metadata = metadata_by_key.get(key)
            if metadata is None:
                metadata = ET.Element("metadata", key=key, value=value)
                object_node.insert(insert_at, metadata)
                insert_at += 1
            else:
                metadata.set("value", value)
        matched.extend(sorted(matching_sources))

    missing = source_files.difference(matched)
    if missing:
        raise ValueError(
            "strong objects not found in project: " + ", ".join(sorted(missing))
        )

    ET.indent(root, space="  ")
    return (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        + ET.tostring(root, encoding="unicode")
        + "\n"
    ).encode("utf-8")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--reference", required=True, type=Path)
    parser.add_argument("--target", required=True, type=Path)
    parser.add_argument("--infill-density")
    parser.add_argument("--wall-loops")
    parser.add_argument(
        "--strong-object",
        action="append",
        default=[],
        help="STL source filename that should use 100%% infill and 5 walls",
    )
    args = parser.parse_args()

    reference_settings = load_settings(args.reference)
    filament_index = find_white_filament(reference_settings)
    settings = single_filament_settings(reference_settings, filament_index)
    if args.infill_density is not None:
        settings["sparse_infill_density"] = args.infill_density
        if args.infill_density.strip() in {"100", "100%"}:
            # Bambu Studio rejects grid/cubic patterns at full density.
            settings["sparse_infill_pattern"] = "zig-zag"
    if args.wall_loops is not None:
        settings["wall_loops"] = args.wall_loops
    replacements = {
        PROJECT_SETTINGS: encode_project_settings(settings),
    }
    if args.strong_object:
        with zipfile.ZipFile(args.target) as archive:
            model_settings = archive.read(MODEL_SETTINGS)
        replacements[MODEL_SETTINGS] = apply_strong_object_settings(
            model_settings,
            set(args.strong_object),
        )
    replace_archive_entries(args.target, replacements)

    profile_name = settings["filament_settings_id"][0]
    colour = settings["filament_colour"][0]
    print(f"Applied single filament: {profile_name} ({colour})")
    if args.strong_object:
        print("Applied 100% infill and 5 walls to: " + ", ".join(args.strong_object))


if __name__ == "__main__":
    main()
