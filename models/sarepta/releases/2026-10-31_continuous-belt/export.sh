#!/usr/bin/env bash
set -euo pipefail
release="$(cd "$(dirname "$0")" && pwd)"
repo="$(cd "$release/../../../.." && pwd)"
output_dir="${1:?Pass an authorized absolute dated output directory}"
python3 "$release/generate_belt.py"
mkdir -p "$output_dir/final"
for part in lower upper; do
 "$repo/export_stl" "sarepta_170mm_continuous_$part" --source "$release/source.scad" --output-dir "$output_dir" -- --backend=Manifold --export-format binstl -D "part=\"$part\""
 raw="$output_dir/$(date +%F)_sarepta_170mm_continuous_$part.stl"
 python3 "$release/clean_export.py" "$raw" "$output_dir/final/$(basename "$raw")" "$output_dir/final/cleanup-$part.json"
done
