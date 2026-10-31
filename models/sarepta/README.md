# Sarepta — hull reconstruction and reference archive

Start here. This project preserves the printable hull, the evidence used to
reconstruct it, and the unsuccessful and successful intermediate versions.
All dimensions in research notes are prototype millimetres unless stated otherwise.

## Current state — 2026-10-30

The latest [serviceable dashboard release](releases/2026-10-28_serviceable-dashboard/README.md)
contains four STL parts: reinforced lower hull, internally revised upper cover,
removable dashboard with footwell shelf, and lift-out stop bar. The projecting
lower chine strip is removed; upper protective rim and side corrugations remain.
Front locating sockets have full-height webs and sloped roots. The dashboard
slides aft after removing the stop bar, even with the upper cover glued.
All four meshes, 33 material probes and sampled movement/contact checks pass.
The owner reported an excellent print on 2026-10-30 and nominated this variant
as [release candidate 0.1](release-candidates/0.1/README.md). **The successful
print was rotated lengthwise along the bed, not diagonally.** Archived 3MFs still
store the earlier 45-degree preparation; reorient and re-slice to reproduce the
successful placement. Exact part coverage and assembled fit are not confirmed.
Open [the separated view](inspect_split.scad).

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

The [accepted one-piece parent](releases/2026-10-23_bow-plan-proportions/README.md) includes
both exact binary STL sizes: 80 x 27.826 x 13.261 and
170 x 59.130 x 28.179 mm. Both pass edge/vertex topology checks; physical
printing is untested. Heights include the small embossed deck details.

The two side corrugations now remain horizontal and run from an estimated
X=1600 to the transom at X=4600, with flat forward ends, following the user
photographs. Their heights of 280 and 425 remain visual estimates.

The latest interior revision adds a stepped front boundary with leg space,
wider cabin landing strips covering the unchanged frame tips, four backed
storage pockets and motor-well scuppers. Deck beads are straight, shorter
and shallower. Read the [interior evidence audit](INTERIOR_RESEARCH.md) for
source-backed features and estimated dimensions. Views are neutral grey.

The latest plan review redistributes the bow narrowing over a long shallow
shoulder before the steeper forward V. The closed upper deck is 1600 and the
hatch centre 1200 from the tip; the well remains at 4000. These are selected
reconstruction values. The kit and passport schematic disagree on hatch
placement; see [bow plan review](BOW_PLAN_REVIEW.md) for recorded image
landmarks, uncertainty and a construction comparison.

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
- [STL release history with pictures](releases/README.md): the earlier 80 mm
  milestones and the latest 170 mm export, preserved byte-for-byte, with renders made from their actual meshes.
- [Latest archived STL stage](releases/2026-10-23_bow-plan-proportions/README.md):
  long shallow bow shoulders, a longer foredeck and coordinated hatch placement; remaining estimates are explicit.
- `history/`: accepted parametric snapshots before subsequent revisions.
- `previews/`: working renders; release-specific mesh renders are under `releases/`.

![Current archived mesh](releases/2026-10-23_bow-plan-proportions/above.png)

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

## Upper-deck lightening comparison

The [pocket study](releases/2026-10-27_upper-pocket-comparison/README.md) is
archived as a comparison, not the current model. With identical slicing
settings, pockets save only 0.48 g (2.92%) and add 2 min 39 s. The accepted
unpocketed horizontal upper remains recommended; physical strength of the
pocket candidate has not been tested.

## Prepared printing project — 2026-10-28

[The corrected white-filament printing project](print-projects/2026-10-28_serviceable-white/README.md)
contains two A1 mini plates with all four parts and four locating pins: 0.16 mm,
three walls and ordinary 15% Grid. White Polymaker PolyTerra PLA is embedded. Estimated total 4 h 46 min and 73.70 g,
including supports and adhesion material. A successful lengthwise print was
reported on 2026-10-30; see [candidate 0.1](release-candidates/0.1/README.md) for
the crucial difference from the archived diagonal layout.

Latest design study: [2026-10-31 lightweight open deck](releases/2026-10-31_lightweight-open-deck/README.md)
— one roof skin, open ribs, small glue locators, single panel and higher rear
transom. Digitally checked, physically untested; candidate 0.1 remains archived.

Latest cover correction: [fair cover joint](releases/2026-10-31_fair-cover-joint/README.md). Open `sarepta_fair_joint.scad` for editable construction or the release's `assembly-view.scad` for exact exported meshes.

Latest revision: [clean stern and continuous rim](releases/2026-10-31_clean-stern/README.md). Open `sarepta_inspection.scad` for the default combined pastel inspection scene.

Current geometry: [continuous belt and open stern](releases/2026-10-31_continuous-belt/README.md). Use `sarepta_current.scad` for construction and `sarepta_inspection.scad` for the combined pastel scene.

Current view: [open bow with panel hidden](releases/2026-10-31_open-bow/README.md). The default combined inspection omits the dashboard and the obsolete internal mounting remnants are removed.

Current inspection: [level stern ribs and clear bow floor](releases/2026-10-31_clean-bow-floor/README.md). Level stern-rib tops, aligned outlets with 0.8 mm lower clearance, and additional bow-floor cleanup are included.

## Detachable protective rim — 2026-10-31

See [detachable-rim revision](releases/2026-10-31_detachable-rim/README.md). The inward bow-board return is trimmed; the skirt is now three separately printable pieces with fourteen side-inserted micro pins and blind hull pockets. Actual archived mesh, sampled geometry and clearance checks pass; physical print and fit remain untested. Prior geometry checkpoint: [PR #1](https://github.com/domyshev/3d-workshop/pull/1).

## Closed bow cap and hidden skirt studs — 2026-11-01

The [new correction](releases/2026-10-31_blind-rim-closed-bow/README.md) removes the bow cutter that opened two triangular passages, restores the original cap and blends the board root. Separate 0.8 x 1.5 mm headless studs now enter blind pockets in both hull and skirt; neither component is pierced. Actual archived meshes, 564 inherited material checks and 458 additional probes pass, including 24 checks in the former bow openings. Physical printing and assembled fit remain untested.

## Fair inner bow-board root — 2026-11-01

The [fair-root revision](releases/2026-11-01_fair-bow-root/README.md) replaces the projecting rectangular root/end with one swept inner transition to the horizontal landing, fading into the original sidewall. The accepted bow cap and all hidden stud/skirt components are preserved. The exact exported meshes, closure probes, legacy regression and targeted end-face checks pass; physical print and fit remain untested.

## Forward hatch-hinge mounting sockets — 2026-11-01

The [hinge-socket revision](releases/2026-11-01_hatch-hinge-sockets/README.md) adds two 2 mm top-entry blind bores ahead of the hatch, at X=32.2 and Y=±5 mm. Solid 4.4 mm underside bosses support the 2.8 mm deep holes with 0.4 mm closed bottoms. The upper export and sampled geometry checks pass; all other component meshes are byte-identical. Physical hinge/print fit remains untested.

## Forward protective-skirt sockets — 2026-11-01

The [front-socket revision](releases/2026-11-01_front-skirt-sockets/README.md) adds four matching pairs of blind 1 mm sockets on the forward V faces and inner bow skirt. Existing 0.8 x 1.5 mm headless studs remain hidden in both components. There are now eighteen skirt studs. Both modified exported meshes and finite fit/closure checks pass; physical assembly is untested.
