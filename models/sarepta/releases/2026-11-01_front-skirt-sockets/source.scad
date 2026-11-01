// Matching blind sockets on both forward V faces, with fully hidden headless pins.
use <../2026-11-01_hatch-hinge-sockets/source.scad>
include <front-axes.scad>
part="assembly"; // [lower,upper,pin,rim_bow,rim_port,rim_starboard,rim_pin,assembly,layout]
module front_axis(p,d=0){
 translate([p[0]+d*p[3],p[1]+d*p[4],p[2]])
  rotate([0,90,atan2(p[4],p[3])])children();
}
module new_body_sockets(){for(p=front_axes)front_axis(p,-.98)cylinder(d=1,h=1.13,$fn=64);}
module new_skirt_sockets(){for(p=front_axes)front_axis(p,-.15)cylinder(d=1,h=1.07,$fn=64);}
module lower(){difference(){
 import("../2026-11-01_hatch-hinge-sockets/2026-11-01_sarepta_170mm_hinge_lower.stl",convexity=40);
 new_body_sockets();
}}
module rim_bow(){difference(){
 import("../2026-11-01_hatch-hinge-sockets/2026-11-01_sarepta_170mm_hinge_rim_bow.stl",convexity=40);
 new_skirt_sockets();
}}
module new_front_pins(){for(p=front_axes)front_axis(p,-.705)rim_pin();}
module assembly(){
 color([.62,.78,.82])lower();
 color([.95,.84,.67])upper();
 color([.80,.71,.84]){rim_bow();rim_port();rim_starboard();}
 color([.70,.80,.69]){fitted_pins();new_front_pins();}
}
if(part=="lower")lower();
else if(part=="rim_bow")rim_bow();
else if(part=="upper")upper();
else if(part=="pin")pin();
else if(part=="rim_port")rim_port();
else if(part=="rim_starboard")rim_starboard();
else if(part=="rim_pin")rim_pin();
else if(part=="assembly")assembly();
else if(part=="layout"){
 color([.62,.78,.82])lower();
 color([.95,.84,.67])translate([0,115,30.5793476105])rotate([180,0,0])upper();
 translate([0,-140,0])assembly();
}
