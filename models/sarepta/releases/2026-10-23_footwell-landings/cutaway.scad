// Longitudinal centre section of the exact archived STL; voids remain visible.
color([0.68,0.68,0.68]) intersection() {
    import("2026-10-23_sarepta_hull_80mm_interior_detail.stl",convexity=30);
    translate([-1,-0.025,-1]) cube([82,0.05,62]);
}
