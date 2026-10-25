// Inspect exact exported meshes. Upper half is turned over only for display.
$vpr=[65,0,35];
$vpt=[85,45,14];
$vpd=650;
color([0.60,0.60,0.60])
    import("2026-10-25_sarepta_170mm_lower_locating.stl",convexity=30);
color([0.76,0.76,0.76])
    import("2026-10-25_sarepta_170mm_upper_locating.stl",convexity=30);
