// Pastel inspection layout of the printed modular grid and its fasteners.
// Colours are visible in OpenSCAD preview; STL exports geometry only.
// The stud is laid on its side for inspection, not print orientation.
color([0.69, 0.80, 0.85])
    import("parts/grid80.stl", convexity = 10);

color([0.91, 0.77, 0.62])
    translate([92, 58, 2.925]) rotate([0, 90, 0])
        import("parts/stud28.stl", convexity = 10);

color([0.76, 0.70, 0.84])
    translate([106, 30, 0])
        import("parts/knob6.stl", convexity = 10);
