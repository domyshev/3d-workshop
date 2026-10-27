// Inspect the exact exported meshes; both adhesive surfaces are horizontal.
$vpr=[65,0,35];
$vpt=[85,0,15];
$vpd=430;
color([0.60,0.60,0.60]) import("2026-10-27_sarepta_170mm_horizontal_lower.stl",convexity=30);
 color([0.76,0.76,0.76])
    import("2026-10-27_sarepta_170mm_horizontal_upper.stl",convexity=30);
