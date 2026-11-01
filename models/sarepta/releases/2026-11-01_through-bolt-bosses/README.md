# Through-bolt joint with local circular pads — 2026-11-01

Parent: `2026-11-01_wide-joint-clear-frame`, preserved unchanged. The lower hull retains a 6 mm inward glue strip, 4 mm axial thickness per half, the lowered side stations and the removed nearest bow transverse frame. The cover, three original skirt components and their existing fasteners remain unchanged.

Each of the four joint stations has a circular pad of radius 6 mm, extending the strip locally to 12 mm inward from the original cavity contour. Its centre is 6 mm inward. The bolt axis is 7 mm inward: shifted 1 mm farther into the boat than the nominal midpoint of the expanded strip. Stations follow the local section slopes; bottom positions remain evenly distributed and side stations stay near the upper region. `joint-axes.json` records exact coordinates.

Paired holes are 4.3 mm in diameter for M4 bolts and pass through the complete 4 mm flange thickness in BOTH halves. No blind end wall remains. A short 4.6 mm mouth lead-in is retained at the mating plane. The underlying 6 mm strip and 12 mm pads are fixed millimetres when changing the overall source length. The default whole length is 340 mm, with nominal 170 mm halves. Archived inspection configurations are 170 and 340 mm.

A normal M4 hex nut is 7 mm across flats, about 8.1 mm across corners; the illustrated socket-head screw has a 7 mm cylindrical head. The shifted axis leaves approximately 5 mm to the pad's inward edge. Mesh tests sample a 4.7 mm bearing radius and free 4.1 mm radial hardware space behind the flange, sufficient geometrically for these envelopes. The combined SCAD shows simplified purchased hardware for context; it is not threaded, is not a manufacturing model, and should not be printed. Printed guide pins from the previous revision are superseded for this joint. Hardware length, tightening torque and tool access require selection and physical trial. No strength certification is claimed.

## Files and checks

- `source.scad`: editable construction, default length 340 mm.
- `inspection-view.scad`: separated pastel parts and complete assembly with hardware previews.
- `joint-view.scad`, `joint-face-view.scad`: exact exported lower halves and mating sections.
- `print-<length>-<part>.scad`: poses for all four main parts.
- `2026-11-01_sarepta_340mm_bolt_print_*.stl`: four print meshes, maximum length 170 mm.
- `*_bolt_joint_*.stl`: assembled-coordinate parts for 170 and 340 mm.
- `verification.json`: mesh topology, mating-plane agreement, bore diameter, through passage, bearing support, hardware clearance, retained frame removal/stringers and sampled exterior preservation.
- `print-verification.json`: topology, bed placement and 170 mm maximum length.

Updated lower meshes are exported through repository `export_stl` to `stl/2026/2026.11/2026.11.01/`; exact raw exports remain in `raw/`. Cleanup is limited to surface-preserving zero-area refinement, recorded in individual logs. Unchanged upper meshes are byte copies of the parent exports. All milestone files are hashed in `manifest.json`. The successful lengthwise print baseline is retained; check printer brim/support clearance before slicing. No Bambu project, physical print, bolt fit or glue-strength test is included.
