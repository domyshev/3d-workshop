#!/usr/bin/env bash
# Reproduce the lightweight parts through the repository's required exporter.
set -euo pipefail
[[ $# -eq 1 && "$1" == /* ]] || { echo 'Usage: export.sh <authorized-absolute-dated-output-directory>' >&2; exit 2; }
output_dir="$1"
release_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$release_dir/../../../.." && pwd)"
task_tmp="$(mktemp -d /private/tmp/sarepta-lightweight.XXXXXX)"
trap 'rm -rf "$task_tmp"' EXIT
if [[ "$(uname -s)" == Darwin ]]; then
    cat > "$task_tmp/openscad" <<'BIN'
#!/bin/sh
exec arch -x86_64 /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD "$@"
BIN
    chmod +x "$task_tmp/openscad"
    export PATH="$task_tmp:$PATH"
fi
cd "$repo_dir"
today="$(date +%F)"
./export_stl sarepta_170mm_light_construction --source "$release_dir/source.scad" --output-dir "$output_dir" -- --backend Manifold --export-format binstl -D 'part="lower"'
python3 "$release_dir/clean_export.py" "$output_dir/${today}_sarepta_170mm_light_construction.stl" "$task_tmp/lower.stl" "$output_dir/${today}_sarepta_light_export_cleanup.json"
printf 'import("%s",convexity=30);\n' "$task_tmp/lower.stl" > "$task_tmp/publish.scad"
./export_stl sarepta_170mm_light_lower --source "$task_tmp/publish.scad" --output-dir "$output_dir" -- --backend CGAL --export-format binstl
for item in upper dashboard pin; do
    ./export_stl "sarepta_170mm_light_${item}" --source "$release_dir/source.scad" --output-dir "$output_dir" -- --backend Manifold --export-format binstl -D "part=\"${item}\""
done
for item in lower upper dashboard pin; do
    python3 "$repo_dir/models/sarepta/skills/boat-hull-reconstruction/scripts/inspect_stl.py" "$output_dir/${today}_sarepta_170mm_light_${item}.stl" --check
done
