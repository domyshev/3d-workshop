// Split the accepted 170 mm mesh without changing its exterior geometry.
// The mating plane sits 0.08 mm below the protective rim to avoid coincident mesh faces.
part = "assembly"; // [assembly, lower, upper, exploded]
seam_slope = -120/4600;
seam_intercept = 670*170/4600-1.2-0.08;
exploded_gap_mm = 12;
module accepted_mesh() {
    import("releases/2026-10-23_bow-plan-proportions/2026-10-23_sarepta_hull_170mm_bow_proportions.stl",convexity=30);
}
module plane_halfspace() {
    multmatrix([[1,0,0,0],[0,1,0,0],
        [seam_slope,0,1,seam_intercept],[0,0,0,1]])
        translate([-10,-50,0]) cube([190,100,80]);
}
// The boxed inner returns hang from the upper cabin landings. Keep them
// whole with the upper part instead of producing two loose triangular slivers.
module above_seam() {
    union() {
        plane_halfspace();
        for(side=[-1,1])
            translate([1600*170/4600+0.035-0.002,
                side==1 ? 560*170/4600+0.025-0.002 : -560*170/4600-1.2-0.025-0.002,
                550*170/4600+0.035-0.002])
                cube([2400*170/4600-0.07+0.004,1.204,200*170/4600-0.07+0.004]);
    }
}
module lower() { difference() { accepted_mesh(); above_seam(); } }
module upper() { intersection() { accepted_mesh(); above_seam(); } }
if(part=="lower") color([0.68,0.68,0.68]) lower();
else if(part=="upper") color([0.68,0.68,0.68]) upper();
else if(part=="assembly" || part=="exploded") {
    color([0.60,0.60,0.60]) lower();
    translate([0,0,part=="exploded"?exploded_gap_mm:0])
        color([0.76,0.76,0.76]) upper();
} else assert(false,"Unknown split part selector.");
