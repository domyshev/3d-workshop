// Split clamp holder for a 56 mm Apple MagSafe puck.

$fn = 96;

use <../../lib/core/threads/threads.scad>

// Export selector: "all", "holder", "bolt", "nut", or "fit_preview".
part = "all";
show_magsafe_reference = false;

// Measured MagSafe dimensions.
magsafe_diameter = 56;
magsafe_edge_thickness = 5.5;
magsafe_protrusion = 0.8;

// Holder ring and lower retaining flange.
ring_wall = 4;
pocket_depth = magsafe_edge_thickness - magsafe_protrusion; // 4.7 mm.
flange_radial_width = 4;
flange_thickness = 2;
ring_outer_diameter = magsafe_diameter + 2 * ring_wall; // 64 mm.
flange_opening_diameter = magsafe_diameter - 2 * flange_radial_width; // 48 mm.
ring_total_depth = pocket_depth + flange_thickness; // 6.7 mm.

// Clamp blocks. Scale the original 20 x 22 mm face proportionally so an
// M12 hex head and nut have wrench clearance from the holder ring.
block_face_scale = 1.6;
block_radial_width = 20 * block_face_scale; // 32 mm along X.
block_height_z = 22 * block_face_scale; // 35.2 mm along Z.
block_thickness = 6;
block_gap = 5;
block_corner_radius = 16;
removed_ring_width = 2 * block_thickness + block_gap; // 17 mm.
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

// M12 clamp fastener.
block_hole_diameter = 13;
bolt_diameter = 12;
bolt_pitch = 1.75;
bolt_head_across_flats = 19;
bolt_head_height = 7.5;
bolt_under_head_length = 30;
bolt_smooth_length = removed_ring_width;
bolt_thread_length = bolt_under_head_length - bolt_smooth_length;
nut_across_flats = 19;
nut_height = 10;
nut_thread_diameter = 12.5;
minimum_hex_ring_clearance = 1;
hex_corner_radius = hex_vertex_diameter(bolt_head_across_flats) / 2;
hex_ring_clearance = sqrt(
    (block_hole_center_x - ring_outer_diameter / 2)
        * (block_hole_center_x - ring_outer_diameter / 2)
    + (block_hole_center_z - magsafe_edge_thickness - flange_thickness)
        * (block_hole_center_z - magsafe_edge_thickness - flange_thickness)
) - hex_corner_radius;

epsilon = 0.05;

holder_color = "#4F86C6";
bolt_color = "#E07A3F";
nut_color = "#7E57C2";
magsafe_color = [0.85, 0.85, 0.85, 0.35];

assert(
    abs(pocket_depth - 4.7) < 0.001,
    "MagSafe pocket depth must be 4.7 mm"
);
assert(removed_ring_width == 17, "Clamp opening must be 17 mm wide");
assert(
    hex_ring_clearance >= minimum_hex_ring_clearance,
    "M12 hex head and nut need at least 1 mm clearance from the ring"
);
assert(
    bolt_smooth_length + bolt_thread_length == bolt_under_head_length,
    "Bolt shank lengths must match its under-head length"
);

function hex_vertex_diameter(across_flats) = across_flats / cos(30);

module annulus(outer_diameter, inner_diameter, height) {
    difference() {
        cylinder(d = outer_diameter, h = height);
        translate([0, 0, -epsilon])
            cylinder(
                d = inner_diameter,
                h = height + 2 * epsilon
            );
    }
}

module closed_ring_with_flange() {
    union() {
        // The puck projects 0.8 mm above the front edge of this wall.
        translate([0, 0, magsafe_protrusion])
            annulus(
                ring_outer_diameter,
                magsafe_diameter,
                pocket_depth
            );

        // Bottom support: 2 mm thick and projecting 4 mm inward.
        translate([0, 0, magsafe_edge_thickness])
            annulus(
                ring_outer_diameter,
                flange_opening_diameter,
                flange_thickness
            );
    }
}

module split_ring_with_flange() {
    difference() {
        closed_ring_with_flange();

        // Remove a straight 17 mm section on the +X side of the ring.
        translate([
            0,
            -removed_ring_width / 2,
            -epsilon
        ])
            cube([
                ring_outer_diameter / 2 + epsilon,
                removed_ring_width,
                magsafe_edge_thickness
                    + flange_thickness
                    + 2 * epsilon
            ]);
    }
}

module clamp_block_profile_2d() {
    radius = block_corner_radius;
    width = block_radial_width;
    height = block_height_z;

    union() {
        // Full middle strips shared by all four corners.
        translate([0, radius])
            square([width, height - 2 * radius]);
        translate([radius, 0])
            square([width - 2 * radius, height]);

