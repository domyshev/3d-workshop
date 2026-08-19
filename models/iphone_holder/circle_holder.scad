// Split clamp holder for a 56 mm Apple MagSafe puck.

$fn = 96;

use <../../lib/core/threads/threads.scad>

// Export selector: "all", "holder", "bolt", "stand_bolt", "nut",
// "stand", "stand_flat", "stand_long_side", "platform",
// "platform_lid", "platform_preview", or "fit_preview".
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
ring_inner_radius = magsafe_diameter / 2;
flange_relief_base_width = 4;
flange_relief_angles = [-90, 90, 180];

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
nut_across_flats = 19;
nut_height = 10;
nut_thread_diameter = 12.7;
effective_block_thickness = block_thickness + block_join_overlap;
open_clamp_width = 2 * effective_block_thickness + block_gap;
closed_clamp_width = 2 * effective_block_thickness;
bolt_under_head_length = closed_clamp_width + nut_height;
bolt_thread_length = 16;
bolt_smooth_length = bolt_under_head_length - bolt_thread_length;
stand_bolt_under_head_length = 40;
stand_bolt_thread_length = 16;
stand_bolt_smooth_length = stand_bolt_under_head_length
    - stand_bolt_thread_length; // 24 mm.
initial_nut_engagement = bolt_under_head_length - open_clamp_width;
closed_bolt_protrusion = bolt_under_head_length
    - closed_clamp_width
    - nut_height;
minimum_hex_ring_clearance = 1;
hex_corner_radius = hex_vertex_diameter(bolt_head_across_flats) / 2;
hex_ring_clearance = sqrt(
    (block_hole_center_x - ring_outer_diameter / 2)
        * (block_hole_center_x - ring_outer_diameter / 2)
    + (block_hole_center_z - magsafe_edge_thickness - flange_thickness)
        * (block_hole_center_z - magsafe_edge_thickness - flange_thickness)
) - hex_corner_radius;

// Vertical support stand. Z=0 is the tabletop; the stand begins on the
// 6 mm base plate and holds the upper bolt axis 76 mm above the table.
stand_top_axis_height = 76;
stand_base_thickness = 6;
stand_hole_diameter = 13;
stand_hole_edge = 5;
stand_fork_tail = 20;
stand_upper_fork_length = stand_hole_edge
    + stand_hole_diameter
    + stand_fork_tail; // 38 mm.
stand_face_width = 2 * stand_hole_edge
    + stand_hole_diameter; // 23 mm in X.
stand_end_radius = stand_face_width / 2; // 11.5 mm.
stand_lower_fork_length = 24; // 23 mm wide with 1 mm rotational allowance.
stand_outer_thickness = 30;
stand_upper_wide_gap = 17;
stand_upper_narrow_gap = 13;
stand_upper_outer_thickness = stand_outer_thickness;
stand_upper_thin_arm_thickness = (
    stand_upper_outer_thickness - stand_upper_wide_gap
) / 2; // 6.5 mm.
stand_upper_thick_arm_thickness = (
    stand_upper_outer_thickness - stand_upper_narrow_gap
) / 2; // 8.5 mm.
stand_lower_gap = 18;
stand_lower_arm_thickness = (
    stand_outer_thickness - stand_lower_gap
) / 2; // 6 mm.
stand_lower_axis_height = stand_base_thickness
    + stand_hole_edge
    + stand_hole_diameter / 2; // 17.5 mm.
stand_upper_tip_z = stand_top_axis_height
    + stand_hole_edge
    + stand_hole_diameter / 2;
stand_upper_body_z = stand_top_axis_height
    - stand_hole_diameter / 2
    - stand_fork_tail;
stand_lower_tip_z = stand_base_thickness;
stand_lower_body_z = stand_lower_tip_z + stand_lower_fork_length;
stand_body_height = stand_upper_body_z - stand_lower_body_z;

