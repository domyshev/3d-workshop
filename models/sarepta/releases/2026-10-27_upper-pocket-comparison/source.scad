// Comparison-only upper-deck variant; the accepted lower hull is unchanged.
part = "upper"; // [upper, pockets]
join_z_mm = 25;
roof_pocket_top_mm = 28.9;
perimeter_land_mm = 2.4;
rib_width_mm = 1.2;
pin_keep_radius_mm = 4.4;
pin_centres = [[33,-17],[33,17],[160,-22],[160,22]];
module parent_upper() {
    import("../2026-10-27_horizontal-reinforced/2026-10-27_sarepta_170mm_horizontal_upper.stl",convexity=30);
}
module relief_domain() {
    difference() {
        intersection() {
            offset(delta=-perimeter_land_mm) projection() parent_upper();
            translate([8,-30]) square([48.7,60]);
        }
        for(p=pin_centres) translate(p) circle(r=pin_keep_radius_mm,$fn=64);
    }
}
module pocket_plan() {
    intersection() {
        relief_domain();
        union() for(xx=[[8,20],[21.2,33.2],[34.4,46.4],[47.6,56.7]],
                    yy=[[-25,-0.6],[0.6,25]])
            translate([xx[0]+0.8,yy[0]+0.8])
                offset(r=0.8,$fn=24)
                    square([xx[1]-xx[0]-1.6,yy[1]-yy[0]-1.6]);
    }
}
module roof_rib_plan() {
    intersection() {
        relief_domain();
        union() {
            for(x=[20,33.2,46.4]) translate([x,-30]) square([rib_width_mm,60]);
            translate([8,-rib_width_mm/2]) square([48.7,rib_width_mm]);
        }
    }
}
module pocket_upper() {
    difference() {
        union() {
            parent_upper();
            // Connect retained floor webs to the original roof skin across
            // the pre-existing shallow internal gap. Keep the pin regions out.
            translate([0,0,27.2]) linear_extrude(height=1.85) roof_rib_plan();
        }
        translate([0,0,join_z_mm-0.02])
            linear_extrude(height=roof_pocket_top_mm-join_z_mm+0.02) pocket_plan();
    }
}
if(part=="upper") color([0.68,0.68,0.68]) pocket_upper();
else if(part=="pockets") translate([0,0,join_z_mm]) linear_extrude(height=3.9) pocket_plan();
else assert(false,"Unknown pocket-study part selector.");
