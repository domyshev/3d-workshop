// Closed bow plating with loose headless pins hidden in two blind pockets.
use <../2026-10-23_bow-plan-proportions/source.scad>
use <../2026-10-31_level-stern-ribs/source.scad>
use <../2026-10-31_level-stern-ribs/belt.scad>
include <clearance.scad>
include <interface.scad>
include <locator-axes.scad>
part="assembly"; // [lower,upper,rim_bow,rim_port,rim_starboard,rim_pin,pin,assembly,layout]
join_x=58;
segment_gap=0.2;
locator_d=0.8;
locator_bore=1.0;
locator_depth=0.95;
locator_length=1.5;
skirt_socket_depth=0.8;
module parent_lower(){import("../2026-10-31_clean-bow-floor/2026-10-31_sarepta_170mm_clean_bow_lower.stl",convexity=40);}
module seam_slab(bottom=-1.22,top=0.05){on_seam(bottom) translate([-5,-40,0]) cube([180,80,top-bottom]);}
module rim_mask(){difference(){seam_slab();interface_blank();}}
module bow_board_root(){
 // Preserve the original cathedral-bow cap. Extend the board's root down to
 // its existing underside instead of cutting through the cap into the tunnels.
 difference(){
  intersection(){
   clearance_blank();
   on_seam(-1.18) translate([-5,-40,0])cube([63,80,0.66]);
  }
  translate([0,0,-5])linear_extrude(height=40)offset(delta=0.02)rim_open_plan();
 }
}
module side_axis(p,side,start_y){
 translate([p[0],side*start_y,p[2]]) rotate([side==1?90:-90,0,0]) children();
}
module hull_sockets(){for(p=locator_axes,side=[-1,1]){
 side_axis(p,side,p[1]+0.15) cylinder(d=locator_bore,h=locator_depth+0.15,$fn=48);
 side_axis(p,side,p[1]+0.02) cylinder(d1=1.12,d2=locator_bore,h=0.15,$fn=48);
}}
module rim_sockets(){for(p=locator_axes,side=[-1,1])
 // Open only on the hidden inner face. A solid outside wall remains intact.
 translate([p[0],side*(p[1]+0.10),p[2]])rotate([side==1?-90:90,0,0])
  cylinder(d=locator_bore,h=skirt_socket_depth+0.02,$fn=48);
}
module lower(){difference(){union(){parent_lower();bow_board_root();}rim_mask();hull_sockets();}}
module rim_shell(){difference(){intersection(){parent_lower();seam_slab();}clearance_blank();rim_sockets();}}
module rim_bow(){intersection(){rim_shell();translate([-5,-40,-1]) cube([join_x+5-segment_gap/2,80,40]);}}
module rim_port(){intersection(){rim_shell();translate([join_x+segment_gap/2,-40,-1]) cube([180-join_x,40,40]);}}
module rim_starboard(){intersection(){rim_shell();translate([join_x+segment_gap/2,0,-1]) cube([180-join_x,40,40]);}}
module rim_pin(){
 // Headless, with a small lead-in at each end; both ends remain hidden.
 cylinder(d1=0.55,d2=locator_d,h=0.2,$fn=48);
 translate([0,0,0.2])cylinder(d=locator_d,h=locator_length-0.4,$fn=48);
 translate([0,0,locator_length-0.2])cylinder(d1=locator_d,d2=0.55,h=0.2,$fn=48);
}
module fitted_pins(){for(p=locator_axes,side=[-1,1]) side_axis(p,side,p[1]+0.795) rim_pin();}
module assembly(){
 color([0.62,0.78,0.82]) lower();
 color([0.95,0.84,0.67]) upper();
 color([0.80,0.71,0.84]) {rim_bow();rim_port();rim_starboard();}
 color([0.70,0.80,0.69]) fitted_pins();
}
if(part=="lower")lower();
else if(part=="upper")upper();
else if(part=="pin")pin();
else if(part=="rim_bow")rim_bow();
else if(part=="rim_port")rim_port();
else if(part=="rim_starboard")rim_starboard();
else if(part=="rim_pin")rim_pin();
else if(part=="assembly")assembly();
else if(part=="layout"){
 color([0.62,0.78,0.82]) lower();
 color([0.95,0.84,0.67]) translate([0,115,30.5793476105]) rotate([180,0,0]) upper();
 color([0.80,0.71,0.84]) {translate([0,215,0])rim_bow();translate([0,235,0])rim_port();translate([0,295,0])rim_starboard();}
 for(i=[0:13])color([0.70,0.80,0.69])translate([195+(i%7)*6,65+floor(i/7)*6,0])rim_pin();
 translate([0,-140,0]) assembly();
}
