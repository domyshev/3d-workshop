// Two archived validated sizes. Use source.scad for another overall model length.
use <source.scad>
include <locator-axes.scad>
include <front-axes.scad>
include <section-profile.scad>
display_length_mm=is_undef(boat_length_mm)?340:boat_length_mm;
show_parts=true;
show_assembly=true;
s=display_length_mm/170;
cut_x=display_length_mm/2;
gap=35;
beam=59.13043594*s;
cover_row=beam+50;
$vpr=[58,0,30];$vpt=[display_length_mm*1.1,beam*.1,15*s];$vpd=display_length_mm*6;
module split_mesh(p){import(str("2026-11-01_sarepta_",display_length_mm,"mm_thin_bolt_joint_",p,".stl"),convexity=40);}
module old_mesh(p){import(str("../2026-11-01_front-skirt-sockets/2026-11-01_sarepta_170mm_front_skirt_",p,".stl"),convexity=40);}
module old_pins(){
 color([.70,.80,.69])scale(s){
  for(p=locator_axes,side=[-1,1])translate([p[0],side*(p[1]+.795),p[2]])rotate([side==1?90:-90,0,0])old_mesh("rim_pin");
  for(p=front_axes)translate([p[0]-.705*p[3],p[1]-.705*p[4],p[2]])rotate([0,90,atan2(p[4],p[3])])old_mesh("rim_pin");
 }
 color([.84,.73,.65])scale(s)for(p=[[33,-23.6],[33,23.6],[160,-24.4],[160,24.4]])translate([p[0],p[1],24])old_mesh("pin");
}
function inspection_axes() = display_length_mm==170 ? [[-18.37941860230095, 17.5], [18.37941860230095, 17.5], [-7.6723887125651045, 9.781696536299908], [7.6723887125651045, 9.781696536299908]] : [[-44.37819907727058, 37.5], [44.37819907727058, 37.5], [-15.344777425130209, 12.432450007350392], [15.344777425130209, 12.432450007350392]];
module complete(){
 color([.62,.78,.82])split_mesh("lower_bow");color([.70,.82,.83])split_mesh("lower_stern");
 color([.95,.84,.67])split_mesh("upper_bow");color([.96,.88,.75])split_mesh("upper_stern");
 color([.80,.71,.84])scale(s){old_mesh("rim_bow");old_mesh("rim_port");old_mesh("rim_starboard");}
 for(p=inspection_axes())translate([cut_x,p[0],p[1]])bolt_preview();
 old_pins();
}
if(show_parts){
 color([.62,.78,.82])split_mesh("lower_bow");
 color([.70,.82,.83])translate([gap,0,0])split_mesh("lower_stern");
 color([.95,.84,.67])translate([0,cover_row,30.5793476105*s])rotate([180,0,0])split_mesh("upper_bow");
 color([.96,.88,.75])translate([gap,cover_row,30.1173913043*s])rotate([180,0,0])split_mesh("upper_stern");
 color([.80,.71,.84]){
  translate([display_length_mm+90,0,0])scale(s)old_mesh("rim_bow");
  translate([display_length_mm+90,beam+40,0])scale(s)old_mesh("rim_port");
  translate([display_length_mm+90,2*beam+70,0])scale(s)old_mesh("rim_starboard");
 }
 for(i=[0:3])translate([display_length_mm+100+i*15,2*beam+110,8])bolt_preview();
 color([.70,.80,.69])for(i=[0:17])translate([display_length_mm+100+(i%9)*7*s,2*beam+140+floor(i/9)*7*s,0])scale(s)old_mesh("rim_pin");
 color([.84,.73,.65])for(i=[0:3])translate([display_length_mm+100+i*9*s,2*beam+190,0])scale(s)old_mesh("pin");
}
if(show_assembly)translate([0,-beam-85,0])complete();
