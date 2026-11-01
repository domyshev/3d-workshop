// Combined inspection: detached components and the complete assembly.
// All parts use the exact archived meshes at their original scale.
show_parts=true;
show_dashboard=false;
show_assembly=true;
cover_upside_down=true;
$vpr=[58,0,30]; $vpt=[125,-5,12]; $vpd=900;
hull_color=[0.62,0.78,0.82];
cover_color=[0.95,0.84,0.67];
panel_color=[0.66,0.80,0.69];
pin_color=[0.75,0.68,0.86];
module lower() { color(hull_color) import("2026-10-31_sarepta_170mm_open_bow_lower.stl",convexity=40); }
module upper() { color(cover_color) import("2026-10-31_sarepta_170mm_open_bow_upper.stl",convexity=40); }
module dashboard() { color(panel_color) import("2026-10-31_sarepta_170mm_open_bow_dashboard.stl",convexity=20); }
module pin() { color(pin_color) import("2026-10-31_sarepta_170mm_open_bow_pin.stl",convexity=10); }
module assembly() {
 lower(); upper(); if(show_dashboard) dashboard();
 for(axis=[[33,-23.6],[33,23.6],[160,-24.4],[160,24.4]])
  translate([axis[0],axis[1],24]) pin();
}
if(show_parts) {
 lower();
 if(cover_upside_down) translate([0,130,30.5793476105]) rotate([180,0,0]) upper();
 else translate([0,130,-25]) upper();
 if(show_dashboard) translate([165,55,-22.7173919678]) dashboard();
 for(i=[0:3]) translate([215+i*12,-15,0]) pin();
}
if(show_assembly) translate([0,-140,0]) assembly();
