// Horizontal adhesive interface and reinforced bow for the 170 mm model.
// Uses the accepted reconstruction as an immutable parent, not new factory data.
use <../2026-10-23_bow-plan-proportions/source.scad>
part = "side_by_side"; // [lower, upper, pin, assembly, exploded, side_by_side]
join_z_mm = 25;
upper_raise_mm = 2.4;
landing_thickness_mm = 1.6;
socket_diameter_mm = 4.25;
socket_depth_mm = 4.2;
pad_diameter_mm = 6.4;
pad_depth_mm = 5;
socket_centres = [[33,-17],[33,17],[160,-22],[160,22]];
sf = 170/4600;
$vpr=[65,0,35];
$vpt=[85,45,15];
$vpd=650;
module accepted_mesh() {
    import("../2026-10-23_bow-plan-proportions/2026-10-23_sarepta_hull_170mm_bow_proportions.stl",convexity=30);
}
module above_join() { translate([-10,-50,join_z_mm]) cube([190,100,80]); }
// Continuous foredeck and side landing, with intended openings retained.
module landing_openings() {
    translate([1600*sf,-560*sf,-10]) cube([2400*sf,1120*sf,90]);
    translate([4000*sf+1.2,-560*sf,-10]) cube([40,1120*sf,90]);
    // Keep the hatch open through the new landing and raised band.
    translate([0,0,-10]) linear_extrude(height=90) projection() hatch_opening();
}
module landing_outer_plan() {
    // A small inward offset keeps the added band clear of rounded STL skins.
    offset(delta=-0.04) projection(cut=true)
        translate([0,0,-join_z_mm]) upper_volume();
}
module landing_plan() {
    difference() {
        landing_outer_plan();
        projection() landing_openings();
    }
}
module reinforced_landing() {
    // This inset horizontal cap stays inside the inward-flared upper sides.
    // Its complete front sheet transfers bow stiffness to the lower half.
    translate([0,0,join_z_mm-landing_thickness_mm])
        linear_extrude(height=landing_thickness_mm+0.02) landing_plan();
}
module modified_blank() {
    union() {
        difference() { accepted_mesh(); above_join(); }
        translate([0,0,upper_raise_mm])
            intersection() { accepted_mesh(); above_join(); }
        // Positive overlap avoids a coincident Boolean joint at either end.
        translate([0,0,join_z_mm-0.02])
            linear_extrude(height=upper_raise_mm+0.04) landing_plan();
        reinforced_landing();
        for(p=socket_centres)
            translate([p[0],p[1],join_z_mm-pad_depth_mm])
                cylinder(d=pad_diameter_mm,h=2*pad_depth_mm,$fn=64);
    }
}
module complete_assembly() {
    difference() {
        modified_blank();
        for(p=socket_centres)
            translate([p[0],p[1],join_z_mm-socket_depth_mm])
                cylinder(d=socket_diameter_mm,h=2*socket_depth_mm,$fn=64);
    }
}
module lower() { difference() { complete_assembly(); above_join(); } }
module upper() { intersection() { complete_assembly(); above_join(); } }
module pin() {
    import("../2026-10-25_locating-pins/2026-10-25_sarepta_locating_pin_4x8.stl",convexity=10);
}
if(part=="lower") color([0.68,0.68,0.68]) lower();
else if(part=="upper") color([0.68,0.68,0.68]) upper();
else if(part=="pin") color([0.68,0.68,0.68]) pin();
else if(part=="assembly" || part=="exploded" || part=="side_by_side") {
    color([0.60,0.60,0.60]) lower();
    if(part=="side_by_side")
        translate([0,90,55]) rotate([180,0,0]) color([0.76,0.76,0.76]) upper();
    else translate([0,0,part=="exploded"?15:0]) color([0.76,0.76,0.76]) upper();
} else assert(false,"Unknown horizontal split part selector.");
