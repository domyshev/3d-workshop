// Centre section of the actual archived STL.
color([0.68,0.68,0.68]) intersection() {
    import("2026-10-23_sarepta_hull_80mm_bow_proportions.stl",convexity=30);
    translate([-1,-0.025,-1]) cube([82,0.05,62]);
}
