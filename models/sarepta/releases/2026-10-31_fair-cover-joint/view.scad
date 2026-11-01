// Inspect the exact archived meshes, not a preview of live Boolean geometry.
part="assembly"; // [assembly, lower, upper, layout]
$vpr=[65,0,35]; $vpt=[85,0,15]; $vpd=420;
module lower() { import("2026-10-31_sarepta_170mm_fair_lower.stl",convexity=40); }
module upper() { import("2026-10-31_sarepta_170mm_fair_upper.stl",convexity=40); }
module dashboard() { import("2026-10-31_sarepta_170mm_fair_dashboard.stl",convexity=20); }
color([0.67,0.67,0.67]) {
 if(part=="assembly") { lower(); upper(); dashboard(); }
 else if(part=="lower") lower();
 else if(part=="upper") upper();
 else if(part=="layout") { lower(); translate([0,75,55.1173913043]) rotate([180,0,0]) upper(); }
}
