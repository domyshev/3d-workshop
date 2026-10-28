// Actual exported parts, separated only for viewing.
$vpr=[65,0,35];$vpt=[85,0,13];$vpd=850;
color([0.67,0.67,0.67]) import("2026-10-28_sarepta_170mm_service_lower.stl",convexity=30);
translate([0,85,55]) rotate([180,0,0]) color([0.67,0.67,0.67]) import("2026-10-28_sarepta_170mm_service_upper.stl",convexity=30);
translate([35,-60,-20.3260869565]) color([0.67,0.67,0.67]) import("2026-10-28_sarepta_170mm_service_dashboard.stl",convexity=30);
translate([35,-80,-17.9260869565]) color([0.67,0.67,0.67]) import("2026-10-28_sarepta_170mm_service_retainer.stl",convexity=30);
