# Project Instructions

## Git Commit Messages

- Every commit subject must briefly state the main point of the commit.
- Every commit must include a body after the subject.
- The commit body must describe in detail what was done, including important files,
  generated artifacts, parameters, and verification steps when applicable.

## STL Artifacts

- STL files stored under `stl/YYYY-MM-DD/` must still include the same date as a
  filename prefix, for example `stl/2026-07-05/2026-07-05_part_name.stl`.
- Export STL artifacts with the repository's `./export_stl` tool. For assembly
  models, pass the model's part selector after `--`, for example
  `-D 'part="cube"'`.
- Use the external destination template
  `<STL_BASE_PATH>/<YYYY>/<YYYY.MM>/<YYYY.MM.DD>/`, replacing every date token
  with the export date. Pass the resolved directory through `--output-dir`.
- `STL_BASE_PATH` must come from the current conversation. If it is not present
  in the agent's context, ask the user for it before exporting instead of
  assuming a path.

## macOS OpenSCAD launch safety

- Use `./export_stl` for CLI exports; it selects Intel compatibility mode from
  Mach-O metadata without starting OpenSCAD as a capability probe.
- Do not test a known-incompatible ARM build with `--version` or a render:
  even a handled abort can display an intrusive macOS crash dialog.
- When opening an Intel-capable OpenSCAD app bundle for inspection on macOS,
  use `open --arch x86_64 -a <app-bundle> <inspection-file>`. Reuse the existing
  application instance; do not force-close it or discard unsaved documents.