// Fine radial locking serrations on the four inward-facing fork surfaces.
stand_index_tooth_count = 48;
stand_index_tooth_height = 0.7;
stand_index_valley_height = 0.1;
stand_index_embed = 0.2;
stand_index_inner_diameter = 14;
stand_index_outer_diameter = 21;
stand_index_station_count = 2 * stand_index_tooth_count;
stand_index_step_angle = 360 / stand_index_station_count;
stand_upper_inner_face_mid_y = (
    stand_upper_wide_gap + stand_upper_narrow_gap
) / 4; // 7.5 mm on the positive arm.
stand_upper_inner_face_angle = -atan(
    (
        stand_upper_wide_gap - stand_upper_narrow_gap
    ) / (2 * stand_face_width)
);

// Hollow weighted base platform and removable sliding bottom lid.
platform_length = 100;
platform_width = 74;
platform_height = 14;
platform_side_wall = 5;
platform_top_wall = 4;
platform_corner_radius = 3;
platform_top_chamfer = 1;
platform_inner_length = platform_length - 2 * platform_side_wall; // 90 mm.
platform_inner_width = platform_width - 2 * platform_side_wall; // 64 mm.
platform_lid_thickness = 2;
platform_lid_groove_bottom = 2;
platform_lid_groove_height = 2.7;
platform_lid_groove_depth = 2.35;
platform_lid_clearance = 0.35;
platform_lid_width = platform_inner_width
    + 2 * (platform_lid_groove_depth - platform_lid_clearance); // 68 mm.
platform_lid_length = platform_length
    - platform_side_wall
    + platform_lid_groove_depth
    - platform_lid_clearance; // 97 mm, flush with the insertion end.
platform_lid_corner_radius = 1;
platform_lid_closed_center_x = -platform_length / 2
    + platform_lid_length / 2;
platform_lug_reinforcement_length = 40;
platform_lug_reinforcement_width = 30;
platform_lug_reinforcement_depth = 4;
platform_lug_reinforcement_chamfer = 1;

// The lower stand fork has an 18 mm nominal gap. Complementary serrations
// need 0.8 mm per interface (0.7 mm tooth plus 0.1 mm valley), followed by
// 0.3 mm assembly clearance on each side.
platform_lug_interface_clearance = 0.3;
platform_lug_serration_stack = stand_index_tooth_height
    + stand_index_valley_height; // 0.8 mm per side.
platform_lug_thickness = stand_lower_gap
    - 2 * (
        platform_lug_serration_stack
            + platform_lug_interface_clearance
    ); // 15.8 mm core.
platform_lug_depth = stand_face_width; // 23 mm along X.
platform_lug_height = stand_face_width; // 23 mm above the platform.
platform_lug_radius = stand_end_radius; // 11.5 mm.
platform_lug_hole_diameter = stand_hole_diameter;
platform_lug_axis_height = platform_height + platform_lug_height / 2;
platform_lug_top_z = platform_height + platform_lug_height;

epsilon = 0.05;

holder_color = "#4F86C6";
bolt_color = "#E07A3F";
nut_color = "#7E57C2";
stand_color = "#F3E5C8";
platform_color = "#B7A58A";
platform_lid_color = "#D8CDBA";
magsafe_color = [0.85, 0.85, 0.85, 0.35];

