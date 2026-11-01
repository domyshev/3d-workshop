// Remove remaining bow-floor remnants from the verified level-stern assembly.
// The accepted outer hull and genuine bottom stringers are retained.
use <../2026-10-31_level-stern-ribs/source.scad>
use <../2026-10-23_bow-plan-proportions/source.scad>
part="assembly"; // [lower, upper, pin, assembly, layout, section]
show_dashboard=false;
sf=170/4600;
module bow_seed() {
    intersection() {
        body_blank();
        translate([-5,-40,-2]) cube([70,80,42]);
    }
}
module protected_bottom_stringers() {
    // Keep all existing longitudinal stringers ahead of the first floor frame.
    web=0.75;
    depth=max(0.65,28*sf);
    for(y=[-350*sf,0,350*sf])
        translate([1450*sf-0.05,y-web/2,-1])
            cube([62-1450*sf+0.05,web,1+1.2+depth+abs(y)*tan(8.5)+0.02]);
}
module bow_cleanup() {
    directions=[for(a=[-1,0,1],b=[-1,0,1],c=[-1,0,1])
        if(norm([a,b,c])>0) [a,b,c]/norm([a,b,c])];
    difference() {
        intersection() {
            bow_seed();
            // A 26-direction shell envelope reaches floor/side junctions which
            // the former rectangular side-only cavity cuts missed.
            intersection_for(d=directions) translate(1.20*d) bow_seed();
            new_inner_envelope(1.25);
            translate([0,-40,-1]) cube([61.5,80,24.30]);
        }
        protected_bottom_stringers();
    }
}
module lower() {
    difference() {
        import("../2026-10-31_level-stern-ribs/2026-10-31_sarepta_170mm_level_stern_lower.stl",convexity=40);
        bow_cleanup();
    }
}
$vpr=[65,0,35];$vpt=[85,25,15];$vpd=700;
color([0.62,0.78,0.82]) {
    if(part=="lower") lower();
    else if(part=="upper") upper();
    else if(part=="pin") pin();
    else if(part=="assembly") {lower();upper();}
    else if(part=="section") difference() {
        union() {lower();upper();}
        translate([-2,-40,-2]) cube([180,40,50]);
    }
    else if(part=="layout") {
        lower();
        translate([0,130,55.5793476105]) rotate([180,0,0]) upper();
        for(i=[0:3]) translate([215+i*12,-15,0]) pin();
    }
}
