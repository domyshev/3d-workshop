# Fair cover joint — 2026-10-31

Correct the lightweight cover after the owner identified a bow-side slit,
a lateral step at the horizontal joint, and a change in side inclination.
Previous releases remain unchanged. This is an unprinted revision.

## Geometry

The cover side is derived from the actual archived lightweight lower mesh at
Z=25 mm. At each sampled X, the new ruled side starts at the lower outer skin
and continues its local transverse tangent, rather than lifting the old cover
vertically. A generated native OpenSCAD polyhedron records that continuation.
The raised roof datum remains 30.117391 mm, with one 1 mm skin and open ribs.
The internal cavity uses conservative 1.2 mm XY erosion of the new blank.
Raised deck details are clipped to the corrected plan outline.

The four glue-guide axes move inward to (33,+/-23.6) and (160,+/-24.4) mm,
so their blind holes retain material around the corrected sloping side.
Use the new upper and lower as a matched pair. Pin diameter 1.6 mm, length
2 mm and bore diameter/depth 1.85/1.1 mm are unchanged. Dashboard and pin
STLs are byte-identical copies of the previous lightweight revision.
The lower exterior, protective rim and bottom remain unchanged. Only its
internal guide bores move. Hatch lid and transverse splitting remain pending.

## Files and reproduction

- `assembly-view.scad`: assembled exact archived STL meshes.
- `upper-view.scad`, `lower-view.scad`, `layout-view.scad`: individual/laid out meshes.
- `source.scad`: construction source, with part selector.
- `continuation.scad`: generated continuation polyhedron and sampled join profile.
- `generate_continuation.py`: standard-library generator using the previous lower STL.
- `export.sh`: reproduce both changed STL files through the repository export tool.
- `verify.py`, `verification.json`: checks against the actual archived meshes.
- `raw/`: unmodified binary exports; final files remove zero-area facets and split
  exact collinear T-junctions with the existing `clean_export.py`. No vertex moves,
  hole filling or surface/volume changes are introduced by that refinement.

## Validation and limits

Both final meshes are closed, single-component, positive-volume solids with
paired edges, valid vertex links and no zero-area triangles. At 119 sampled
stations, maximum joint offset is 0.000003 mm and maximum transverse tangent
error is 0.050 degrees. The 476 ordinary side-wall probes have a minimum
horizontal material interval of 1.170 mm. Guide-wall probes pass the 0.78 mm
threshold. All 1156 sampled exterior extremes on the lower hull are unchanged.

These are sampled checks, not a global normal-thickness proof. They do not
certify physical fit, printing, strength or watertightness. Small inherited
mesh facets, the intended lower protective rim and prototype construction
creases remain distinct from the corrected horizontal glue joint.

Images are rendered from the exact archived STL files.