assert(
    abs(pocket_depth - 4.7) < 0.001,
    "MagSafe pocket depth must be 4.7 mm"
);
assert(removed_ring_width == 17, "Clamp opening must be 17 mm wide");
assert(
    initial_nut_engagement >= 2 * bolt_pitch,
    "Bolt needs enough initial thread engagement to catch the nut"
);
assert(
    abs(closed_bolt_protrusion) < 0.001,
    "Bolt end must be flush with the nut when the clamp is closed"
);
assert(
    hex_ring_clearance >= minimum_hex_ring_clearance,
    "M12 hex head and nut need at least 1 mm clearance from the ring"
);
assert(
    bolt_smooth_length + bolt_thread_length == bolt_under_head_length,
    "Bolt shank lengths must match its under-head length"
);
assert(
    bolt_thread_length >= nut_height + block_gap,
    "Bolt thread must cover the nut and the full clamp travel"
);
assert(
    stand_bolt_smooth_length + stand_bolt_thread_length
        == stand_bolt_under_head_length,
    "Stand bolt shank lengths must equal 40 mm"
);
assert(
    stand_upper_thin_arm_thickness == 6.5
        && stand_upper_thick_arm_thickness == 8.5,
    "Upper stand arms must thicken from 6.5 to 8.5 mm"
);
assert(
    stand_upper_wide_gap
        - 2 * (
            stand_upper_thick_arm_thickness
                - stand_upper_thin_arm_thickness
        )
        == stand_upper_narrow_gap,
    "Upper stand gap must taper across X from 17 to 13 mm"
);
assert(
    stand_lower_arm_thickness == 6,
    "Lower stand arms must be 6 mm thick"
);
assert(
    stand_body_height > 0,
    "Upper and lower stand forks need a solid central bridge"
);
assert(
    abs(stand_body_height - 19.5) < 0.001,
    "Stand central body must be 19.5 mm high"
);
assert(
    stand_index_outer_diameter <= stand_face_width - 2,
    "Stand serrations need at least 1 mm to the outer ear edge"
);
assert(
    abs(platform_lid_width - 68) < 0.001
        && abs(platform_lid_length - 97) < 0.001,
    "Platform lid must be 97 x 68 mm"
);
assert(
    abs(platform_lug_thickness - 15.8) < 0.001,
    "Indexed platform lug core must be 15.8 mm thick"
);
assert(
    abs(platform_lug_top_z - platform_height - 23) < 0.001,
    "Platform lug must project exactly 23 mm above the top surface"
);
assert(
    platform_height - platform_top_wall
        - platform_lug_reinforcement_depth >= platform_lid_groove_bottom
            + platform_lid_groove_height,
    "Lug reinforcement must stay above the sliding-lid groove"
);

function hex_vertex_diameter(across_flats) = across_flats / cos(30);

function stand_index_polar3(radius, angle, normal_position) = [
    radius * cos(angle),
    radius * sin(angle),
    normal_position
];

function stand_index_height(station_index) =
    station_index % 2 == 0
        ? stand_index_tooth_height
        : stand_index_valley_height;

function stand_index_sector_midpoint(
    radius,
    station_index,
    normal_position
) = stand_index_polar3(
    radius,
    (station_index + 0.5) * stand_index_step_angle,
    normal_position
);

