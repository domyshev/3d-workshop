// Inspect the actual exported meshes. All translations below are display-only.
part="layout"; // [layout, assembly, upper, section]
$vpr=[65,0,35];$vpt=[85,25,15];$vpd=700;
module lower() {import("2026-10-31_sarepta_170mm_light_lower.stl",convexity=30);}
module upper() {import("2026-10-31_sarepta_170mm_light_upper.stl",convexity=30);}
module dashboard() {import("2026-10-31_sarepta_170mm_light_dashboard.stl",convexity=20);}
module pin() {import("2026-10-31_sarepta_170mm_light_pin.stl",convexity=10);}
color([0.67,0.67,0.67]) {
 if(part=="layout") {
  lower();
  translate([0,78,55.1173913043]) rotate([180,0,0]) upper();
  translate([25,-55,-22.7173913043]) dashboard();
  for(i=[0:3]) translate([100+i*5,-40,0]) pin();
 } else if(part=="assembly") {lower();upper();dashboard();}
 else if(part=="upper") rotate([180,0,0]) upper();
 else if(part=="section") difference() {
  union() {lower();upper();dashboard();}
  translate([-2,-40,-2]) cube([180,40,50]);
 }
}
