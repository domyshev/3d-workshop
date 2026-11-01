# Full-height lid mating tabs — 2026-11-01

Parent: `2026-11-01_roof-width-lid-tabs`, preserved unchanged. The owner accepted the inward tab reach and requested that the tabs also extend down to the complete lower lid edge. This milestone retains the agreed inner edge while filling the full original lid height at the transverse seam.

## Construction

Each lid half has two mating tabs with 2.5 mm axial thickness. Their inner edges remain at the original horizontal roof's inner boundary. The outer side follows the unchanged native lid wall, filling the root against its slope to avoid a slit. Added material is clipped by the original belt envelope and stops exactly at Z=`25 * model_scale`, the lid-to-hull plane; it never extends down into the hull. The upper roof and external wall geometry remain unchanged in the sampled comparisons.

At overall boat length 340 mm, the tabs run from Z=50 mm to Z=60.23478 mm, a height of 10.23478 mm. Guide axes are at Y=±45.99522 mm and Z=55.11739 mm: the agreed roof-span width midpoint and the complete lid-height midpoint. The paired blind sockets remain 2 mm diameter and 2.2 mm deep per half. Print two headless guide pins, diameter 1.8 mm and length 4 mm. At overall length 170 mm these small lid dimensions scale uniformly: height 5.11739 mm, 1 mm bores by 1.1 mm depth and 0.9 x 2 mm pins. Axial tab thickness remains 2.5 mm per half at both sizes.

The lower hull is byte-identical to the verified 2.5 mm M4 joint. The three skirt components receive no additional cut. The default whole model is 340 mm with nominal 170 mm printable halves. Current lid work remains local; author PR https://github.com/domyshev/3d-workshop/pull/2 still contains the previously committed body-joint version.

## Files and verification

- `source.scad`: editable full-height tab construction.
- `inspection-view.scad`: separate pastel parts, all fasteners and full assembly.
- `lid-face-view.scad`: thin section from the actual exported lid face.
- `print-<length>-<part>.scad`: four main part print poses.
- `2026-11-01_sarepta_340mm_full_lid_tab_print_*.stl`: four print meshes, maximum length 170 mm.
- `2026-11-01_sarepta_340mm_full_lid_tab_pin.stl`: print two guide pins.
- `verify_lid.py` / `lid-verification.json`: 904 material probes, closed topology, paired mating faces, socket passages, blind bottoms, face support around the centred holes, full-height tab material to the lower lid plane, no inward overrun, sampled unchanged outer walls and byte-identical lower hulls.
- `print-verification.json`: closed posed meshes, bed placement and 170 mm limits.

Updated STLs use repository `export_stl` into `stl/2026/2026.11/2026.11.01/`. Exact raw exports, surface-preserving cleanup logs and checksum manifests are preserved. No mesh vertices are moved, holes filled or components discarded to repair geometry. Native roof section and footprint guides remain available as source evidence. Physical print, pin fit, adhesive strength and watertightness remain untested. Preserve the reported lengthwise print orientation and check brim/support clearance before slicing. No Bambu project is included.
