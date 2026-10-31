// Exact archived parts and a complete assembly in one inspection scene.
// All geometry is shown at its original scale. Rotate the view to inspect it.
show_parts = true;
show_assembly = true;
cover_upside_down = true;
$vpr = [58, 0, 30];
$vpt = [125, -5, 12];
$vpd = 900;

module lower() { import("2026-10-31_sarepta_170mm_fair_lower.stl", convexity=40); }
module upper() { import("2026-10-31_sarepta_170mm_fair_upper.stl", convexity=40); }
module dashboard() { import("2026-10-31_sarepta_170mm_fair_dashboard.stl", convexity=20); }
module pin() { import("2026-10-31_sarepta_170mm_fair_pin.stl", convexity=10); }
module assembly() {
    lower();
    upper();
    dashboard();
    // Pin midplanes coincide with the Z=25 mm glue joint.
    for (axis=[[33,-23.6],[33,23.6],[160,-24.4],[160,24.4]])
        translate([axis[0],axis[1],24]) pin();
}
color([0.67,0.67,0.67]) {
    if (show_parts) {
        // Separate body, right way up.
        lower();
        // Separate cover, inverted to expose its open underside and ribs.
        if (cover_upside_down)
            translate([0,130,30.5793476105]) rotate([180,0,0]) upper();
        else
            translate([0,130,-25]) upper();
        // Separate instrument panel, standing upright to the right of the body.
        translate([165,55,-22.7173919678]) dashboard();
        // Four separate glue locators, original size, well apart for inspection.
        for (i=[0:3]) translate([215+i*12,-15,0]) pin();
    }
    // Complete assembly, separated from the loose parts by 80+ mm.
    if (show_assembly) translate([0,-140,0]) assembly();
}
