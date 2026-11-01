// Thin actual exported bow mating section; no generated substitute geometry.
boat_length_mm=340;
cut_x=boat_length_mm/2;
color([.95,.84,.67])intersection(){
 import(str("2026-11-01_sarepta_",boat_length_mm,"mm_lid_through_upper_bow.stl"),convexity=40);
 translate([cut_x-.25,-boat_length_mm,0])cube([.25,2*boat_length_mm,boat_length_mm]);
}
