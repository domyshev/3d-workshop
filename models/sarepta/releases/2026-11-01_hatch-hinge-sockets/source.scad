// Vertical top-entry blind sockets for future forward hatch hinges, model mm.
use <../2026-11-01_fair-bow-root/source.scad>
part="assembly"; // [lower,upper,pin,rim_bow,rim_port,rim_starboard,rim_pin,assembly,layout]
roof_z=750*170/4600+2.4;
pad_z=roof_z+12.5*170/4600;
hinge_axes=[[32.2,-5],[32.2,5]];
hinge_bore_d=2.0;
hinge_boss_d=4.4;
hinge_total_depth=3.2;
hinge_bottom_skin=0.4;
hinge_boss_bottom=pad_z-hinge_total_depth;
hinge_socket_floor=hinge_boss_bottom+hinge_bottom_skin;
module original_upper(){import("../2026-11-01_fair-bow-root/2026-11-01_sarepta_170mm_fair_root_upper.stl",convexity=40);}
module hinge_bosses(){
 // Solid cylinders reach 0.2 mm into the existing roof skin, filling old voids.
 for(p=hinge_axes)translate([p[0],p[1],hinge_boss_bottom])
  cylinder(d=hinge_boss_d,h=roof_z-0.8-hinge_boss_bottom,$fn=80);
}
module hinge_bores(){
 for(p=hinge_axes)translate([p[0],p[1],hinge_socket_floor])
  cylinder(d=hinge_bore_d,h=pad_z-hinge_socket_floor+0.2,$fn=80);
}
module upper(){difference(){union(){original_upper();hinge_bosses();}hinge_bores();}}
module assembly(){
 color([.62,.78,.82])lower();
 color([.95,.84,.67])upper();
 color([.80,.71,.84]){rim_bow();rim_port();rim_starboard();}
 color([.70,.80,.69])fitted_pins();
}
if(part=="upper")upper();
else if(part=="lower")lower();
else if(part=="pin")pin();
else if(part=="rim_bow")rim_bow();
else if(part=="rim_port")rim_port();
else if(part=="rim_starboard")rim_starboard();
else if(part=="rim_pin")rim_pin();
else if(part=="assembly")assembly();
else if(part=="layout"){
 color([.62,.78,.82])lower();
 color([.95,.84,.67])translate([0,115,30.5793476105])rotate([180,0,0])upper();
 translate([0,-140,0])assembly();
}
