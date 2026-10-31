// Coherent master-plan belt, aligned divider and open stern at 170 mm scale.
// Model allowances, not newly established prototype dimensions.
use <../2026-10-23_bow-plan-proportions/source.scad>
use <../2026-10-27_horizontal-reinforced/source.scad>
use <../2026-10-28_partition-joint/source.scad>
use <../2026-10-28_serviceable-dashboard/source.scad>
include <belt.scad>
show_dashboard=false;
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
drain_z=4.55; // The raised well floor is removed; outlet follows the bottom skin.
module rim_open_plan() {
    // Extend the inner offset beyond the stern: no unwanted transverse bridge.
    positive=concat([for(p=join_profile) [p[0],p[1]]],[[180,join_profile[len(join_profile)-1][1]]]);
    outline=concat(positive,[for(i=[len(positive)-1:-1:0]) [positive[i][0],-positive[i][1]]]);
    offset(delta=-rim_width) polygon(outline);
}
module clean_rim_cut() {
    translate([0,0,rim_bottom]) linear_extrude(height=5) rim_open_plan();
}
module new_drains() {
    for(y=[-430*sf,430*sf]) translate([transom_front-0.2,y,drain_z])
        rotate([0,90,0]) cylinder(d=drain_diameter,h=170-transom_front+0.4,$fn=64);
}
module old_clean_lower() {
    import("../2026-10-31_clean-stern/2026-10-31_sarepta_170mm_stern_lower.stl",convexity=40);
}
module above_old_seam(delta=0.04) {
    multmatrix([[1,0,0,0],[0,1,0,0],[-120/4600,0,1,670*sf+delta],[0,0,0,1]])
        translate([-20,-50,0]) cube([220,100,60]);
}
module new_inner_envelope(inset=1.2) {
    intersection() {
        translate([inset,0,0]) belt_full_blank();
        translate([-inset,0,0]) belt_full_blank();
        translate([0,inset,0]) belt_full_blank();
        translate([0,-inset,0]) belt_full_blank();
    }
}
module lower_belt() {
    difference() {
        intersection() {belt_blank();translate([-10,-50,-10]) cube([200,100,join_z+10]);}
        intersection() {
            new_inner_envelope();
            translate([-10,-50,-10]) cube([200,100,rim_bottom+10]);
        }
        clean_rim_cut();
        // Leave a genuinely open rear seat, with full-height side corners.
        translate([transom_front,-20.65,transom_shoulder]) cube([4,41.3,30]);
        translate([transom_front,-180*sf,transom_seat]) cube([4,360*sf,30]);
    }
}
module remove_raised_well_floor() {
    intersection() {
        translate([0,0.03,0]) safe_inner();
        translate([0,-0.03,0]) safe_inner();
        new_inner_envelope();
        translate([well_front+1.18,-40,-1]) cube([transom_front-well_front-1.20,80,40]);
    }
}
module new_aft_ribs() {
    intersection() {
        // A small overlap joins the ribs to the original bottom skin.
        union() {translate([0,0,-0.2]) safe_inner();translate([0,0.2,0]) safe_inner();translate([0,-0.2,0]) safe_inner();}
        new_inner_envelope(0.65);
        translate([well_front+1.2,-40,-1]) cube([transom_front-well_front-1.2,80,rim_bottom+1]);
        union() {
            framing_members();
            for(x=[154,162]) difference() {
                translate([x-.4,-35,-1]) cube([.8,70,26]);
                translate([x-.5,-21.4,220*sf]) cube([1,42.8,30]);
            }
        }
    }
}
module true_partition() {
    intersection() {
        new_inner_envelope(0.4);
        belt_blank();
        translate([well_front-0.05,-40,-1]) cube([1.3,80,join_z+1]);
    }
}
module fill_old_drains() {
    for(y=[-430*sf,430*sf]) translate([transom_front,y,drain_floor+drain_diameter/2-0.15])
        rotate([0,90,0]) cylinder(d=drain_diameter+0.08,h=170-transom_front,$fn=64);
}
module rear_corner_posts() {
    intersection() {
        belt_blank();
        for(side=[-1,1]) translate([transom_front,side==1?20.65:-40,-1])
            cube([170-transom_front,19.35,join_z+1]);
    }
}
module remove_legacy_bow_internals() {
    // Remove remnants of the former shelf, partition margins and old pin webs.
    // The original inner hull bounds the cut; current blind sockets stay above it.
    intersection() {
        translate([0,0,0.03]) safe_inner();
        translate([0,0.03,0]) safe_inner();
        translate([0,-0.03,0]) safe_inner();
        new_inner_envelope();
        union() {
            translate([24,19,-1]) cube([37.5,21,rim_bottom+1]);
            translate([24,-40,-1]) cube([37.5,21,rim_bottom+1]);
        }
    }
}
module remove_old_forward_webs() {
    // Old inner webs lie outside the legacy cavity cutter. Bound their removal
    // by a conservative erosion of the original filled hull, preserving its skin.
    intersection() {
        body_blank();
        intersection_for(delta=[[1.25,0,0],[-1.25,0,0],[0,1.25,0],[0,-1.25,0],[0,0,1.25],[0,0,-1.25]])
            translate(delta) body_blank();
        new_inner_envelope();
        union() {
            translate([0,19,-1]) cube([61.5,16,rim_bottom+1.02]);
            translate([0,-35,-1]) cube([61.5,16,rim_bottom+1.02]);
        }
    }
}
module lower() {
    difference() {
        union() {
            difference() {
                old_clean_lower();
                above_old_seam();
                remove_raised_well_floor();
                // Remove the incorrect forward cap and the old rear plate.
                translate([well_front-1.3,-40,23.2]) cube([1.3,80,4]);

            }
            lower_belt();
            true_partition();
            new_aft_ribs();
            fill_old_drains();
            rear_corner_posts();
        }
        remove_legacy_bow_internals();
        remove_old_forward_webs();
        bores(true);
        new_drains();
    }
}
// Continue the lower outer side at the existing horizontal glue plane.
module upper_outer() { intersection() {belt_blank();translate([-10,-50,join_z]) cube([200,100,40]);} }
module upper_hollow() {
    // Conservative XY erosion leaves at least 1.2 mm in the plan normal.
    // The open underside stops 1 mm below the preserved roof height.
    difference() {
        intersection() {
            new_inner_envelope();
            translate([-5,-45,join_z-0.05]) cube([180,90,roof_z-skin-join_z+0.05]);
        }
        translate([well_front-0.05,-40,join_z-0.1]) cube([1.3,80,20]);
    }
    translate([face_x,-20.65,join_z-0.1]) cube([4000*sf-face_x-0.05,41.3,20]);
    translate([4000*sf+1.25,-560*sf,join_z-0.1]) cube([30,1120*sf,20]);
}
module hatch_through() {
    translate([0,0,-10]) linear_extrude(height=60) projection() hatch_opening();
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

        }
        hatch_through();
        bores(false);

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
    else if(part=="assembly") {lower();upper();if(show_dashboard) dashboard();}
    else if(part=="section") difference() {
        union() {lower();upper();if(show_dashboard) dashboard();}
        translate([-2,-40,-2]) cube([180,40,50]);
    }
    else if(part=="layout") {
        lower();
        translate([0,78,roof_z+join_z]) rotate([180,0,0]) upper();
        if(show_dashboard) translate([25,-55,-roof_z+7.4]) dashboard();
        for(i=[0:3]) translate([100+i*5,-40,0]) pin();
    }
    else assert(false,"Unknown lightweight part selector");
}
