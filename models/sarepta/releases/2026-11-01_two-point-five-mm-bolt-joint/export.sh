#!/bin/bash
set -euo pipefail
repo="$(cd "$(dirname "$0")/../../../.." && pwd)"
r="$repo/models/sarepta/releases/2026-11-01_two-point-five-mm-bolt-joint"
for length in 170 340; do
 for part in lower_bow lower_stern upper_bow upper_stern; do
  file="2026-11-01_sarepta_${length}mm_2_5_bolt_joint_$part.stl"
  "$repo/export_stl" "sarepta_${length}mm_2_5_bolt_joint_$part" --source "$r/source.scad" --output-dir "$repo/stl/2026/2026.11/2026.11.01" -- --backend=Manifold --export-format binstl -D "boat_length_mm=$length" -D "part=\"$part\""
  cp "$repo/stl/2026/2026.11/2026.11.01/$file" "$r/raw/$file"
  python3 "$r/clean_export.py" "$r/raw/$file" "$r/$file" "$r/cleanup-$length-$part.json"
 done
done
