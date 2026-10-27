// Actual STL comparison, mating faces upward; display transforms only.
$vpr=[65,0,35]; $vpt=[85,45,15]; $vpd=650;
color([0.60,0.60,0.60]) translate([0,0,55]) rotate([180,0,0])
    import("../2026-10-27_horizontal-reinforced/2026-10-27_sarepta_170mm_horizontal_upper.stl",convexity=30);
color([0.76,0.76,0.76]) translate([0,90,55]) rotate([180,0,0])
    import("2026-10-27_sarepta_170mm_upper_pockets_study.stl",convexity=30);
