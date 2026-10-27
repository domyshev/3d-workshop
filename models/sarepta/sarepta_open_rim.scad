// Restore interior access while keeping a horizontal 4 mm glue rim.
use <releases/2026-10-23_bow-plan-proportions/source.scad>
use <releases/2026-10-27_horizontal-reinforced/source.scad>
part = "side_by_side"; // [lower, upper, assembly, side_by_side]
join_z_mm=25;
rim_width_mm=4;
sf=170/4600;
pin_centres=[[33,-17],[33,17],[160,-22],[160,22]];
$vpr=[65,0,35];$vpt=[85,45,15];$vpd=650;
module parent_lower() {
    import("releases/2026-10-27_horizontal-reinforced/2026-10-27_sarepta_170mm_horizontal_lower.stl",convexity=30);
}
module upper() {
    // The accepted non-pocketed cover, including the four sockets, is unchanged.
    import("releases/2026-10-27_horizontal-reinforced/2026-10-27_sarepta_170mm_horizontal_upper.stl",convexity=30);
}
module open_plan() { offset(delta=-rim_width_mm) landing_outer_plan(); }
module protected_seats() {
    // Retain the blind sockets and their original 0.8 mm bottom allowance.
    for(p=pin_centres) translate([p[0],p[1],20])
        cylinder(r=3.22,h=20,$fn=64);
    // Two small foredeck lugs connect the sockets to the continuous rim.
    for(side=[-1,1]) translate([31.8,side==1?17:-26,23.4])
        cube([2.4,9,16.6]);
}
// Limit the cached sweep to the forward region; keep the original guide mesh.
module sweep_seed() {
    intersection() {
        parent_lower();
        translate([0,-30,-1]) cube([1400*sf-1.2,60,27]);
    }
}
module sweep_up(level=5) {
    // Cached doubling makes a 32-position vertical sweep in five unions.
    // The 0.8 mm step is less than the retained original skin thickness.
    if(level==0) sweep_seed();
    else union() {
        sweep_up(level-1);
        translate([0,0,0.8*pow(2,level-1)]) sweep_up(level-1);
    }
}
module forward_inner() {
    // Upward-only sweep cannot reach the first 1.6 mm above the old exterior.
    translate([0,0,1.6]) sweep_up();
}
module access_cut() {
    difference() {
        intersection() {
            translate([0,0,-1]) linear_extrude(height=62) open_plan();
            union() {
                // The main cockpit has real bottom skin well below this cut.
                translate([1400*sf-1.2,-40,23.35]) cube([172,80,40]);
                intersection() {
                    translate([-1,-40,-1]) cube([1400*sf-1.2+1,80,62]);
                    forward_inner();
                }
                // Clear the old nose sheet over the leg-space shelf, retaining
                // the shelf and sealed lower locker wall beneath it.
                intersection() {
                    translate([1400*sf-1.2,-40,-1]) cube([200*sf,80,62]);
                    multmatrix([[1,0,0,0],[0,1,0,0],
                        [-120/4600,0,1,670*sf-1.4],[0,0,0,1]])
                        translate([-1,-40,0]) cube([172,80,60]);
                }
            }
        }
        protected_seats();
    }
}
module old_return_cuts() {
    // Old boxed inner returns lie farther inward than the new 4 mm rim.
    // Remove these suspended walls without changing the transverse frame webs.
    for(side=[-1,1]) translate([1600*sf+0.035-0.005,
        side==1?560*sf+0.025-0.005:-560*sf-1.2-0.025-0.005,
        550*sf+0.035-0.005]) cube([2400*sf-0.07+0.01,1.21,10]);
}
module lower() { difference() {parent_lower();access_cut();old_return_cuts();} }
if(part=="lower") color([0.68,0.68,0.68]) lower();
else if(part=="upper") color([0.68,0.68,0.68]) upper();
else if(part=="assembly" || part=="side_by_side") {
    color([0.60,0.60,0.60]) lower();
    if(part=="side_by_side") translate([0,90,55]) rotate([180,0,0])
        color([0.76,0.76,0.76]) upper();
    else color([0.76,0.76,0.76]) upper();
} else assert(false,"Unknown open-rim part selector.");