module stand_index_serration_ring() {
    inner_radius = stand_index_inner_diameter / 2;
    outer_radius = stand_index_outer_diameter / 2;
    points = [
        for (
            station_index = [0 : stand_index_station_count - 1]
        )
            let(
                next_index = (
                    station_index + 1
                ) % stand_index_station_count,
                top_mid_normal = (
                    stand_index_height(station_index)
                        + stand_index_height(next_index)
                ) / 2,
                side_mid_normal = (
                    -stand_index_embed + top_mid_normal
                ) / 2
            )
                each [
                    stand_index_polar3(
                        inner_radius,
                        station_index * stand_index_step_angle,
                        -stand_index_embed
                    ),
                    stand_index_polar3(
                        outer_radius,
                        station_index * stand_index_step_angle,
                        -stand_index_embed
                    ),
                    stand_index_polar3(
                        inner_radius,
                        station_index * stand_index_step_angle,
                        stand_index_height(station_index)
                    ),
                    stand_index_polar3(
                        outer_radius,
                        station_index * stand_index_step_angle,
                        stand_index_height(station_index)
                    ),
                    stand_index_sector_midpoint(
                        (inner_radius + outer_radius) / 2,
                        station_index,
                        top_mid_normal
                    ),
                    stand_index_sector_midpoint(
                        (inner_radius + outer_radius) / 2,
                        station_index,
                        -stand_index_embed
                    ),
                    stand_index_sector_midpoint(
                        outer_radius,
                        station_index,
                        side_mid_normal
                    ),
                    stand_index_sector_midpoint(
                        inner_radius,
                        station_index,
                        side_mid_normal
                    )
                ]
    ];
    faces = [
        for (
            station_index = [0 : stand_index_station_count - 1]
        )
            let(
                next_index = (
                    station_index + 1
                ) % stand_index_station_count,
                bottom_inner = 8 * station_index,
                bottom_outer = bottom_inner + 1,
                top_inner = bottom_inner + 2,
                top_outer = bottom_inner + 3,
                top_midpoint = bottom_inner + 4,
                bottom_midpoint = bottom_inner + 5,
                outer_midpoint = bottom_inner + 6,
                inner_midpoint = bottom_inner + 7,
                next_bottom_inner = 8 * next_index,
                next_bottom_outer = next_bottom_inner + 1,
                next_top_inner = next_bottom_inner + 2,
                next_top_outer = next_bottom_inner + 3
            )
                each [
                    [top_inner, top_outer, top_midpoint],
                    [top_outer, next_top_outer, top_midpoint],
                    [next_top_outer, next_top_inner, top_midpoint],
                    [next_top_inner, top_inner, top_midpoint],
                    [bottom_inner, next_bottom_inner, bottom_midpoint],
                    [next_bottom_inner, next_bottom_outer, bottom_midpoint],
                    [next_bottom_outer, bottom_outer, bottom_midpoint],
                    [bottom_outer, bottom_inner, bottom_midpoint],
                    [bottom_outer, next_bottom_outer, outer_midpoint],
                    [next_bottom_outer, next_top_outer, outer_midpoint],
                    [next_top_outer, top_outer, outer_midpoint],
                    [top_outer, bottom_outer, outer_midpoint],
                    [bottom_inner, top_inner, inner_midpoint],
                    [top_inner, next_top_inner, inner_midpoint],
                    [next_top_inner, next_bottom_inner, inner_midpoint],
                    [next_bottom_inner, bottom_inner, inner_midpoint]
                ]
    ];

    polyhedron(points = points, faces = faces, convexity = 4);
}

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

module flange_relief_cut() {
    translate([0, 0, magsafe_edge_thickness - epsilon])
        linear_extrude(height = flange_thickness + 2 * epsilon)
            polygon([
                [ring_inner_radius, 0],
                [flange_opening_radius, -flange_relief_base_width / 2],
                [flange_opening_radius, flange_relief_base_width / 2]
            ]);
}

module flange_relief_cuts() {
    for (relief_angle = flange_relief_angles)
        rotate([0, 0, relief_angle])
            flange_relief_cut();
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

