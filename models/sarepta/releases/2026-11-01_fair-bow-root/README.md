# Fair bow-board root — 2026-11-01

Parent: `2026-10-31_blind-rim-closed-bow`; scale reference 170/4600.
This correction changes the lower hull's added inner root only. The cover,
three skirt sections, headless skirt studs and four cover locators are copied
byte-identically from the parent. Physical print and fit remain untested.

## Problem and resulting surface

The previous root was a 0.66 mm thick inclined rectangular strip ending at
X=58 mm. Its base followed the inclined seam while the upper cover landing
starts at a fixed Z=23.35 mm. The resulting separate ledge and abrupt end
were modelling artifacts rather than required boat construction.

Replace it with one coherent swept transition. The inner surface gradually
joins the approximately 1.2 mm side shell to the existing horizontal landing.
A quintic blend in height controls the cross section; a second quintic blend
fades its inward projection from X=18 to X=58 mm. Both blends have zero first
and second derivatives at their endpoints. By the former end, the generated
root is buried inside the original side plating, leaving no exposed end cap.
Do not erase or recut the original forward cap: the accepted three stems and
closed tunnel tops remain intact, with the interior still accessible.

`generate_root.py` derives corresponding rings from the archived coherent belt
guides. Its lower transition starts at seam-1.18 mm, inside the existing cap.
The upper edge overlaps the fixed landing by 0.04 mm. A thin outer overlap
stays within the current skin; final native bores are applied after the union.
These are modelling/print allowances, not published prototype measurements.

## Archived files and inspection

Open `inspection-view.scad` for separated pastel parts beside the assembly.
`bow-close.png` shows the former ledge/end region; `bow-inside.png` and
`bow-front.png` inspect the interior and the closed cathedral bow. All pictures
render the exact archived final STL. `fastener-section.scad` and the three
`print-rim-*.scad` wrappers retain the unchanged hidden-pin/printing views.

Use `export.sh` with an authorized absolute dated output directory. The new
lower was exported through repository `export_stl` into the conversation's
project destination `stl/2026/2026.11/2026.11.01/`. `raw/` retains that exact
unmodified tool output. Surface-preserving refinement removed four zero-area
facets, moving no vertices, deleting no components and filling no holes.
The generator, native SCAD, raw/final meshes, feedback, logs and reports are
hashed in `manifest.json`. Prior milestone files remain unchanged.

## Verification

The inherited regression and hidden-pin checks are retained. Additional
material probes verify that the former ledge region is now empty and that
plating continues across either side of its former X=58 mm end. The 24 probes
inside the former triangular bow openings must still contain material.
Checks compare the sampled external bottom and bow below the skirt band,
cover join, wall, stern rib and drain geometry. All unchanged component bytes
are compared to their parent. These finite tests and topology checks do not
certify global minimum wall thickness, production fidelity or physical fit.

Final reports pass: 564 inherited material probes, 482 additional material/fit probes, and the targeted end-face comparison. The previous X=58 end had twelve exposed triangles totalling 4.7002 mm²; the new mesh has none. All seven components pass topology checks, the 24 bow-closure probes remain solid, and the sampled bottom/exterior differences below the rim band remain zero.
