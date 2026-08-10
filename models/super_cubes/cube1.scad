// Chamfered cube and a separate M8 threaded cylinder.

use <../../lib/core/threads/threads.scad>

cube_size = 20;
chamfer = 1.2;

thread_diameter = 8;
thread_length = 20;
thread_pitch = 1.25; // Standard coarse pitch for M8.
hex_key_size = 5;    // Distance across flats.
hex_socket_depth = 8;
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

module hex_socket(size_across_flats, depth) {
    cylinder(
        h = depth,
        r = size_across_flats / sqrt(3),
        $fn = 6
    );
}

module threaded_cylinder_with_hex_sockets() {
    difference() {
        metric_thread(
            diameter = thread_diameter,
            pitch = thread_pitch,
            length = thread_length,
            internal = false,
            leadin = 2
        );

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

// Keep the model centered in X/Y and place its bottom on the print bed (Z = 0).
color(cube_color)
    translate([0, 0, cube_size / 2])
        chamfered_cube(cube_size, chamfer);

// Vertical M8 threaded cylinder beside the cube.
color(thread_color)
    translate([
        cube_size / 2 + part_gap + thread_diameter / 2,
        0,
        0
    ])
        threaded_cylinder_with_hex_sockets();
