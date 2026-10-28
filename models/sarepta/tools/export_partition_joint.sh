#!/usr/bin/env bash
# Reproduce the checked 170 mm partition-joint STL using repository export rules.
set -euo pipefail
[[ $# -eq 1 ]] || { echo 'Usage: export_partition_joint.sh <authorized-dated-output-directory>' >&2; exit 2; }
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
output_dir="$1"
[[ "$output_dir" == /* ]] || { echo 'Output directory must be absolute' >&2; exit 2; }
work_dir="$(mktemp -d /private/tmp/sarepta-open-rim-export.XXXXXX)"
trap 'rm -rf "$work_dir"' EXIT
# The current macOS OpenSCAD build requires its x86_64 entry point.
if [[ "$(uname -s)" == Darwin && -x /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD ]]; then
    cat > "$work_dir/openscad" <<'SCAD_BIN'
#!/bin/sh
exec arch -x86_64 /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD "$@"
SCAD_BIN
    chmod +x "$work_dir/openscad"
    export PATH="$work_dir:$PATH"
fi
cd "$repo_root"
./export_stl sarepta_170mm_partition_joint_construction --source models/sarepta/sarepta_partition_joint.scad \
    --output-dir "$output_dir" -- --backend Manifold --export-format binstl -D 'part="lower"'
python3 models/sarepta/tools/remove_zero_area_facets.py \
    "$output_dir/$(date +%F)_sarepta_170mm_partition_joint_construction.stl" "$work_dir/connected.stl" \
    --report "$output_dir/$(date +%F)_sarepta_partition_joint_export_cleanup.json"
printf '%s\n' "import(\"$work_dir/connected.stl\",convexity=30);" > "$work_dir/publish.scad"
./export_stl sarepta_170mm_partition_joint_lower --source "$work_dir/publish.scad" \
    --output-dir "$output_dir" -- --backend CGAL --export-format binstl
python3 models/sarepta/skills/boat-hull-reconstruction/scripts/inspect_stl.py \
    "$output_dir/$(date +%F)_sarepta_170mm_partition_joint_lower.stl" --check
