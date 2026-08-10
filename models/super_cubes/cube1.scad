// Chamfered cube and a separate M8 threaded cylinder.

use <../../lib/core/threads/threads.scad>

// Export selector: "all", "cube", or "threaded_cylinder".
part = "all";

cube_size = 20;
chamfer = 1.2;

thread_diameter = 8;
thread_length = 20;
thread_pitch = 1.25; // Standard coarse pitch for M8.
hex_key_size = 5;    // Distance across flats.
hex_socket_depth = 8;
thread_hole_depth = 8;
thread_fit_clearance = 0.4; // Diametral clearance for FDM printing.
part_gap = 5;
cut_epsilon = 0.05;

cube_color = "#DDE8B0";   // Pale pistachio.
thread_color = "#8B5A2B"; // Brown.

module octahedron(radius) {
    polyhedron(
        points = [
            [ radius,       0,       0],
            [-radius,       0,       0],
            [      0,  radius,       0],
            [      0, -radius,       0],
            [      0,       0,  radius],
            [      0,       0, -radius]
        ],
        faces = [
            [0, 2, 4], [2, 1, 4], [1, 3, 4], [3, 0, 4],
            [2, 0, 5], [1, 2, 5], [3, 1, 5], [0, 3, 5]
        ],
        convexity = 2
    );
}

module chamfered_cube(size, edge_chamfer) {
    assert(size > 2 * edge_chamfer,
        "Chamfer must be smaller than half the cube size");

    minkowski() {
        cube(size - 2 * edge_chamfer, center = true);
        octahedron(edge_chamfer);
    }
}

module internal_thread_cutter() {
    if ($preview) {
        // Keep F5 responsive: full threads create an oversized OpenCSG tree.
        cylinder(
            d = thread_diameter + thread_fit_clearance,
            h = thread_hole_depth + cut_epsilon,
            $fn = 48
        );
    } else {
        metric_thread(
            diameter = thread_diameter + thread_fit_clearance,
            pitch = thread_pitch,
            length = thread_hole_depth + cut_epsilon,
            internal = true,
            leadin = 3
        );
    }
}

module chamfered_cube_with_threaded_holes(size, edge_chamfer) {
    face = size / 2;
    inner_core_size = size - 2 * thread_hole_depth;

    assert(inner_core_size >= 0,
        "Thread holes cannot be deeper than half the cube size");

    difference() {
        chamfered_cube(size, edge_chamfer);

        // Holes centered on the +Z and -Z faces.
        translate([0, 0, face + cut_epsilon])
            rotate([180, 0, 0])
                internal_thread_cutter();
        translate([0, 0, -face - cut_epsilon])
            internal_thread_cutter();

        // Holes centered on the +X and -X faces.
        translate([face + cut_epsilon, 0, 0])
            rotate([0, -90, 0])
                internal_thread_cutter();
        translate([-face - cut_epsilon, 0, 0])
            rotate([0, 90, 0])
                internal_thread_cutter();

        // Holes centered on the +Y and -Y faces.
        translate([0, face + cut_epsilon, 0])
            rotate([90, 0, 0])
                internal_thread_cutter();
        translate([0, -face - cut_epsilon, 0])
            rotate([-90, 0, 0])
                internal_thread_cutter();

        // Remove the core isolated by the six opposing holes.
        if (inner_core_size > 0)
            cube(
                inner_core_size + 2 * cut_epsilon,
                center = true
            );
    }
}

module hex_socket(size_across_flats, depth) {
    cylinder(
        h = depth,
        r = size_across_flats / sqrt(3),
        $fn = 6
    );
}

module threaded_cylinder_with_hex_sockets() {
    difference() {
        if ($preview) {
            // Smooth stand-in for fast F5 preview.
            cylinder(
                d = thread_diameter,
                h = thread_length,
                $fn = 48
            );
        } else {
            metric_thread(
                diameter = thread_diameter,
                pitch = thread_pitch,
                length = thread_length,
                internal = false,
                leadin = 2
            );
        }

        // Socket in the bottom end.
        translate([0, 0, -cut_epsilon])
            hex_socket(
                hex_key_size,
                hex_socket_depth + cut_epsilon
            );

        // Socket in the top end.
        translate([
            0,
            0,
            thread_length - hex_socket_depth
        ])
            hex_socket(
                hex_key_size,
                hex_socket_depth + cut_epsilon
            );
    }
}

module printable_cube() {
    color(cube_color)
        translate([0, 0, cube_size / 2])
            chamfered_cube_with_threaded_holes(cube_size, chamfer);
}

module printable_threaded_cylinder() {
    color(thread_color)
        threaded_cylinder_with_hex_sockets();
}

assert(
    part == "all" || part == "cube" || part == "threaded_cylinder",
    str("Unknown part: ", part)
);

if (part == "all") {
    printable_cube();

    // Assembly view: place the vertical cylinder beside the cube.
    translate([
        cube_size / 2 + part_gap + thread_diameter / 2,
        0,
        0
    ])
        printable_threaded_cylinder();
} else if (part == "cube") {
    printable_cube();
} else if (part == "threaded_cylinder") {
    printable_threaded_cylinder();
}
