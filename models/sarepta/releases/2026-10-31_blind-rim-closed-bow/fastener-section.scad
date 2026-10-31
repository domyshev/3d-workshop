// A thin section through one hidden headless pin; outside is toward positive Y.
include <locator-axes.scad>
module mesh(p){import(str("2026-10-31_sarepta_170mm_blind_rim_",p,".stl"),convexity=40);}
module slice(){translate([94.95,25,19])cube([.1,7,5]);}
color([.62,.78,.82])intersection(){mesh("lower");slice();}
color([.80,.71,.84])intersection(){mesh("rim_starboard");slice();}
p=locator_axes[3];
color([.70,.80,.69])translate([p[0],p[1]+.795,p[2]])rotate([90,0,0])mesh("rim_pin");
$vpr=[90,0,90];$vpt=[95,28,21.7];$vpd=18;
