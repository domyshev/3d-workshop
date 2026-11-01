// Archived actual STL meshes: separated parts beside the assembled model.
include <locator-axes.scad>
show_parts=true;
show_assembly=true;
cover_upside_down=true;
$vpr=[58,0,30];$vpt=[160,-5,12];$vpd=1050;
module mesh(p){import(str("2026-11-01_sarepta_170mm_hinge_",p,".stl"),convexity=40);}
module lower(){color([.62,.78,.82])mesh("lower");}
module upper(){color([.95,.84,.67])mesh("upper");}
module skirt(p){color([.80,.71,.84])mesh(p);}
module peg(){color([.70,.80,.69])mesh("rim_pin");}
module cover_pin(){color([.84,.73,.65])mesh("pin");}
module assembly(){
 lower();upper();skirt("rim_bow");skirt("rim_port");skirt("rim_starboard");
 for(p=locator_axes,side=[-1,1])translate([p[0],side*(p[1]+.795),p[2]])rotate([side==1?90:-90,0,0])peg();
 for(p=[[33,-23.6],[33,23.6],[160,-24.4],[160,24.4]])translate([p[0],p[1],24])cover_pin();
}
if(show_parts){
 lower();
 if(cover_upside_down)translate([0,115,30.5793476105])rotate([180,0,0])upper();
 else translate([0,115,-25])upper();
 translate([215,0,0])skirt("rim_bow");
 translate([215,110,0])skirt("rim_port");
 translate([215,110,0])skirt("rim_starboard");
 for(i=[0:13])translate([225+(i%7)*6,175+floor(i/7)*6,0])peg();
 for(i=[0:3])translate([300+i*6,175,0])cover_pin();
}
if(show_assembly)translate([0,-140,0])assembly();
