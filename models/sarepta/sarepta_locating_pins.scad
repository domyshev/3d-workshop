// Four blind locating sockets for the accepted 170 mm split hull.
// Prototype hull dimensions are unchanged; socket pads are internal additions.
part = "side_by_side"; // [lower, upper, pin, assembly, exploded, side_by_side, socket_section]
seam_slope = -120/4600;
seam_intercept = 670*170/4600-1.28;
pin_diameter_mm = 4;
pin_length_mm = 8;
socket_diameter_mm = 4.25;
socket_depth_mm = 4.2;
pad_diameter_mm = 6.4;
pad_depth_mm = 5.0;
// Bow pair is moved aft from the thin tip to retain the external bottom skin.
socket_centres = [[33,-17],[33,17],[160,-22],[160,22]];
normal_angle = atan(-seam_slope);
$vpr=[65,0,35];
$vpt=[85,45,14];
$vpd=650;
module accepted_mesh() {
    import("releases/2026-10-23_bow-plan-proportions/2026-10-23_sarepta_hull_170mm_bow_proportions.stl",convexity=30);
}
// Preserve the accepted split ownership, including the complete inner returns.
module upper_mask() {
    union() {
        multmatrix([[1,0,0,0],[0,1,0,0],
            [seam_slope,0,1,seam_intercept],[0,0,0,1]])
            translate([-10,-50,0]) cube([190,100,80]);
        for(side=[-1,1])
            translate([1600*170/4600+0.035-0.002,
                side==1 ? 560*170/4600+0.025-0.002 : -560*170/4600-1.2-0.025-0.002,
                550*170/4600+0.035-0.002])
                cube([2400*170/4600-0.07+0.004,1.204,200*170/4600-0.07+0.004]);
    }
}
module at_socket(p) {
    translate([p[0],p[1],seam_intercept+seam_slope*p[0]])
        rotate([0,normal_angle,0]) children();
}
// Add and bore full pads before partitioning. This avoids coplanar Boolean
// unions at the seam of the two already-rounded imported half meshes.
module enhanced_assembly() {
    difference() {
        union() {
            accepted_mesh();
            for(p=socket_centres) at_socket(p)
                translate([0,0,-pad_depth_mm])
                    cylinder(d=pad_diameter_mm,h=2*pad_depth_mm,$fn=64);
        }
        for(p=socket_centres) at_socket(p)
            translate([0,0,-socket_depth_mm])
                cylinder(d=socket_diameter_mm,h=2*socket_depth_mm,$fn=64);
    }
}
module lower() { difference() { enhanced_assembly(); upper_mask(); } }
module upper() { intersection() { enhanced_assembly(); upper_mask(); } }
module pin() {
    // Overall length includes two 0.35 mm insertion chamfers.
    cylinder(d1=pin_diameter_mm-0.7,d2=pin_diameter_mm,h=0.35,$fn=64);
    translate([0,0,0.35]) cylinder(d=pin_diameter_mm,h=pin_length_mm-0.7,$fn=64);
    translate([0,0,pin_length_mm-0.35])
        cylinder(d1=pin_diameter_mm,d2=pin_diameter_mm-0.7,h=0.35,$fn=64);
}
if(part=="lower") color([0.68,0.68,0.68]) lower();
else if(part=="upper") color([0.68,0.68,0.68]) upper();
else if(part=="pin") color([0.68,0.68,0.68]) pin();
else if(part=="assembly" || part=="exploded" || part=="side_by_side") {
    color([0.60,0.60,0.60]) lower();
    if(part=="side_by_side")
        translate([0,90,48]) rotate([180,0,0]) color([0.76,0.76,0.76]) upper();
    else translate([0,0,part=="exploded"?15:0]) color([0.76,0.76,0.76]) upper();
} else if(part=="socket_section") {
    // Centre section through one forward socket and both unseparated parts.
    intersection() {
        union() {lower();upper();}
        translate([29.5,16.95,0]) cube([7,0.1,35]);
    }
} else assert(false,"Unknown locating-pin part selector.");
