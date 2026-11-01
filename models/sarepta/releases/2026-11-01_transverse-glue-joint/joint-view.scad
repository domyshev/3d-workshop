boat_length_mm=340;
cut_x=boat_length_mm/2;
color([.62,.78,.82])import(str("2026-11-01_sarepta_",boat_length_mm,"mm_joint_lower_bow.stl"),convexity=40);
color([.70,.82,.83])translate([35,0,0])import(str("2026-11-01_sarepta_",boat_length_mm,"mm_joint_lower_stern.stl"),convexity=40);
