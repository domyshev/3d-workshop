#!/usr/bin/env bash
set -euo pipefail
release="$(cd "$(dirname "$0")" && pwd)"
repo="$(cd "$release/../../../.." && pwd)"
output_dir="${1:?Pass an authorized absolute dated output directory}"
for part in lower rim_bow; do
 "$repo/export_stl" "sarepta_170mm_front_skirt_$part" --source "$release/source.scad" --output-dir "$output_dir" -- --backend=Manifold --export-format binstl -D "part=\"$part\""
done
