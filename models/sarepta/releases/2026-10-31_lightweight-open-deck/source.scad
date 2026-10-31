// Lightweight print-feedback revision, at the accepted 170 mm scale.
// Model allowances, not newly established prototype dimensions.
use <../2026-10-23_bow-plan-proportions/source.scad>
use <../2026-10-27_horizontal-reinforced/source.scad>
use <../2026-10-28_partition-joint/source.scad>
use <../2026-10-28_serviceable-dashboard/source.scad>
part="layout"; // [lower, upper, dashboard, pin, assembly, layout, section]
sf=170/4600;
join_z=25;
roof_z=750*sf+2.4;
skin=1.0;
rib_width=0.8;
rib_depth=1.0;
face_x=1600*sf;
// Both halves share these axes; positions are checked against actual meshes.
pin_centres=[[33,-24.4],[33,24.4],[160,-25.1],[160,25.1]];
pin_d=1.6;
bore_d=1.85;
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
module bores(lower=true) {
    for(p=pin_centres)
        translate([p[0],p[1],lower?join_z-bore_depth:join_z-0.02])
            cylinder(d=bore_d,h=bore_depth+0.02,$fn=40);
}
module rear_raise() {
    // Half the remaining rise to the gunwale; retain a central motor notch.
    seat=375*sf;
    shoulder=425*sf;
    target_centre=(seat+roof_z)/2;
    target_shoulder=(shoulder+roof_z)/2;
    for(side=[-1,1]) translate([167.98,side==1?180*sf:-560*sf,shoulder-0.05])
        cube([2,380*sf,target_shoulder-shoulder+0.05]);
    translate([167.98,-180*sf-0.04,seat-0.05])
        cube([2,360*sf+0.08,target_centre-seat+0.05]);
}
module lower() {
    difference() {
        union() {
            difference() {
                import("../2026-10-28_partition-joint/2026-10-28_sarepta_170mm_partition_joint_lower.stl",convexity=30);
                flange_only();
            }
            // Fill superseded large aft bores before clearing their inward bosses.
            for(y=[-22,22]) translate([160,y,20.78]) cylinder(d=4.35,h=4.22,$fn=64);
            rear_raise();
        }
        open_front_cut();
        bores(true);
    }
}
module upper_outer() {
    intersection() {
        union() {
            translate([0,0,2.4]) upper_volume();
            translate([0,0,25]) linear_extrude(height=2.45) landing_outer_plan();
        }
        translate([-5,-45,join_z]) cube([180,90,20]);
    }
}
module upper_hollow() {
    // One top skin with a completely open underside: no lower foredeck sheet.
    translate([0,0,join_z-0.05]) linear_extrude(height=roof_z-skin-join_z+0.05)
        offset(delta=-1.2) polygon(upper_plan());
    // Upper cockpit and motor-well openings are preserved.
    translate([face_x,-20.65,join_z-0.1]) cube([4000*sf-face_x,41.3,20]);
    translate([4000*sf+1.2,-560*sf,join_z-0.1]) cube([30,1120*sf,20]);
}
module hatch_through() {
    translate([0,0,-10]) linear_extrude(height=60) projection() hatch_opening();
}
module top_skin() {
    // Rebuild the roof independently of inherited clearance/storage cuts.
    translate([0,0,roof_z-skin]) linear_extrude(height=skin)
        intersection() {
            polygon(upper_plan());
            translate([-2,-40]) square([face_x+2,80]);
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
            translate([0,0,2.4]) foredeck_details();
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
