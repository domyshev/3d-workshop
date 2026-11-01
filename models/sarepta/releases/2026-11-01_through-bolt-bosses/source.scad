// Independent model-length and fixed-millimetre transverse glue-joint settings.
use <../2026-10-23_bow-plan-proportions/source.scad>
use <../2026-10-31_level-stern-ribs/belt.scad>
use <../2026-10-31_level-stern-ribs/source.scad>
include <stringer-guards.scad>
include <section-profile.scad>
include <locator-axes.scad>
include <front-axes.scad>
boat_length_mm=340;
part="assembly"; // [lower_bow,lower_stern,upper_bow,upper_stern,joint_pin,assembly,cavity_probe]
model_scale=boat_length_mm/170;
cut_x=boat_length_mm/2;
join_z=25*model_scale;
glue_land_width=6;
glue_axial_depth=4;
joint_bore_d=4.3;
joint_bore_depth=glue_axial_depth+.2;
joint_boss_radius=6;
joint_axis_inset=7;
joint_pin_d=4;
joint_pin_length=6;
module original(p){import(str("../2026-11-01_front-skirt-sockets/2026-11-01_sarepta_170mm_front_skirt_",p,".stl"),convexity=40);}
module section_transform(){multmatrix([[0,1,0,0],[0,0,1,0],[1,0,0,-cut_x],[0,0,0,1]])children();}
module cavity_section(){projection(cut=true)section_transform()scale(model_scale)safe_inner();}
module upper_section(){projection(cut=true)section_transform()scale(model_scale)original("upper");}
module extrude_joint(){
 multmatrix([[0,0,1,cut_x-glue_axial_depth],[1,0,0,0],[0,1,0,0],[0,0,0,1]])
  linear_extrude(height=2*glue_axial_depth)children();
}
module lower_land(){intersection(){
 extrude_joint()union(){
 difference(){offset(delta=.15)cavity_section();offset(delta=-glue_land_width)cavity_section();}
 // Circular local pads: 12 mm inward reach, bolt axes shifted 1 mm inward.
 for(p=[side_axis(-1,6),side_axis(1,6),bottom_axis(-1,6),bottom_axis(1,6)])translate(p)circle(r=joint_boss_radius,$fn=96);
}
 translate([-1,-boat_length_mm,-1])cube([boat_length_mm+2,2*boat_length_mm,join_z+1]);
}}
module upper_land(){intersection(){
 extrude_joint()offset(delta=glue_land_width)upper_section();
 scale(model_scale)belt_full_blank();
 translate([-1,-boat_length_mm,join_z])cube([boat_length_mm+2,2*boat_length_mm,boat_length_mm]);
}}
function floor_hits(y)=[for(i=[0:len(cavity_profile)-1])let(a=cavity_profile[i],b=cavity_profile[(i+1)%len(cavity_profile)])if(abs(b[0]-a[0])>1e-8 && y>=min(a[0],b[0]) && y<=max(a[0],b[0]))[a[1]+(y-a[0])*(b[1]-a[1])/(b[0]-a[0]),(b[1]-a[1])/(b[0]-a[0])]];
function side_hits(z)=[for(i=[0:len(cavity_profile)-1])let(a=cavity_profile[i],b=cavity_profile[(i+1)%len(cavity_profile)])if(abs(b[1]-a[1])>1e-8 && z>=min(a[1],b[1]) && z<=max(a[1],b[1]))[a[0]+(z-a[1])*(b[0]-a[0])/(b[1]-a[1]),(b[0]-a[0])/(b[1]-a[1])]];
function bottom_axis(side,inset=joint_axis_inset)=let(y=bottom_half_width_base/3,h=floor_hits(y),z=min([for(a=h)a[0]]),m=[for(a=h)if(abs(a[0]-z)<1e-6)a[1]][0])[side*y*model_scale,z*model_scale+inset*sqrt(1+m*m)];
function side_axis(side,inset=joint_axis_inset)=let(z=join_z-2.5-join_z/5,h=side_hits(z/model_scale),y=max([for(a=h)a[0]]),m=[for(a=h)if(abs(a[0]-y)<1e-6)a[1]][0])[side*(y*model_scale-inset*sqrt(1+m*m)),z];
function joint_axes()=[side_axis(-1),side_axis(1),bottom_axis(-1),bottom_axis(1)];
module joint_bores(){for(p=joint_axes()){
 translate([cut_x-joint_bore_depth,p[0],p[1]])rotate([0,90,0])cylinder(d=joint_bore_d,h=2*joint_bore_depth,$fn=64);
 translate([cut_x-.16,p[0],p[1]])rotate([0,90,0])cylinder(d1=joint_bore_d,d2=joint_bore_d+.3,h=.16,$fn=64);
 translate([cut_x,p[0],p[1]])rotate([0,90,0])cylinder(d1=joint_bore_d+.3,d2=joint_bore_d,h=.16,$fn=64);
}}
module split_clip(bow=true){translate([bow?-1:cut_x,-boat_length_mm,-1])cube([bow?cut_x+1:boat_length_mm-cut_x+1,2*boat_length_mm,boat_length_mm+1]);}
module obsolete_front_frame_cut(){
 // Remove only the last original transverse floor and side webs before the cut.
 // Keep original plating and the three longitudinal stringers.
 frame_x=2200*170/4600*model_scale;
 frame_half=(.65/2+.05)*model_scale;
 frame_top=(670*170/4600-120/4600*(2200*170/4600)+.1)*model_scale;
 difference(){
  intersection(){
   translate([frame_x-frame_half,-boat_length_mm,-1])cube([2*frame_half,2*boat_length_mm,frame_top+1]);
   scale(model_scale)intersection(){
    union(){safe_inner();translate([0,0,-.02])safe_inner();translate([0,.02,0])safe_inner();translate([0,-.02,0])safe_inner();}
    new_inner_envelope(1.18);
   }
  }
  for(g=stringer_guards)translate([frame_x-frame_half-.1,g[0]*model_scale,-1])
   cube([2*frame_half+.2,(g[1]-g[0])*model_scale,g[2]*model_scale+1]);
 }
}
module base_lower(){difference(){scale(model_scale)original("lower");obsolete_front_frame_cut();}}
module lower_piece(bow=true){intersection(){split_clip(bow);difference(){union(){base_lower();lower_land();}joint_bores();}}}
module upper_piece(bow=true){intersection(){split_clip(bow);union(){scale(model_scale)original("upper");upper_land();}}}
module joint_pin(){
 cylinder(d1=joint_pin_d-.4,d2=joint_pin_d,h=.2,$fn=48);
 translate([0,0,.2])cylinder(d=joint_pin_d,h=joint_pin_length-.4,$fn=48);
 translate([0,0,joint_pin_length-.2])cylinder(d1=joint_pin_d,d2=joint_pin_d-.4,h=.2,$fn=48);
}
module assembly(){
 color([.62,.78,.82])lower_piece(true);color([.70,.82,.83])lower_piece(false);
 color([.95,.84,.67])upper_piece(true);color([.96,.88,.75])upper_piece(false);
 color([.80,.71,.84])scale(model_scale){original("rim_bow");original("rim_port");original("rim_starboard");}
 color([.70,.80,.69])scale(model_scale){
  for(p=locator_axes,side=[-1,1])translate([p[0],side*(p[1]+.795),p[2]])rotate([side==1?90:-90,0,0])original("rim_pin");
  for(p=front_axes)translate([p[0]-.705*p[3],p[1]-.705*p[4],p[2]])rotate([0,90,atan2(p[4],p[3])])original("rim_pin");
 }
 color([.84,.73,.65])scale(model_scale)for(p=[[33,-23.6],[33,23.6],[160,-24.4],[160,24.4]])translate([p[0],p[1],24])original("pin");
 for(p=joint_axes())translate([cut_x,p[0],p[1]])bolt_preview();
}
if(part=="cavity_probe")linear_extrude(height=.1)cavity_section();
else if(part=="lower_bow")lower_piece(true);
else if(part=="lower_stern")lower_piece(false);
else if(part=="upper_bow")upper_piece(true);
else if(part=="upper_stern")upper_piece(false);
else if(part=="joint_pin")joint_pin();
else if(part=="assembly")assembly();

module bolt_preview(){
 color([.70,.72,.74])rotate([0,90,0]){
 translate([0,0,-8])cylinder(d=4,h=16,$fn=32);
 translate([0,0,-8])cylinder(d=7,h=4,$fn=48);
 translate([0,0,4])difference(){cylinder(d=7/cos(30),h=3.2,$fn=6);translate([0,0,-.1])cylinder(d=4,h=3.4,$fn=32);}
 }
}
