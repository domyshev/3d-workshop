# Forward protective-skirt sockets — 2026-11-01

Parent: `2026-11-01_hatch-hinge-sockets`. Model scale remains 170/4600.
The owner identified missing matching attachments on the two forward V faces.
This revision adds two pairs per face: four new hull sockets and four matching
hidden bow-skirt sockets, using the existing 0.8 x 1.5 mm headless stud.

## Geometry and matching axes

The four horizontal axes are perpendicular in plan to the forward V faces.
Their centre positions and unit outward vectors are recorded in
`front-axes.scad` and `front-axes.json`. Transverse locations are Y=±7.5 and
±17.5 mm. Heights follow the original inclined skirt-band centre. All new
pockets are generated from those same axes in both parts and in the assembled
pin placement. No new axes are guessed independently on the two components.

Bore diameter is 1.0 mm. Each hull pocket is blind, 0.95 mm deep from the body
interface; each skirt pocket is blind, 0.8 mm deep from its hidden inner face.
The bore cutter extends into the air before the sloping skirt entry, avoiding
a partial membrane across the pin's circular entry. The outside end position
is unchanged by that entry allowance. The nominal body/skirt gap is 0.15 mm;
each headless pin enters approximately 0.675 mm into each part. The exterior
skirt remains unpierced, and the body pockets do not open into the boat.
The minimum sampled material behind a front pocket is 3.231 mm in the hull and
0.808 mm in the bow skirt. These are model allowances, not factory dimensions.

The original fourteen side studs are retained, bringing the total skirt studs
to eighteen. The cover, its two blind hatch-hinge sockets, four cover locators,
two aft skirt sections and stud mesh remain byte-identical to the parent.

## Files and verification

Open `inspection-view.scad` for all separated pastel parts and a full assembly.
The scene includes eighteen skirt studs. `front-body.png` shows the four new
front hull sockets; `front-rim-inside.png` shows their matching inner skirt
sockets. Images render the exact archived final STL files.

`source.scad` subtracts only the four new blind bores from each of the archived
parent hull and bow-skirt meshes. Exports use repository `export_stl` with the
authorized project destination `stl/2026/2026.11/2026.11.01/`. `raw/` preserves
those exact tool exports. Both cleanup logs report no facet/coordinate changes.
`manifest.json` records dates, provenance and hashes; prior milestones remain.

`verify.py` checks the new pocket volumes, full pin-entry cross sections,
continuous aperture surrounds and blind end walls in each common pin frame.
It checks both actual meshes for closed single-component topology, valid edge
and vertex links, and positive volume, and compares unchanged component bytes.
The 24 previous bow-closure points remain solid. Fit checks are finite samples;
physical printing, insertion and assembly strength remain untested.
