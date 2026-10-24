// Display the exact exported split meshes in their assembly coordinates.
$vpr=[65,0,35];
$vpt=[85,0,18];
$vpd=390;
color([0.60,0.60,0.60]) import("2026-10-24_sarepta_170mm_lower.stl",convexity=30);
translate([0,0,0]) color([0.76,0.76,0.76])
    import("2026-10-24_sarepta_170mm_upper.stl",convexity=30);
