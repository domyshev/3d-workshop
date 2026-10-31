# Level stern ribs and aligned drains — 2026-10-31

Replace the three sloping transom knees with horizontal ribs. Their upper plane
is Z=220*170/4600=8.130435 mm, matching the transverse floor webs. Visible ribs
run from the aft face of the last transverse floor at X=162.4 mm to the transom.
A 0.1 mm internal overlap starts at X=162.3; nothing projects into the forward bay.
The three 0.65 mm ribs are centred on Y=-12.934783, 0 and +12.934783 mm.

Two unchanged 2.217391 mm diameter drains are centred above the outer ribs.
Their lower edge is Z=8.930435 mm, 0.8 mm above the common rib top; their centre
is Z=10.039130 mm. Earlier outlet locations are filled. The nominal inner transom
face is X=168 mm; the old triangular knee tails are cleared up to that face.
The new ribs overlap the wall internally by 0.05 mm for a sound Boolean join.

The upper cover, hidden reference dashboard and pins are byte-identical copies
of the open-bow revision. The combined pastel inspection remains the default.
`verification.json` records mesh-derived equal rib-top heights, drain-edge gap,
empty forward-overhang probes, contact with the last floor, unchanged external
bow and bottom comparisons, guide fit samples and mesh topology checks. All pass.
This is digital verification; no new physical print or fit has been checked.

`raw/` preserves the unmodified lower export from the repository tool. Final
mesh refinement removes collapsed zero-area facets and splits exact collinear
T-junctions without moving vertices or filling holes. Construction and referenced
parent releases are preserved, as are the unchanged component meshes.
