# Roof-width lid tabs with centred guide sockets — 2026-11-01

Parent: `2026-11-01_lid-alignment-sockets`, preserved as the rejected no-tab iteration. The owner clarified that mating tabs are required, but must remain within the width of the upper horizontal rail. PR https://github.com/domyshev/3d-workshop/pull/2 currently contains the earlier 2.5 mm body-joint commit; this lid correction is local until separately committed and pushed.

## Corrected construction

Restore two short rectangular lid tabs at the transverse seam, one under each original horizontal roof rail. Each half has a 2.5 mm axial tab depth. Tabs fill the full original horizontal rail span, without extending inward past its inner edge. Their XY footprint is clipped to the actual native top-face triangles, following the rail outline along the complete tab length. `roof-section.json` and `roof-plan.json/scad` record the measured section and exact footprint from the preserved original upper mesh.

At whole-boat length 340 mm, each mating tab is approximately 9.3904 mm wide and 5 mm high, including the original roof material, with a 2.5 mm axial depth per half. Guide axes lie at the width and height midpoint of the tab section: Y=±45.99522 mm, Z=57.73478 mm. The two matched sockets are 2 mm in diameter and 2.2 mm deep in each half, leaving 0.3 mm of material behind the added tab. Print two chamfered headless guide pins, diameter 1.8 mm and length 4 mm. Nominal paired depth clearance is 0.4 mm. A single revolved profile generates each pin, avoiding coincident cylindrical joins.

At whole length 170 mm, native rail dimensions and small lid guides scale uniformly: tab width 4.6952 mm, height 2.5 mm, sockets 1 mm by 1.1 mm depth and pins 0.9 mm by 2 mm. Axial tab depth remains 2.5 mm per half. The default remains 340 mm overall, with nominal 170 mm printable halves. Lower-hull geometry is byte-identical to the accepted 2.5 mm M4 joint. Original skirt sections and their matching fasteners are unchanged.

## Artifacts and verification

- `source.scad`: editable construction.
- `inspection-view.scad`: separate pastel parts, guide pins and assembled boat.
- `lid-face-view.scad`: thin section of the exact exported mating face.
- `print-<length>-<part>.scad`: poses for the four main printable parts.
- `2026-11-01_sarepta_340mm_roof_tab_print_*.stl`: four print meshes, at most 170 mm long.
- `2026-11-01_sarepta_340mm_roof_tab_pin.stl`: print two guide pins.
- `verify_lid.py` / `lid-verification.json`: 872 material probes, closed mesh topology, matching mating faces, clear socket passages, blind bottoms, material around each centred hole, complete tab support and no inward projection past the roof edge. Lower meshes are byte-identical to the previous verified M4 joint.
- `print-verification.json`: closed posed meshes, bed placement and 170 mm half-length limits.

Final updated STLs are exported through repository `export_stl` into `stl/2026/2026.11/2026.11.01/`. Exact raw exports and surface-preserving cleanup logs are retained. `raw/initial-flat-tab-exports/` contains an unaccepted initial diagnostic export, including a failed pin mesh; it is not a printable deliverable. Final pins were regenerated from a single revolved profile and pass topology checks. No vertices are moved, holes filled or components removed to repair meshes. The current sources, final meshes, provenance, reports and images are hashed in `manifest.json`.

Physical printing, pin fit, glue strength and watertightness remain untested. Preserve the reported lengthwise print orientation and check brim/support clearance when slicing. No Bambu project is included.