        // Keep the inner/front corner square where the block meets the ring.
        square([radius, radius]);

        // Round the other three free corners.
        translate([width - radius, radius])
            circle(r = radius);
        translate([radius, height - radius])
            circle(r = radius);
        translate([width - radius, height - radius])
            circle(r = radius);
    }
}

module upper_clamp_block() {
    overlap_thickness = block_thickness + block_join_overlap;

    translate([
        block_inner_x,
        block_gap / 2 + overlap_thickness,
        block_front_z
    ])
        rotate([90, 0, 0])
            linear_extrude(height = overlap_thickness)
                clamp_block_profile_2d();
}

module clamp_blocks() {
    // The two blocks occupy 6 mm each inside the removed 17 mm section.
    upper_clamp_block();
    mirror([0, 1, 0])
        upper_clamp_block();
}

module holder_inner_envelope_cuts() {
    // Keep the front portion flush with the Ø56 MagSafe circumference.
    translate([0, 0, -epsilon])
        cylinder(
            d = magsafe_diameter,
            h = magsafe_edge_thickness + 2 * epsilon
        );

    // Continue the blocks exactly to the cylindrical Ø48 boundary of the
    // retaining flange throughout their rearward extension.
    translate([0, 0, magsafe_edge_thickness - epsilon])
        cylinder(
            d = flange_opening_diameter,
            h = block_front_z
                + block_height_z
                - magsafe_edge_thickness
                + 2 * epsilon
        );
}

module clamp_bolt_hole() {
    translate([
        block_hole_center_x,
        -removed_ring_width / 2 - block_join_overlap - epsilon,
        block_hole_center_z
    ])
        rotate([-90, 0, 0])
            cylinder(
                d = block_hole_diameter,
                h = removed_ring_width
                    + 2 * block_join_overlap
                    + 2 * epsilon
            );
}

module circle_holder() {
    color(holder_color)
        difference() {
            union() {
                split_ring_with_flange();
                clamp_blocks();
            }

            clamp_bolt_hole();
            holder_inner_envelope_cuts();
        }
}

module external_bolt_thread(length) {
    metric_thread(
        diameter = bolt_diameter,
        pitch = bolt_pitch,
        length = length,
        internal = false,
        leadin = 2,
        test = $preview
    );
}

module internal_nut_thread(length) {
    metric_thread(
        diameter = nut_thread_diameter,
        pitch = bolt_pitch,
        length = length,
        internal = true,
        leadin = 2,
        test = $preview
    );
}

module m12_bolt() {
    color(bolt_color)
        union() {
            cylinder(
                d = hex_vertex_diameter(bolt_head_across_flats),
                h = bolt_head_height,
                $fn = 6
            );

            translate([0, 0, bolt_head_height - epsilon])
                cylinder(
                    d = bolt_diameter,
                    h = bolt_smooth_length + 2 * epsilon
                );

            translate([
                0,
                0,
                bolt_head_height + bolt_smooth_length - epsilon
            ])
                external_bolt_thread(bolt_thread_length + epsilon);
        }
}

module m12_nut() {
    color(nut_color)
        difference() {
            cylinder(
                d = hex_vertex_diameter(nut_across_flats),
                h = nut_height,
                $fn = 6
            );

            translate([0, 0, -epsilon])
                internal_nut_thread(nut_height + 2 * epsilon);
        }
}

module magsafe_reference() {
    color(magsafe_color)
        cylinder(
            d = magsafe_diameter,
            h = magsafe_edge_thickness
        );
}

module fastener_fit_preview() {
    circle_holder();

    // Bolt head sits against the outside of the lower clamp block.
    translate([
        block_hole_center_x,
        -block_outer_y - bolt_head_height,
        block_hole_center_z
    ])
        rotate([-90, 0, 0])
            m12_bolt();

    // Nut sits against the outside of the upper clamp block.
    translate([
        block_hole_center_x,
        block_outer_y,
        block_hole_center_z
    ])
        rotate([-90, 0, 0])
            m12_nut();
}

assert(
    part == "all"
        || part == "holder"
        || part == "bolt"
        || part == "nut"
        || part == "fit_preview",
    str("Unknown part: ", part)
);

if (part == "all") {
    circle_holder();

    if (show_magsafe_reference)
        magsafe_reference();

    translate([-48, 0, 0])
        m12_bolt();

    translate([-72, 0, 0])
        m12_nut();
} else if (part == "holder") {
    circle_holder();
} else if (part == "bolt") {
    m12_bolt();
} else if (part == "nut") {
    m12_nut();
} else if (part == "fit_preview") {
    fastener_fit_preview();
}
