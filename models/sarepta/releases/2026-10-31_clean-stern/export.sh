#!/usr/bin/env bash
set -euo pipefail
release="$(cd "$(dirname "$0")" && pwd)"
repo="$(cd "$release/../../../.." && pwd)"
output_dir="${1:?Pass an authorized absolute dated output directory}"
mkdir -p "$release/raw"
for part in lower upper; do
 "$repo/export_stl" "sarepta_170mm_stern_$part" --source "$release/source.scad" --output-dir "$output_dir" -- --backend=Manifold --export-format binstl -D "part=\"$part\""
 raw="$output_dir/$(date +%F)_sarepta_170mm_stern_$part.stl"
 cp "$raw" "$release/raw/$(basename "$raw")"
 python3 "$release/clean_export.py" "$raw" "$release/$(basename "$raw")" "$release/cleanup-$part.json"
done
python3 "$release/verify.py"
