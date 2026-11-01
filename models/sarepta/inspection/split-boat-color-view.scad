// Colored inspection scene of the 340 mm split Sarepta.
// The left group shows the assembled boat; the right group shows the same parts separately.
$vpr = [55, 0, 28];
$vpt = [365, 110, 15];
$vpd = 1450;

lower_bow_color = [0.62, 0.79, 0.82];
lower_stern_color = [0.68, 0.78, 0.68];
upper_bow_color = [0.96, 0.79, 0.69];
upper_stern_color = [0.94, 0.87, 0.66];
rim_bow_color = [0.78, 0.70, 0.86];
rim_port_color = [0.87, 0.71, 0.78];
rim_starboard_color = [0.68, 0.77, 0.91];

module hull(piece) {
    import(str("../releases/2026-11-01_lid-through-bolts/2026-11-01_sarepta_340mm_lid_through_", piece, ".stl"), convexity=20);
}
module rim(piece) {
    scale(2) import(str("../releases/2026-11-01_front-skirt-sockets/2026-11-01_sarepta_170mm_front_skirt_rim_", piece, ".stl"), convexity=20);
}
module assembled() {
    color(lower_bow_color) hull("lower_bow");
    color(lower_stern_color) hull("lower_stern");
    color(upper_bow_color) hull("upper_bow");
    color(upper_stern_color) hull("upper_stern");
    color(rim_bow_color) rim("bow");
    color(rim_port_color) rim("port");
    color(rim_starboard_color) rim("starboard");
}
assembled();

// The two hull halves and two lid halves are arranged in two rows.
color(lower_bow_color) translate([420, 0, 0]) hull("lower_bow");
color(lower_stern_color) translate([440, 0, 0]) hull("lower_stern");
color(upper_bow_color) translate([420, 145, -50]) hull("upper_bow");
color(upper_stern_color) translate([440, 145, -50]) hull("upper_stern");

// All three skirt pieces are separated for inspection.
color(rim_bow_color) translate([420, 300, -38]) rim("bow");
color(rim_port_color) translate([455, 365, -38]) rim("port");
color(rim_starboard_color) translate([455, 335, -38]) rim("starboard");
