#!/usr/bin/env bash
set -euo pipefail
release="$(cd "$(dirname "$0")" && pwd)"
repo="$(cd "$release/../../../.." && pwd)"
output_dir="${1:?Pass the authorized absolute dated output directory}"
for part in lower rim_bow rim_port rim_starboard rim_pin; do
 "$repo/export_stl" "sarepta_170mm_detachable_$part" --source "$release/source.scad" --output-dir "$output_dir" -- --backend=Manifold --export-format binstl -D "part=\"$part\""
done