        // Three triangular flex cuts in the lower retaining flange.
        flange_relief_cuts();
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

module stand_face_envelope(profile = "upper") {
    translate([0, stand_outer_thickness / 2 + epsilon, 0])
        rotate([90, 0, 0])
            linear_extrude(height = stand_outer_thickness + 2 * epsilon)
                if (profile == "upper") {
                    // Full-width root plus a concentric semicircular free end.
                    union() {
                        translate([
                            -stand_face_width / 2,
                            stand_upper_body_z
                        ])
                            square([
                                stand_face_width,
                                stand_top_axis_height - stand_upper_body_z
                            ]);
                        translate([0, stand_top_axis_height])
                            circle(r = stand_end_radius);
                    }
                } else {
                    // 23 x 24 mm lower ear with a rounded free end and a
                    // full-width attachment to the central body.
                    union() {
                        translate([
                            -stand_face_width / 2,
                            stand_lower_axis_height
                        ])
                            square([
                                stand_face_width,
                                stand_lower_body_z - stand_lower_axis_height
                            ]);
                        translate([0, stand_lower_axis_height])
                            circle(r = stand_end_radius);
                    }
                }
}

module stand_upper_positive_arm() {
    intersection() {
        // The inner face changes across the 23 mm X width, not along Z:
        // 17 mm fork gap at -X and 13 mm at +X. The outer face remains
        // parallel and flush with the 30 mm body, so each arm thickens
        // from 6.5 to 8.5 mm.
        translate([0, 0, stand_upper_body_z - epsilon])
            linear_extrude(
                height = stand_upper_tip_z
                    - stand_upper_body_z
                    + 2 * epsilon
            )
                polygon([
                    [
                        -stand_face_width / 2,
                        stand_upper_wide_gap / 2
                    ],
                    [
                        stand_face_width / 2,
                        stand_upper_narrow_gap / 2
                    ],
                    [
                        stand_face_width / 2,
                        stand_upper_outer_thickness / 2
                    ],
                    [
                        -stand_face_width / 2,
                        stand_upper_outer_thickness / 2
                    ]
                ]);

        stand_face_envelope("upper");
    }
}

module stand_upper_fork() {
    stand_upper_positive_arm();
    mirror([0, 1, 0])
        stand_upper_positive_arm();
}

module stand_lower_positive_arm() {
    intersection() {
        translate([
            -stand_face_width / 2,
            stand_lower_gap / 2,
            stand_lower_tip_z
        ])
            cube([
                stand_face_width,
                stand_lower_arm_thickness,
                stand_lower_body_z - stand_lower_tip_z + epsilon
            ]);

        stand_face_envelope("lower");
    }
}

module stand_lower_fork() {
    stand_lower_positive_arm();
    mirror([0, 1, 0])
        stand_lower_positive_arm();
}

module stand_central_body() {
    translate([
        -stand_face_width / 2,
        -stand_outer_thickness / 2,
        stand_lower_body_z - epsilon
    ])
        cube([
            stand_face_width,
            stand_outer_thickness,
            stand_body_height + 2 * epsilon
        ]);
}

module stand_bolt_hole(axis_height) {
    translate([
        0,
        -stand_outer_thickness / 2 - epsilon,
        axis_height
    ])
        rotate([-90, 0, 0])
            cylinder(
                d = stand_hole_diameter,
                h = stand_outer_thickness + 2 * epsilon
            );
}

module stand_upper_positive_index_ring() {
    translate([
        0,
        stand_upper_inner_face_mid_y,
        stand_top_axis_height
    ])
        rotate([0, 0, stand_upper_inner_face_angle])
            rotate([90, 0, 0])
                stand_index_serration_ring();
}

module stand_upper_index_rings() {
    stand_upper_positive_index_ring();
    mirror([0, 1, 0])
        stand_upper_positive_index_ring();
}

module stand_lower_positive_index_ring() {
    translate([
        0,
        stand_lower_gap / 2,
        stand_lower_axis_height
    ])
        rotate([90, 0, 0])
            stand_index_serration_ring();
}

module stand_lower_index_rings() {
    stand_lower_positive_index_ring();
    mirror([0, 1, 0])
        stand_lower_positive_index_ring();
}

module stand_index_rings() {
    stand_upper_index_rings();
    stand_lower_index_rings();
}

module vertical_support_stand() {
    color(stand_color)
        difference() {
            union() {
                stand_lower_fork();
                stand_central_body();
                stand_upper_fork();
                stand_index_rings();
            }

            stand_bolt_hole(stand_lower_axis_height);
            stand_bolt_hole(stand_top_axis_height);
        }
}

module vertical_support_stand_for_print() {
    // The design uses the real tabletop as Z=0 and starts the stand on the
    // future 6 mm base. Move only the standalone export down onto the bed.
    translate([0, 0, -stand_base_thickness])
        vertical_support_stand();
}

module vertical_support_stand_flat_for_print() {
    // Lay a broad outer ear face on the print bed. After the X rotation,
    // the original 30 mm Y envelope becomes the Z print height.
    translate([0, 0, stand_outer_thickness / 2])
        rotate([90, 0, 0])
            vertical_support_stand_for_print();
}

module vertical_support_stand_long_side_for_print() {
    // Put the 81.5 mm length along the bed while keeping the broad ear
    // planes vertical. A +Y rotation sends the +X edge (13 mm gap,
    // 8.5 mm upper-arm thickness) down onto the print bed.
    translate([0, 0, stand_face_width / 2])
        rotate([0, 90, 0])
            vertical_support_stand_for_print();
}

module rounded_rectangle_2d(length, width, radius) {
    offset(r = radius)
        square([
            length - 2 * radius,
            width - 2 * radius
        ], center = true);
}

module platform_outer_body() {
    union() {
        linear_extrude(height = platform_height - platform_top_chamfer)
            rounded_rectangle_2d(
                platform_length,
                platform_width,
                platform_corner_radius
            );

