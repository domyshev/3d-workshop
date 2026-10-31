// Rotate the inclined skirt underside onto the print bed.
rotate([0,-atan(120/4600),0])
 translate([0,0,-(670*170/4600-1.2)])
  import("2026-10-31_sarepta_170mm_detachable_rim_starboard.stl",convexity=40);
