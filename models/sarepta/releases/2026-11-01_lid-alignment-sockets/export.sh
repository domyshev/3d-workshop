#!/bin/bash
set -euo pipefail
repo="$(cd "$(dirname "$0")/../../../.." && pwd)"
r="$repo/models/sarepta/releases/2026-11-01_lid-alignment-sockets"
for length in 170 340; do
 for part in upper_bow upper_stern lid_joint_pin; do
  if [ "$part" = lid_joint_pin ]; then stem="sarepta_${length}mm_lid_joint_pin"; else stem="sarepta_${length}mm_lid_joint_$part"; fi
  file="2026-11-01_${stem}.stl"
  "$repo/export_stl" "$stem" --source "$r/source.scad" --output-dir "$repo/stl/2026/2026.11/2026.11.01" -- --backend=Manifold --export-format binstl -D "boat_length_mm=$length" -D "part=\"$part\""
  cp "$repo/stl/2026/2026.11/2026.11.01/$file" "$r/raw/$file"
  python3 "$r/clean_export.py" "$r/raw/$file" "$r/$file" "$r/cleanup-$length-$part.json"
 done
done
