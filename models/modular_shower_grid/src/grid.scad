// Modular panel. Dimensions in millimetres.
// Default: 80 x 80 x 8; sixteen clear openings of 13 x 13.
// Origin at the lower outer corner; Z=0 is the bottom of the frame.

outer_size = 80;
frame_width = 8;
frame_height = 8;
grid_width = 4;
grid_height = 4;
cells = 4;
bolt_hole_diameter = 6;

$fn = 64;
epsilon = 0.02;

inner_size = outer_size - 2 * frame_width;
clear_opening = (inner_size - (cells - 1) * grid_width) / cells;
pitch = clear_opening + grid_width;
grid_z = (frame_height - grid_height) / 2;
frame_axis = frame_width / 2;

assert(cells >= 2 && cells == floor(cells), "cells must be an integer >= 2");
assert(clear_opening > 0, "Frame/grid dimensions leave no room for cells");
assert(grid_height <= frame_height, "Grid must fit inside frame height");
assert(bolt_hole_diameter < min(frame_width, frame_height),
       "Bolt holes must be smaller than the frame section");

function bar_axis(i) = frame_width + i * pitch - grid_width / 2;
function cell_axis(i) = frame_width + i * pitch + clear_opening / 2;

module frame_and_grid() {
    union() {
        difference() {
            cube([outer_size, outer_size, frame_height]);
            translate([frame_width, frame_width, -epsilon])
                cube([inner_size, inner_size, frame_height + 2 * epsilon]);
        }
        for (i = [1 : cells - 1]) {
            // Slight overlap with the frame makes a single solid mesh.
            translate([bar_axis(i) - grid_width / 2,
                       frame_width - epsilon, grid_z])
                cube([grid_width, inner_size + 2 * epsilon, grid_height]);
            translate([frame_width - epsilon,
                       bar_axis(i) - grid_width / 2, grid_z])
                cube([inner_size + 2 * epsilon, grid_width, grid_height]);
        }
    }
}

module vertical_holes() {
    // Through Z at the grid-to-frame junctions.
    for (i = [1 : cells - 1])
        for (side = [frame_axis, outer_size - frame_axis]) {
            translate([bar_axis(i), side, -epsilon])
                cylinder(h = frame_height + 2 * epsilon,
                         d = bolt_hole_diameter);
            translate([side, bar_axis(i), -epsilon])
                cylinder(h = frame_height + 2 * epsilon,
                         d = bolt_hole_diameter);
        }
}

module horizontal_holes() {
    // Across each frame rail, parallel to the adjacent grid bars.
    // Short cutters affect only the frame, leaving the grid intact.
    for (i = [0 : cells - 1])
        for (side = [frame_axis, outer_size - frame_axis]) {
            translate([cell_axis(i), side, frame_height / 2])
                rotate([90, 0, 0])
                    cylinder(h = frame_width + 2 * epsilon,
                             d = bolt_hole_diameter, center = true);
            translate([side, cell_axis(i), frame_height / 2])
                rotate([0, 90, 0])
                    cylinder(h = frame_width + 2 * epsilon,
                             d = bolt_hole_diameter, center = true);
        }
}

module panel() {
    difference() {
        frame_and_grid();
        vertical_holes();
        horizontal_holes();
    }
}

echo("Outer dimensions", [outer_size, outer_size, frame_height]);
echo("Clear opening", clear_opening);
echo("Grid axes", [for (i = [1 : cells - 1]) bar_axis(i)]);
echo("Horizontal hole axes", [for (i = [0 : cells - 1]) cell_axis(i)]);

panel();
