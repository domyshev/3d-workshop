boat_length_mm=340;
s=boat_length_mm/170;cut_x=boat_length_mm/2;spacing=59.13043594*s+35;
module face(part,bow=true){intersection(){
 import(str("2026-11-01_sarepta_",boat_length_mm,"mm_full_lid_tab_",part,".stl"),convexity=40);
 translate([bow?cut_x-.25:cut_x,-boat_length_mm,-1])cube([.25,2*boat_length_mm,boat_length_mm]);
}}
color([.62,.78,.82])face("lower_bow",true);
color([.70,.82,.83])translate([2*cut_x,spacing,0])mirror([1,0,0])face("lower_stern",false);
