#!/usr/bin/env bash
set -euo pipefail
release="$(cd "$(dirname "$0")" && pwd)"
repo="$(cd "$release/../../../.." && pwd)"
output_dir="${1:?Pass the authorized absolute dated destination}"
for length in 170 340; do
 for part in lower_bow lower_stern upper_bow upper_stern; do
  "$repo/export_stl" "sarepta_${length}mm_wide_joint_$part" --source "$release/source.scad" --output-dir "$output_dir" -- --backend=Manifold --export-format binstl -D "boat_length_mm=$length" -D "part=\"$part\""
 done
done
"$repo/export_stl" sarepta_joint_pin_4mm --source "$release/source.scad" --output-dir "$output_dir" -- --backend=Manifold --export-format binstl -D 'part="joint_pin"'
