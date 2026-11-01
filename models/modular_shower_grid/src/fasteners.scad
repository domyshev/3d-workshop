// Stud 6.5+15+6.5 mm; sharp 16-tooth knob, overall diameter 8 mm, height 6 mm.
// Knob without adhesion ring; overall height remains 6 mm.
use <lib/threads.scad>
part = "layout"; // [layout,stud,knob]
with_pad = false;
pad_height = 0.2;
stud_pad_diameter = 14;
knob_pad_diameter = 12;
thread_length = 6.5;
smooth_length = 15;
thread_diameter = 5.65;
smooth_diameter = 5.85;
nut_thread_diameter = 6.3;
thread_pitch = 1;
knob_height = 6;
knob_outer_diameter = 8;
knob_root_diameter = 7.2;
teeth = 16;
$fn = 64;
epsilon = 0.02;
part_z = with_pad ? pad_height : 0;

module stud_body() {
    union() {
        metric_thread(diameter = thread_diameter, pitch = thread_pitch,
                      length = thread_length, internal = false, leadin = 3);
        translate([0, 0, thread_length - epsilon])
            cylinder(d = smooth_diameter, h = smooth_length + 2 * epsilon);
        translate([0, 0, thread_length + smooth_length])
            metric_thread(diameter = thread_diameter, pitch = thread_pitch,
                          length = thread_length, internal = false, leadin = 1);
    }
}

module stud() {
    union() {
        if (with_pad) cylinder(d = stud_pad_diameter, h = pad_height);
        translate([0, 0, part_z]) stud_body();
    }
}

module knob_body() {
    difference() {
        // Alternating sharp tips and roots, extruded into vertical gripping edges.
        linear_extrude(height = knob_height)
            polygon(points = [for (i = [0 : 2 * teeth - 1])
                let(a = i * 180 / teeth,
                    r = (i % 2 == 0 ? knob_outer_diameter : knob_root_diameter) / 2)
                [r * cos(a), r * sin(a)]]);
        translate([0, 0, -epsilon])
            metric_thread(diameter = nut_thread_diameter, pitch = thread_pitch,
                          length = knob_height + 2 * epsilon,
                          internal = true, leadin = 2);
        translate([0, 0, -epsilon])
            cylinder(d1 = nut_thread_diameter + 0.2,
                     d2 = nut_thread_diameter - 1.2, h = 0.7);
        translate([0, 0, knob_height - 0.7 + epsilon])
            cylinder(d1 = nut_thread_diameter - 1.2,
                     d2 = nut_thread_diameter + 0.2, h = 0.7);
    }
}

module knob() {
    knob_body();
}

echo("Thread / smooth / thread", [thread_length, smooth_length, thread_length]);
echo("Functional stud length", 2 * thread_length + smooth_length);
echo("External / internal thread diameters", [thread_diameter, nut_thread_diameter]);
echo("Knob OD / root OD / teeth / height", [knob_outer_diameter, knob_root_diameter, teeth, knob_height]);
if (part == "stud") stud();
else if (part == "knob") knob();
else if (part == "layout") {
    stud();
    translate([24, 0, 0]) knob();
}
else assert(false, "Unknown part selector");