        translate([0, 0, platform_height - platform_top_chamfer])
            linear_extrude(
                height = platform_top_chamfer,
                scale = [
                    (platform_length - 2 * platform_top_chamfer)
                        / platform_length,
                    (platform_width - 2 * platform_top_chamfer)
                        / platform_width
                ]
            )
                rounded_rectangle_2d(
                    platform_length,
                    platform_width,
                    platform_corner_radius
                );
    }
}

module platform_inner_cavity_cut() {
    translate([0, 0, -epsilon])
        linear_extrude(
            height = platform_height
                - platform_top_wall
                + 2 * epsilon
        )
            rounded_rectangle_2d(
                platform_inner_length,
                platform_inner_width,
                0.5
            );
}

module platform_lid_guide_cuts() {
    groove_z = platform_lid_groove_bottom;
    groove_h = platform_lid_groove_height;
    groove_back_x = platform_length / 2
        - platform_side_wall
        + platform_lid_groove_depth;
    groove_outer_y = platform_inner_width / 2
        + platform_lid_groove_depth;

    // Guides in both long walls, open at the -X insertion end.
    for (side = [-1, 1])
        translate([
            -platform_length / 2 - epsilon,
            side > 0
                ? platform_inner_width / 2 - epsilon
                : -groove_outer_y,
            groove_z
        ])
            cube([
                groove_back_x + platform_length / 2 + 2 * epsilon,
                platform_lid_groove_depth + epsilon,
                groove_h
            ]);

    // Closed stop groove in the +X short wall.
    translate([
        platform_length / 2 - platform_side_wall - epsilon,
        -groove_outer_y,
        groove_z
    ])
        cube([
            platform_lid_groove_depth + epsilon,
            2 * groove_outer_y,
            groove_h
        ]);

    // Insertion slot through the whole -X short wall. Extending the cut
    // beyond both rounded side corners prevents thin vertical slivers from
    // remaining where the slot meets the long-wall guides.
    translate([
        -platform_length / 2 - epsilon,
        -platform_width / 2 - epsilon,
        groove_z
    ])
        cube([
            platform_side_wall + 2 * epsilon,
            platform_width + 2 * epsilon,
            groove_h
        ]);
}

module hollow_platform_shell() {
    difference() {
        platform_outer_body();
        platform_inner_cavity_cut();
        platform_lid_guide_cuts();
    }
}

module platform_lug_profile_2d() {
    union() {
        square([
            platform_lug_depth,
            platform_lug_height / 2
        ], center = false);

        translate([
            platform_lug_depth / 2,
            platform_lug_height / 2
        ])
            circle(r = platform_lug_radius);
    }
}

module platform_lug_core() {
    translate([
        -platform_lug_depth / 2,
        platform_lug_thickness / 2,
        platform_height
    ])
        rotate([90, 0, 0])
            linear_extrude(height = platform_lug_thickness)
                platform_lug_profile_2d();
}

module platform_lug_reinforcement() {
    reinforcement_bottom_z = platform_height
        - platform_top_wall
        - platform_lug_reinforcement_depth;
    straight_height = platform_lug_reinforcement_depth
        - platform_lug_reinforcement_chamfer
        + 2 * epsilon;

