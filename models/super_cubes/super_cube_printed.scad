// Printed super-cube set: cube, double-ended socket, plug, and connector.

use <cube1.scad>

// Export selector: "all", "cube", "double_thread_socket_30mm",
// "threaded_axis_5mm", or "threaded_axis_10mm".
part = "all";

cube_part_color = "#DDE8B0";      // Pale pistachio.
socket_part_color = "#E07A3F";    // Orange.
plug_part_color = "#7E57C2";      // Purple.
connector_part_color = "#2D9CDB"; // Blue.

module printed_cube() {
    printable_cube(cube_part_color);
}

module printed_double_thread_socket_30mm() {
    printable_double_thread_socket(socket_part_color);
}

module printed_threaded_axis_5mm() {
    printable_threaded_axis_5mm(plug_part_color);
}

module printed_threaded_axis_10mm() {
    printable_threaded_axis_10mm(connector_part_color);
}

assert(
    part == "all"
        || part == "cube"
        || part == "double_thread_socket_30mm"
        || part == "threaded_axis_5mm"
        || part == "threaded_axis_10mm",
    str("Unknown part: ", part)
);

if (part == "all") {
    printed_cube();

    translate([21, 0, 0])
        printed_double_thread_socket_30mm();

    translate([36, 0, 0])
        printed_threaded_axis_5mm();

    translate([49, 0, 0])
        printed_threaded_axis_10mm();
} else if (part == "cube") {
    printed_cube();
} else if (part == "double_thread_socket_30mm") {
    printed_double_thread_socket_30mm();
} else if (part == "threaded_axis_5mm") {
    printed_threaded_axis_5mm();
} else if (part == "threaded_axis_10mm") {
    printed_threaded_axis_10mm();
}
