#!/usr/bin/env bash
set -euo pipefail
release="$(cd "$(dirname "$0")" && pwd)"
repo="$(cd "$release/../../../.." && pwd)"
output_dir="${1:?Pass an authorized absolute dated output directory}"
"$repo/export_stl" sarepta_170mm_fair_root_lower --source "$release/source.scad" --output-dir "$output_dir" -- --backend=Manifold --export-format binstl -D 'part="lower"'
