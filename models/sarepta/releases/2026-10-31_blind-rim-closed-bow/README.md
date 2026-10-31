# Closed bow cap and hidden headless skirt pins

STL export date: 2026-10-31. Inspection and documentation completed 2026-11-01
(Europe/Madrid). The accepted scale reference remains 170/4600.
Parent: `2026-10-31_detachable-rim`. This is an unprinted local correction.

## Bow repair

Owner feedback showed genuine triangular openings after the previous bow-return
cut. A closed, manifold STL did not detect this unintended passage: the surfaces
around a physical opening can still form a valid closed solid.

Remove that cutter completely. Preserve the original `clean-bow-floor` forward
cap instead of cutting away the plating between the three cathedral-bow stems.
Continue the bow board down to the existing cap underside with a narrow root,
not a new full-width sheet across the open interior. The root follows the shared
belt and existing 4 mm landing outline, extending over X=0..58 mm. Its inclined
range is seam-1.18..seam-0.52 mm, overlapping the current belt by 0.08 mm. The
opening has a 0.02 mm modelling allowance to avoid coincident inherited facets.
The original cap remains at seam-1.20 mm. No accepted bottom guide is moved.

## Hidden skirt attachment

The owner clarified that each locator must be a separate headless stud entering
blind sockets in BOTH components, without piercing the skirt or hull interior.

- Fourteen studs remain on the seven existing X axes per side.
- Stud shaft diameter: 0.8 mm; total length: 1.5 mm; 0.2 mm tapered entry at each end.
- Hull bore diameter: 1.0 mm, nominal blind depth 0.95 mm.
- Skirt bore diameter: 1.0 mm, nominal blind depth 0.8 mm; opens only at the hidden inner face.
- Assembled body/skirt clearance: approximately 0.15 mm. Nominal insertion is
  0.675 mm per end, leaving axial clearance before both pocket bottoms.
- The minimum sampled end-wall material is 0.4995 mm at the hull pocket and
  0.8533 mm at the skirt pocket. The outward skirt surface remains continuous.

Do not reuse the parent's longer headed pins or through-drilled skirt meshes.
The upper cover and its four separate vertical locators remain byte-identical
to the parent. Three separately printed skirt sections and their 0.2 mm joints
are preserved. Fitting strength, print tolerances and assembly remain untested.

## Files and validation

`inspection-view.scad` shows separated components next to the complete assembly
in pastel colours. `fastener-section.scad` shows one headless stud inside its two
blind sockets. `print-rim-*.scad` rotate the three skirt undersides onto the bed.

`raw/` contains the exact repository `export_stl` outputs, exported to the
conversation-authorized project directory `stl/2026/2026.10/2026.10.31/`.
`clean_export.py` removes zero-area facets without moving vertices, filling
holes or discarding components. Logs and `manifest.json` record the archived
surface-preserving refinement, dates, origin and hashes. Historical parents
remain intact. Use `export.sh` with an authorized absolute dated output path.

`regression.json` passes all 564 inherited material checks, unchanged sampled
bottom/exterior checks below the skirt band, the shared cover joint, stern ribs
and 0.8 mm drain clearance. `verification.json` passes 458 additional material
and fit probes, including 24 points specifically inside the former triangular
bow openings. All seven final meshes are single connected closed surfaces with
positive volume, paired edges and valid vertex links. Headless-pin mesh bounds
are 0.8 x 0.8 x 1.5 mm. Bow pictures and the combined inspection render the exact
archived final STL files. These are finite digital checks, not a physical print,
a global minimum-wall proof or watertightness certification.
