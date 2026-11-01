# Four-millimetre lid alignment sockets — 2026-11-01

Parent: `2026-11-01_full-height-lid-tabs`, preserved unchanged. At the owner's request the lid guide sockets increase from 2 mm to 4 mm diameter for the default 340 mm whole boat. Matching smooth glue-alignment pins increase from 1.8 mm to 3.8 mm diameter; their length remains 4 mm. Tab shape, location and blind depth are unchanged. The lower hull remains byte-identical to the verified 2.5 mm M4 joint.

## Current fastening plan

See **FASTENERS.md** for the complete size/quantity table, including both boat lengths. For a whole boat 340 mm long (nominal 170 mm halves):

- Hull transverse seam: four purchased M4 bolts and four M4 nuts; holes are 4.3 mm through both 2.5 mm flanges, a 5 mm combined stack. No smooth guide pins are used for this hull joint.
- Lid transverse seam: two printed smooth pins, diameter 3.8 mm by 4 mm long, in paired 4 mm blind sockets 2.2 mm deep per half. There are no nuts or bolt heads at this lid seam. Print two copies of `2026-11-01_sarepta_340mm_lid_guide_pin_d3_8_l4.stl`.
- Protective skirt: eighteen smooth headless studs, diameter 1.6 mm by 3 mm long, reused from the uniformly scaled original skirt geometry.
- Lid-to-hull positioning: four vertical locators, diameter 3.2 mm by 4 mm long, reused from the uniformly scaled original geometry. These are separate from the two new transverse lid guide pins.

## Geometry and scaling

The full-height lid tabs retain the agreed inward edge, meet the lower lid plane and follow the unchanged outer wall. At whole length 340 mm their height is 10.23478 mm and axial depth is 2.5 mm per half. Guide axes remain at Y=±45.99522 mm and Z=55.11739 mm. Nominal lid pin clearance is 0.2 mm diametral and 0.4 mm across the paired blind depths; each bore retains 0.3 mm behind its end.

The lid and its small guides scale uniformly: at whole length 170 mm the lid sockets are 2 mm diameter by 1.1 mm deep and guide pins are 1.9 mm diameter by 2 mm long. Body M4 holes, the 2.5 mm axial flanges and other independent hull-joint settings remain fixed millimetres. Do not assume 4 mm lid sockets when selecting the smaller 170 mm whole model.

## Artifacts and checks

- `source.scad`: editable construction with explicit hull/lid fastener comments.
- `inspection-view.scad`: pastel separated components, all fasteners and full assembly.
- `lid-face-view.scad`: exact exported contact section showing the larger holes.
- `print-<length>-<part>.scad`: main part print poses.
- `2026-11-01_sarepta_340mm_four_mm_lid_print_*.stl`: four print meshes, at most 170 mm long.
- `2026-11-01_sarepta_340mm_lid_guide_pin_d3_8_l4.stl`: two required lid guides; byte-identical descriptive alias of the parametrically exported pin.
- `verify_lid.py` / `lid-verification.json`: closed mesh topology, 904 material probes, measured bore diameters, paired mating faces, blind bottoms, support around each enlarged hole, unchanged full-height tabs and sampled unchanged outer walls. The volume difference from the parent lid equals precisely the increase in socket volumes within mesh precision. Lower meshes remain byte-identical to the verified body joint.
- `print-verification.json`: closed posed meshes, bed placement and 170 mm maximum length.

Updated meshes use repository `export_stl` into `stl/2026/2026.11/2026.11.01/`. Exact raw exports, surface-preserving cleanup logs and checksum manifests are retained. No vertices are moved, holes filled or components removed to repair meshes. Physical pin fit, printing, glue strength and watertightness remain untested. Preserve the reported lengthwise bed orientation and check brim/support clearance when slicing. No Bambu project is included. Current lid work remains local; author PR https://github.com/domyshev/3d-workshop/pull/2 still contains the earlier body-joint commit.
