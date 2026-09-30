// MagSafe clamp experiment: a holder with plain cylindrical recesses and a
// completely separate toothed insert. The insert is intentionally not placed
// in, attached to, or boolean-unioned with the holder in this revision.

$fn = 96;

use <../iphone_holder/circle_holder.scad>

part = "all"; // "all", "holder", or "index_insert".

// Parameters required by the imported, physically tested holder modules.
magsafe_diameter = 56;
magsafe_edge_thickness = 5.5;
magsafe_protrusion = 0.8;

ring_wall = 4;
pocket_depth = magsafe_edge_thickness - magsafe_protrusion;
flange_radial_width = 4;
flange_thickness = 2;
ring_outer_diameter = magsafe_diameter + 2 * ring_wall;
flange_opening_diameter = magsafe_diameter - 2 * flange_radial_width;
ring_inner_radius = magsafe_diameter / 2;
flange_relief_base_width = 4;
flange_relief_angles = [-90, 90, 180];

block_face_scale = 1.6;
block_radial_width = 20 * block_face_scale;
block_height_z = 22 * block_face_scale;
block_thickness = 6;
block_gap = 5;
block_corner_radius = 16;
removed_ring_width = 2 * block_thickness + block_gap;
block_join_overlap = 0.2;
flange_opening_radius = flange_opening_diameter / 2;
block_outer_y = removed_ring_width / 2 + block_join_overlap;
block_inner_x = sqrt(
    flange_opening_radius * flange_opening_radius
        - block_outer_y * block_outer_y
);
block_front_z = magsafe_protrusion;
block_hole_center_x = block_inner_x + block_radial_width / 2;
block_hole_center_z = block_front_z + block_height_z / 2;

block_hole_diameter = 13;
clamp_alignment_collar_depth = 3;
clamp_alignment_collar_radial_wall = 3;
clamp_alignment_collar_outer_diameter = block_hole_diameter
    + 2 * clamp_alignment_collar_radial_wall;

epsilon = 0.05;
holder_color = "#4F86C6";
insert_color = "#D88932";

// The holder receives only two plain cylindrical recesses. There are no
// teeth, tooth grooves, or insert geometry in the holder itself.
index_recess_diameter = 21;
index_recess_depth = 0.8;

// The loose insert is exactly 4 mm smaller than the recess diameter.
index_insert_diameter = index_recess_diameter - 4; // 17 mm.
index_insert_hole_diameter = block_hole_diameter; // 13 mm.
index_insert_body_thickness = index_recess_depth; // 0.8 mm.

index_tooth_count = 48;
index_tooth_height = 0.7;
index_tooth_valley_height = 0.1;
index_tooth_root_overlap = 0.05;
index_tooth_edge_inset = 0.05;
index_tooth_angular_fill = 0.9;
index_tooth_step_angle = 360 / index_tooth_count;

insert_layout_x = ring_outer_diameter / 2 + 18;

assert(
    index_insert_diameter == index_recess_diameter - 4,
    "The toothed insert must be 4 mm smaller than the cylindrical recess"
);
assert(
    index_insert_diameter > index_insert_hole_diameter,
    "The toothed insert needs material around the M12 clearance hole"
);
assert(
    index_recess_depth < block_thickness,
    "The cylindrical recess must not cut through a clamp arm"
);

function polar3(radius, angle, normal_position) = [
    radius * cos(angle),
    radius * sin(angle),
    normal_position
];

module cylindrical_recess_positive_y() {
    outer_face_y = block_gap / 2
        + block_thickness
        + block_join_overlap;

    translate([
        block_hole_center_x,
        outer_face_y + epsilon,
        block_hole_center_z
    ])
        rotate([90, 0, 0])
            cylinder(
                d = index_recess_diameter,
                h = index_recess_depth + 2 * epsilon
            );
}

module cylindrical_recesses() {
    cylindrical_recess_positive_y();
    mirror([0, 1, 0])
        cylindrical_recess_positive_y();
}

module holder_with_plain_recesses() {
    color(holder_color)
        difference() {
            circle_holder();
            cylindrical_recesses();
        }
}

module index_tooth(tooth_index) {
    // Keep every tooth fully inside the annular body's inner and outer edges,
    // and leave a narrow angular valley between neighbours. This eliminates
    // coincident walls while the root still overlaps the body vertically.
    inner_radius = index_insert_hole_diameter / 2
        + index_tooth_edge_inset;
    outer_radius = index_insert_diameter / 2
        - index_tooth_edge_inset;
    center_angle = tooth_index * index_tooth_step_angle;
    half_step = index_tooth_step_angle
        * index_tooth_angular_fill / 2;
    left_angle = center_angle - half_step;
    right_angle = center_angle + half_step;
    root_height = index_insert_body_thickness
        - index_tooth_root_overlap;
    valley_height = index_insert_body_thickness
        + index_tooth_valley_height;
    peak_height = index_insert_body_thickness
        + index_tooth_height;

    points = [
        // Six-point planar root embedded in the flat insert body.
        polar3(inner_radius, left_angle, root_height),
        polar3(outer_radius, left_angle, root_height),
        polar3(outer_radius, center_angle, root_height),
        polar3(outer_radius, right_angle, root_height),
        polar3(inner_radius, right_angle, root_height),
        polar3(inner_radius, center_angle, root_height),

        // Two sloped roof facets meeting at the tooth ridge.
        polar3(inner_radius, left_angle, valley_height),
        polar3(outer_radius, left_angle, valley_height),
        polar3(outer_radius, center_angle, peak_height),
        polar3(outer_radius, right_angle, valley_height),
        polar3(inner_radius, right_angle, valley_height),
        polar3(inner_radius, center_angle, peak_height)
    ];

    faces = [
        [6, 7, 8], [6, 8, 11],
        [11, 8, 9], [11, 9, 10],
        [0, 2, 1], [0, 5, 2],
        [5, 3, 2], [5, 4, 3],
        [0, 1, 7], [0, 7, 6],
        [1, 2, 8], [1, 8, 7],
        [2, 3, 9], [2, 9, 8],
        [3, 4, 10], [3, 10, 9],
        [4, 5, 11], [4, 11, 10],
        [5, 0, 6], [5, 6, 11]
    ];

    polyhedron(points = points, faces = faces, convexity = 2);
}

module index_insert() {
    color(insert_color)
        render(convexity = 4)
            union() {
                difference() {
                    cylinder(
                        d = index_insert_diameter,
                        h = index_insert_body_thickness
                    );
                    translate([0, 0, -epsilon])
                        cylinder(
                            d = index_insert_hole_diameter,
                            h = index_insert_body_thickness
                                + 2 * epsilon
                        );
                }

                for (tooth_index = [0 : index_tooth_count - 1])
                    index_tooth(tooth_index);
            }
}

if (part == "all") {
    holder_with_plain_recesses();
    translate([insert_layout_x, 0, 0])
        index_insert();
} else if (part == "holder") {
    holder_with_plain_recesses();
} else if (part == "index_insert") {
    index_insert();
} else {
    assert(false, str("Unknown part selector: ", part));
}
