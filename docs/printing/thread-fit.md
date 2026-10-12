# Printed Thread Fit Reference

These parameters preserve the original workshop notes for the M10 test in [`2026-07-02_sample_screw_and_hole.scad`](../../models/2026-07-02_sample_screw_and_hole.scad).

## Recorded M10 fit

```scad
bolt_d = 10;
bolt_pitch = 1.5;
bolt_h = 10;
thread_fit_clearance = 0.4;
bolt_fit_clearance = 0.2;
thread_leadin = 2;
```

The internal thread diameter is `bolt_d + thread_fit_clearance` (10.4 mm); the external thread diameter is `bolt_d - bolt_fit_clearance` (9.8 mm). Clearances change the diameter, not the radius. The 0.6 mm diametral difference corresponds to approximately 0.3 mm per side. Both mating parts must use the same pitch.

```scad
metric_thread(
    diameter = bolt_d - bolt_fit_clearance,
    pitch = bolt_pitch,
    length = bolt_h,
    internal = false,
    leadin = thread_leadin
);

metric_thread(
    diameter = bolt_d + thread_fit_clearance,
    pitch = bolt_pitch,
    length = bolt_h,
    internal = true,
    leadin = thread_leadin
);
```

## Tuning notes

The original notes for a Bambu Lab A1 mini with PETG and a 0.4 mm nozzle used internal diametral clearance values of 0.3–0.5 mm and external diameter reductions of 0.0–0.3 mm as starting points. These are tuning values, not universal guarantees.

If the bolt is difficult to start or turn, increase the external diameter reduction by 0.1 mm when reprinting only the bolt. When reprinting both parts, the internal clearance can also be adjusted. Reduce the relevant clearance if the fit is too loose.

`leadin = 2` in the adopted thread library creates lead-in chamfers at both ends.

## Other nominal sizes

- M8 × 1.25: `bolt_d = 8`, `bolt_pitch = 1.25`.
- M12 × 1.75: `bolt_d = 12`, `bolt_pitch = 1.75`.

The original starting clearances were 0.4 mm internally and a 0.2 mm external diameter reduction. Validate each new size by printing. When retaining an already printed threaded block, tune the mating bolt while preserving the pitch.

## Preview and final rendering

The sample uses `preview_fast = $preview`. OpenSCAD preview replaces threads with cylinders for responsiveness. Final rendering and export generate the actual thread geometry.
