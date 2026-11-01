#!/usr/bin/env bash
set -euo pipefail
release="$(cd "$(dirname "$0")" && pwd)"
repo="$(cd "$release/../../../.." && pwd)"
output_dir="${1:?Pass an authorized absolute dated output directory}"
"$repo/export_stl" sarepta_170mm_clean_bow_lower --source "$release/source.scad" --output-dir "$output_dir" -- --backend=Manifold --export-format binstl -D 'part="lower"'
mkdir -p "$output_dir/final"
raw="$output_dir/$(date +%F)_sarepta_170mm_clean_bow_lower.stl"
python3 "$release/clean_export.py" "$raw" "$output_dir/final/$(basename "$raw")" "$output_dir/final/cleanup-lower.json"
