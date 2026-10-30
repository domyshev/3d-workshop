# Sarepta 0.1 release candidate

Status recorded on **2026-10-30**: the owner reported that the latest variant
printed excellently and nominated this exact variant as a candidate for
**release 0.1**. This is a release candidate, not a final tagged release.

## Successful physical-print orientation — keep this distinction

**The owner rotated the model lengthwise along the bed, parallel to a bed edge,
not diagonally.** This is the confirmed successful orientation and the baseline
for reproducing this print. The owner did not specify whether the long axis was
parallel to printer X or Y; do not invent that detail.

The archived full white-filament 3MF and the extracted original second-plate
copy still contain the earlier **45-degree in-plane preparation**. Neither is
a saved copy of the owner's final successful placement. They have not been
silently edited. Before repeating this baseline, rotate the relevant large
part lengthwise, check brim/support clearance and re-slice. Do not describe the
archived diagonal G-code as the physically validated layout.

## Exact candidate references

- Geometry: [serviceable dashboard milestone](../../releases/2026-10-28_serviceable-dashboard/README.md).
  Reinforced front locating sockets, removable panel with shelf and stop bar,
  matching internally relieved upper, and no projecting lower chine strip.
- Material/process: [white PolyTerra project](../../print-projects/2026-10-28_serviceable-white/README.md).
  A1 mini, 0.4 mm nozzle, white Polymaker PolyTerra PLA, 0.16 mm layers, three
  wall loops, ordinary 15% Grid. These are the reference project settings;
  the explicitly reported manual adjustment was the in-plane orientation.
- The last prepared local job was the original second plate: upper, removable
  panel/shelf, stop bar and four locating pins, extracted into a single-plate
  file. That copy displays its sole plate as plate 1.
- [manifest.json](manifest.json) pins the original STL/project paths and hashes,
  including that extracted local project, without changing any model geometry.

## Evidence and remaining validation

The print outcome and orientation are owner-reported, not inferred from slicer
checks. The exact printed-part coverage was not specified, so do not promote
this to a claim that every part or the glued assembly has been physically
validated. No final-placement project file, photos or measurements were supplied.
Assembly fit, long-term strength, motor attachment and watertightness remain
separate checks. The older archive notes saying untested describe their state
at capture time; this dated note records the later physical-print feedback.
