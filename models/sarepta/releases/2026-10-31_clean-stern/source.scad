// Clean stern, continuous glue rim and matched guides at the accepted 170 mm scale.
// Model allowances, not newly established prototype dimensions.
use <../2026-10-23_bow-plan-proportions/source.scad>
use <../2026-10-27_horizontal-reinforced/source.scad>
use <../2026-10-28_partition-joint/source.scad>
use <../2026-10-28_serviceable-dashboard/source.scad>
include <continuation.scad>
part="assembly"; // [lower, upper, dashboard, pin, assembly, layout, section]
sf=170/4600;
join_z=25;
roof_z=750*sf+2.4;
skin=1.0;
rib_width=0.8;
rib_depth=1.0;
face_x=1600*sf;
// Both halves share these axes; positions are checked against actual meshes.
pin_centres=[[33,-23.6],[33,23.6],[160,-24.4],[160,24.4]];
pin_d=1.6;
bore_d=2.0;
bore_depth=1.1;
module below_join() {translate([-5,-45,-2]) cube([180,90,27]);}
module glue_core() {offset(delta=-4) landing_outer_plan();}
module open_front_cut() {
    // Restrict locker-wall removal to the existing void, leaving the bottom intact.
    intersection() {
        translate([0,0,0.02]) safe_inner();
        translate([50.45,-20.65,-1]) cube([1.4,41.3,27]);
    }
    // Shelf and old instrument face, wholly inside the original cockpit outline.
    translate([51.74,-20.65,19.9]) cube([face_x+0.2-51.74,41.3,5.2]);
    // Old front bosses and short webs; the four-millimetre outer lands survive.
    translate([29.5,-21,19.8]) cube([7,42,5.3]);
    // Remove old aft socket projections below the glue land, inside the plating.
    difference() {
        union() {
            translate([156.5,-25,19.8]) cube([7,50,3.6]);
            translate([156.5,-23.2,23.39]) cube([7,46.4,1.7]);
        }
        // Preserve the motor-well sidewalls while removing the inward bosses.
        for(side=[-1,1]) translate([156.4,side==1?560*sf:-560*sf-1.2,19.7])
            cube([7.2,1.2,5.5]);
    }
}
// Shared blind bores: 0.4 mm diametral clearance for a 1.6 mm pin.
module bores(lower=true) {
    for(p=pin_centres) {
        translate([p[0],p[1],lower?join_z-bore_depth:join_z-0.02])
            cylinder(d=bore_d,h=bore_depth+0.02,$fn=64);
        // A short lead-in guides insertion without enlarging the full bore.
        if(lower) translate([p[0],p[1],join_z-0.15])
            cylinder(d1=bore_d,d2=2.3,h=0.16,$fn=64);
        else translate([p[0],p[1],join_z-0.01])
            cylinder(d1=2.3,d2=bore_d,h=0.16,$fn=64);
    }
}
well_front=4000*sf;
well_half=560*sf;
rim_width=4;
rim_bottom=23.35;
transom_front=167.95;
old_seat=375*sf;
old_shoulder=425*sf;
transom_seat=old_seat+(roof_z-old_seat)/4;
transom_shoulder=old_shoulder+(roof_z-old_shoulder)/4;
old_drain_radius=max(0.4,15*sf);
drain_diameter=4*old_drain_radius;
drain_floor=(230-15*(4600-2/sf-4000)/600)*sf;
drain_z=drain_floor+drain_diameter/2-0.15;
module previous_lower() {
    import("../2026-10-31_fair-cover-joint/2026-10-31_sarepta_170mm_fair_lower.stl",convexity=40);
}
module top_band() {
    translate([-5,-40,rim_bottom]) cube([180,80,join_z-rim_bottom]);
}
module rim_open_plan() {
    // Extend the inner offset beyond the stern: no unwanted transverse bridge.
    positive=concat([for(p=join_profile) [p[0],p[1]]],[[180,join_profile[len(join_profile)-1][1]]]);
    outline=concat(positive,[for(i=[len(positive)-1:-1:0]) [positive[i][0],-positive[i][1]]]);
    offset(delta=-rim_width) polygon(outline);
}
module clean_rim_cut() {
    translate([0,0,rim_bottom]) linear_extrude(height=5) rim_open_plan();
}
module aft_cavity_envelope() {
    // Bound the larger well opening by the actual exterior, not the old box wall.
    // Two shifted solids retain 1.2 mm horizontal side skin at every height.
    intersection() {
        translate([0,1.2,0]) body_blank();
        translate([0,-1.2,0]) body_blank();
    }
}
module aft_above_floor() {
    floor_slope=-15/600;
    multmatrix([[1,0,0,0],[0,1,0,0],
        [floor_slope,0,1,(230-floor_slope*4000)*sf],[0,0,0,1]])
        translate([well_front+1.2,-40,0]) cube([transom_front-well_front-1.2,80,30]);
}
module aft_side_wall_cut() {
    intersection() {
        aft_cavity_envelope();
        // Stay inside the accepted lower-side cavity, clear of the protective rim.
        translate([0,0.03,0]) safe_inner();
        translate([0,-0.03,0]) safe_inner();
        aft_above_floor();
        translate([well_front+1.2,-40,0]) cube([transom_front-well_front-1.2,80,rim_bottom+0.001]);
    }
}
module aft_side_ribs() {
    intersection() {
        // Keep native ribs inside the old mesh skin with a positive overlap.
        intersection_for(delta=[[0.65,0,0],[-0.65,0,0],[0,0.65,0],[0,-0.65,0],[0,0,0.65],[0,0,-0.65]])
            translate(delta) body_blank();
        union() {
            translate([0,0.25,0]) safe_inner();
            translate([0,-0.25,0]) safe_inner();
        }
        translate([0,0,-0.08]) aft_above_floor();
        union() {
            for(x=[154,162]) for(side=[-1,1])
                translate([x-0.4,side==1?21.4:-35,0])
                    cube([0.8,13.6,rim_bottom]);
            // Retain the original three floor-to-transom knees as ribs.
            framing_members();
        }
    }
}
module whole_transom() {
    // One full-depth plate, with a single rear plane at X=170, not an inset cap.
    intersection() {
        body_blank();
        union() {
            translate([transom_front,-180*sf,-1])
                cube([170-transom_front,360*sf,transom_seat+1]);
            for(side=[-1,1]) translate([transom_front,side==1?180*sf:-well_half,-1])
                cube([170-transom_front,well_half-180*sf,transom_shoulder+1]);
        }
    }
}
module new_drains() {
    for(y=[-430*sf,430*sf]) translate([transom_front-0.2,y,drain_z])
        rotate([0,90,0]) cylinder(d=drain_diameter,h=170-transom_front+0.4,$fn=64);
}
module lower() {
    difference() {
        union() {
            difference() {
                union() {
                    previous_lower();
                    // Refill old notches before cutting one continuous offset rim.
                    intersection() {
                        translate([0.03,0,0]) body_blank();
                        translate([-0.03,0,0]) body_blank();
                        translate([0,0.03,0]) body_blank();
                        translate([0,-0.03,0]) body_blank();
                        top_band();
                    }
                }
                clean_rim_cut();
                aft_side_wall_cut();
                // Remove the complete old motor seat, including the inset upper cap.
                translate([transom_front,-well_half-0.001,-1])
                    cube([3,2*well_half+0.002,40]);
            }
            // Preserve the intended well-front partition up to the glue plane.
            translate([well_front-1.2,-well_half-0.1,rim_bottom-0.08])
                cube([1.2,2*well_half+0.2,join_z-rim_bottom+0.08]);
            aft_side_ribs();
            whole_transom();
        }
        bores(true);
        new_drains();
    }
}
// Continue the lower outer side at the existing horizontal glue plane.
module upper_outer() { continuation_blank(); }
module upper_hollow() {
    // Conservative XY erosion leaves at least 1.2 mm in the plan normal.
    // The open underside stops 1 mm below the preserved roof height.
    intersection() {
        translate([1.2,0,0]) upper_outer();
        translate([-1.2,0,0]) upper_outer();
        translate([0,1.2,0]) upper_outer();
        translate([0,-1.2,0]) upper_outer();
        translate([-5,-45,join_z-0.05]) cube([180,90,roof_z-skin-join_z+0.05]);
    }
    translate([face_x,-20.65,join_z-0.1]) cube([4000*sf-face_x,41.3,20]);
    translate([4000*sf+1.2,-560*sf,join_z-0.1]) cube([30,1120*sf,20]);
}
module hatch_through() {
    translate([0,0,-10]) linear_extrude(height=60) projection() hatch_opening();
}
module top_skin() {
    intersection() {
        upper_outer();
        translate([-5,-40,roof_z-skin]) cube([face_x+5,80,skin]);
    }
}
module small_ribs() {
    intersection() {
        upper_outer();
        union() {
            for(x=[24,35,54]) translate([x,-30,roof_z-skin-rib_depth])
                cube([rib_width,60,rib_depth+0.05]);
            // Short fore/aft webs connect the hatch sides to the roof.
            for(y=[-10.2,10.2]) translate([32,y-rib_width/2,roof_z-skin-rib_depth])
                cube([24,rib_width,rib_depth+0.05]);
        }
    }
}
module upper() {
    difference() {
        union() {
            difference() {upper_outer();upper_hollow();}
            top_skin();
            intersection() {
                translate([0,0,2.4]) foredeck_details();
                linear_extrude(height=40) projection() upper_outer();
            }
            small_ribs();
            // Minimal local material around blind glue-guide holes, inside the belt.
            intersection() {
                upper_outer();
                for(p=pin_centres) translate([p[0],p[1],join_z])
                    cylinder(d=3.0,h=1.7,$fn=48);
            }
            // Integral hidden lap ahead of the panel masks its insertion clearance.
            translate([face_x-2.5,-20.65,roof_z-1.55]) cube([0.55,41.3,0.6]);
        }
        hatch_through();
        bores(false);
        // Dashboard can be inserted from below and glued at its side ends.
        translate([face_x-1.25,-20.65,join_z-0.02]) cube([1.5,41.3,roof_z-join_z-0.93]);
    }
}
module dashboard() {
    // One thin panel; no shelf, stop bar, sockets or lower sealed partition.
    // Its upper lip hides the 0.15 mm fitting clearance beneath the roof.
    union() {
        translate([face_x-1.2,-20.4,roof_z-7.4]) cube([1.2,40.8,6.25]);
        translate([face_x-1.9,-20.4,roof_z-2.0]) cube([1.9,40.8,0.85]);
    }
}
module pin() {
    // Glue locator, not a structural dowel. Slight lead-ins at both ends.
    hull() {
        translate([0,0,0.2]) cylinder(d=pin_d,h=1.6,$fn=40);
        cylinder(d=1.25,h=2.0,$fn=40);
    }
}
$vpr=[65,0,35];$vpt=[85,25,15];$vpd=700;
color([0.67,0.67,0.67]) {
    if(part=="lower") lower();
    else if(part=="upper") upper();
    else if(part=="dashboard") dashboard();
    else if(part=="pin") pin();
    else if(part=="assembly") {lower();upper();dashboard();}
    else if(part=="section") difference() {
        union() {lower();upper();dashboard();}
        translate([-2,-40,-2]) cube([180,40,50]);
    }
    else if(part=="layout") {
        lower();
        translate([0,78,roof_z+join_z]) rotate([180,0,0]) upper();
        translate([25,-55,-roof_z+7.4]) dashboard();
        for(i=[0:3]) translate([100+i*5,-40,0]) pin();
    }
    else assert(false,"Unknown lightweight part selector");
}