    translate([0, 0, reinforcement_bottom_z]) {
        // One-millimetre chamfer around the lower edge of the internal boss.
        linear_extrude(
            height = platform_lug_reinforcement_chamfer,
            scale = [
                platform_lug_reinforcement_length
                    / (
                        platform_lug_reinforcement_length
                            - 2 * platform_lug_reinforcement_chamfer
                    ),
                platform_lug_reinforcement_width
                    / (
                        platform_lug_reinforcement_width
                            - 2 * platform_lug_reinforcement_chamfer
                    )
            ]
        )
            square([
                platform_lug_reinforcement_length
                    - 2 * platform_lug_reinforcement_chamfer,
                platform_lug_reinforcement_width
                    - 2 * platform_lug_reinforcement_chamfer
            ], center = true);

        translate([0, 0, platform_lug_reinforcement_chamfer])
            linear_extrude(height = straight_height)
                square([
                    platform_lug_reinforcement_length,
                    platform_lug_reinforcement_width
                ], center = true);
    }
}

module platform_lug_positive_index_ring() {
    translate([
        0,
        platform_lug_thickness / 2,
        platform_lug_axis_height
    ])
        rotate([-90, 0, 0])
            rotate([0, 0, stand_index_step_angle])
                stand_index_serration_ring();
}

module platform_lug_index_rings() {
    platform_lug_positive_index_ring();
    mirror([0, 1, 0])
        platform_lug_positive_index_ring();
}

module platform_lug_hole() {
    translate([
        0,
        -platform_lug_thickness / 2
            - stand_index_tooth_height
            - epsilon,
        platform_lug_axis_height
    ])
        rotate([-90, 0, 0])
            cylinder(
                d = platform_lug_hole_diameter,
                h = platform_lug_thickness
                    + 2 * stand_index_tooth_height
                    + 2 * epsilon
            );
}

module weighted_base_platform() {
    color(platform_color)
        difference() {
            union() {
                hollow_platform_shell();
                platform_lug_reinforcement();
                platform_lug_core();
                platform_lug_index_rings();
            }

            platform_lug_hole();
        }
}

module platform_slider_lid() {
    color(platform_lid_color)
        linear_extrude(height = platform_lid_thickness)
            rounded_rectangle_2d(
                platform_lid_length,
                platform_lid_width,
                platform_lid_corner_radius
            );
}

module platform_fit_preview() {
    weighted_base_platform();

    translate([
        platform_lid_closed_center_x,
        0,
        platform_lid_groove_bottom
            + (platform_lid_groove_height - platform_lid_thickness) / 2
    ])
        platform_slider_lid();
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

module m12_bolt_with_shank(smooth_length, thread_length) {
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
                    h = smooth_length + 2 * epsilon
                );

            translate([
                0,
                0,
                bolt_head_height + smooth_length - epsilon
            ])
                external_bolt_thread(thread_length + epsilon);
        }
}

module m12_bolt() {
    m12_bolt_with_shank(bolt_smooth_length, bolt_thread_length);
}

module m12_stand_bolt() {
    m12_bolt_with_shank(
        stand_bolt_smooth_length,
        stand_bolt_thread_length
    );
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
        || part == "stand_bolt"
        || part == "nut"
        || part == "stand"
        || part == "stand_flat"
        || part == "stand_long_side"
        || part == "platform"
        || part == "platform_lid"
        || part == "platform_preview"
        || part == "fit_preview",
    str("Unknown part: ", part)
);

if (part == "all") {
    circle_holder();

    if (show_magsafe_reference)
        magsafe_reference();

    translate([-48, 0, 0])
        m12_bolt();

    translate([-48, 36, 0])
        m12_stand_bolt();

    translate([-72, 0, 0])
        m12_nut();

    translate([-110, 0, 0])
        vertical_support_stand();

    translate([130, 0, 0])
        weighted_base_platform();

    translate([130, -90, 0])
        platform_slider_lid();
} else if (part == "holder") {
    circle_holder();
} else if (part == "bolt") {
    m12_bolt();
} else if (part == "stand_bolt") {
    m12_stand_bolt();
} else if (part == "nut") {
    m12_nut();
} else if (part == "stand") {
    vertical_support_stand_for_print();
} else if (part == "stand_flat") {
    vertical_support_stand_flat_for_print();
} else if (part == "stand_long_side") {
    vertical_support_stand_long_side_for_print();
} else if (part == "platform") {
    weighted_base_platform();
} else if (part == "platform_lid") {
    platform_slider_lid();
} else if (part == "platform_preview") {
    platform_fit_preview();
} else if (part == "fit_preview") {
    fastener_fit_preview();
}
