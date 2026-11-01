# Two-and-a-half-millimetre through-bolt joint — 2026-11-01

Parent: `2026-11-01_two-mm-bolt-joint`, preserved unchanged. At the owner's request the transverse reinforcement depth is adjusted from 2 mm to exactly 2.5 mm per half, giving a 5 mm combined stack at the mating plane. Both the plain strip and its four local circular lugs have this axial thickness. The cover joint reinforcement also uses the same 2.5 mm depth.

The inward strip width remains 6 mm. The circular pads reach 12 mm inward, and each M4 axis remains 7 mm inward, shifted 1 mm from the nominal expanded-strip midpoint. Four matching 4.3 mm diameter bores pass through both 2.5 mm flanges; there are no blind end walls. The 4.6 mm mouth lead-in remains 0.16 mm deep. Source dimensions are fixed millimetres when changing the whole boat length. Archived configurations are 170 and 340 mm overall; the default is 340 mm, nominally 170 mm per half.

The removed nearest bow frame, original longitudinal stringers, lowered side stations and three uncut original skirt components are retained. The source preserves all earlier reconstruction dependencies. Bolts and nuts shown in the inspection view are simplified purchased M4 hardware envelopes, repositioned against the thinner flanges; do not print those previews. Existing skirt studs and cover locator geometry remain scaled uniformly with their parent components. This revision does not include printed transverse guide pins.

## Artifacts and checks

- `source.scad`: editable model, default length 340 mm.
- `inspection-view.scad`: pastel separated components plus complete assembly.
- `joint-view.scad`, `joint-face-view.scad`: actual archived mating meshes.
- `print-<length>-<part>.scad`: four component poses for each archived size.
- `2026-11-01_sarepta_340mm_2_5_bolt_print_*.stl`: four print meshes, at most 170 mm long.
- `*_thin_bolt_joint_*.stl`: exact assembly-coordinate meshes for both configurations.
- `verification.json`: finite bore-passage, diameter, bearing support and hardware-clearance probes, frame/stringer preservation, unchanged exterior samples, matching faces and mesh topology.
- `print-verification.json`: closed printable meshes, bed placement and half-length limits.

All updated STL meshes are exported through `export_stl` into the owner-authorized project directory `stl/2026/2026.11/2026.11.01/`. Exact raw exports are retained under `raw/`. Cleanup logs record only surface-preserving zero-area refinement. No vertices are displaced, holes filled or components discarded to repair the meshes. Files and hashes are recorded in `manifest.json`.

This is an unprinted design revision. The 2.5 mm thickness is the owner's selected dimension, not a validated strength result. Bolt fit, tool access, tightening torque, adhesive strength and assembled watertightness remain physically untested. Retain the reported lengthwise print orientation and check brim/support clearance when slicing. No new Bambu project is provided.
