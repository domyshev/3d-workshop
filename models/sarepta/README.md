# Sarepta — hull reconstruction and reference archive

Start here. This project preserves the printable hull, the evidence used to
reconstruct it, and the unsuccessful and successful intermediate versions.
All dimensions in research notes are prototype millimetres unless stated otherwise.

## Current state — 2026-10-23

The current editable model includes three bow stems, paired tunnels, a foredeck
hatch, continuous protective rim, inward-sloping upper belt and shallow foredeck
relief. It is **a reconstruction, not a dimension-certified factory replica**.
The cabin and motors remain separate future work. The 80 mm trial retains
printable wall thickness rather than scaling the metal plate thickness literally.

The side/deck datum is now 750 mm including the reverse upper belt. The model
uses the coherent early 4600 x 1600 envelope, the passport's 375 mm motor seat
and the published 2600 x 1280 cockpit envelope; longitudinal positions remain
reconstructed. Internal floor/side frames, longitudinal stiffeners, separate
bow locker, a raised motor well, side corrugations and chine flanges are included.
See [transom and framing decisions](TRANSOM_AND_FRAMING.md) and
[pending corrections](PENDING_CORRECTIONS.md) for remaining estimates.

The [latest release](releases/2026-10-23_dimensions-framing/README.md) includes
both exact binary STL sizes: 80 x 27.826 x 13.299 and
170 x 59.130 x 28.261 mm. Both pass edge/vertex topology checks; physical
printing is untested. Heights include the small embossed deck details.

## Evidence and decisions

- [Dimensional evidence audit](DIMENSION_RESEARCH.md): explicit values, conflicts,
  unmeasured details, archive leads and implications for the current model.
- [Dimensions as CSV](DIMENSIONS.csv): machine-readable companion to the audit.
- [Source catalogue and attribution](reference/SOURCES.md): where every group
  of documents, images and tutorials came from, and how it was used.
- [Reference image index](reference/README.md): the most useful views and documents.
- [Pending corrections and assumptions](PENDING_CORRECTIONS.md): remaining modelling
  work; a proposed value is not silently promoted to a factory measurement.
- [Development log](DEVELOPMENT_LOG.md): the complete earlier chronological account,
  including historical checks and slicing estimates. Earlier claims are historical;
  the newer dimensional audit takes precedence.

## Models and history

- [Main OpenSCAD source](sarepta_hull.scad): default overall length 170 mm.
- [80 mm entry point](sarepta_hull_80mm.scad).
- [Bow and plan regression checks](verify_bow.scad).
- [STL release history with pictures](releases/README.md): eight 80 mm
  milestones and the latest 170 mm export, preserved byte-for-byte, with renders made from their actual meshes.
- [Latest archived STL stage](releases/2026-10-23_dimensions-framing/README.md):
  corrected datums and internal framing; remaining estimates are explicit.
- `history/`: accepted parametric snapshots before subsequent revisions.
- `previews/`: working renders; release-specific mesh renders are under `releases/`.

![Current archived mesh](releases/2026-10-23_dimensions-framing/above.png)

## Agent workflow

Before changing the hull, read [AGENTS.md](AGENTS.md) and the project-local
[boat-hull-reconstruction skill](skills/boat-hull-reconstruction/SKILL.md).
The skill packages the methods and lessons from this project; it is not globally
installed. Its supporting notes distinguish McNeel guidance from original
OpenSCAD adaptations and rejected external role instructions.

Export newly generated STLs with the repository `export_stl` tool and the
conversation-authorized export base. Existing historical exports are preserved,
not regenerated. During design, provide STL/OpenSCAD views; Bambu preparation is
performed when requested.

## Integrity and provenance

`reference/SHA256SUMS` covers every preserved reference file.
`releases/SHA256SUMS` covers historical meshes, source snapshots, metadata and renders.
Run `python3 tools/verify_archive.py` after copying or restoring the archive.
Source URLs, capture dates and hashes are preserved locally. Third-party
attribution is recorded in [ATTRIBUTION.md](ATTRIBUTION.md); no blanket license
is assigned to reference scans or photos.
