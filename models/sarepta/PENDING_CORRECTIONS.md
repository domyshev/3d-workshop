# Correction status — 2026-10-23

The evidence/archive checkpoint was committed and pushed as `cc04d8c` before
geometry revision. The new [dimension/framing release](releases/2026-10-23_dimensions-framing/README.md)
implements the following changes. All dimensions are prototype mm unless stated.

| Item | Status | Remaining qualification |
| --- | --- | --- |
| Side height | Applied: upper deck datum 750; belt included below it | Seam heights 670..550 and upper setbacks 40..50 are estimated |
| Motor transom | Applied: centre seat 375, shoulders 425 | Notch depth 50, width 360 and vertical panel rake are reconstructed |
| Cockpit | Interior-envelope reference 2600 x 1280; widened upper landings produce a 1120 upper opening | Placement and ledge widths remain reconstructed |
| Aft bottom | Retained: guide beam 1300, approx. 8.5 degrees | Guide width excludes added 30 mm chine flanges; factory measurement endpoints need confirmation |
| Bow locker / leg space | Applied: stepped sealed boundary, upper instrument face 200 high, footwell reach 200 | Step dimensions and locker volume not factory-certified |
| Internal framing | Applied: transverse floors/side frames, longitudinal members, transom knees | Frame positions and profiles simplified and thickened for printing; no kit X lattice copied |
| Side corrugations | Corrected: horizontal at Z=280/425, flat ends, X=1600..4600 | Forward station, heights, width and depth remain photo estimates |
| Chine spray flange | Applied: nominal 30 wide | Thickness enlarged to >=0.35 model mm; forward taper estimated |
| Protective rim | Preserved: normal 50 overhang | User estimate; published 2 x 20 x 25 profile does not establish installed overhang |
| Motor well | Applied: raised floor, estimated fall to stern | Exact floor height/slope and panel rake unresolved; two scuppers now modelled with estimated layout |
| Foredeck / hatch / pad | Upper deck front 1600, hatch centre 1200, pad rear 1550; straight 560-long beads | Photo-based placement; passport hatch diagram conflicts with kit |
| Production variant | Coherent early 4600 x 1600 envelope retained | Passport length/beam ambiguity and later production construction are not merged into an exact variant |

Cabin, hatch lid and outboard motors are future separate parts. No physical
print has been verified. The 80 and 170 mm binary STLs pass current paired-edge,
vertex-link, positive-volume and single-component checks. Published sources
and their conflicts remain in [the dimensional audit](DIMENSION_RESEARCH.md).

Latest visual correction: [straight side ridges](releases/2026-10-23_straight-side-ridges/README.md).

Latest interior revision: [footwell and wider landings](releases/2026-10-23_footwell-landings/README.md).
Four backed storage recesses and boxed inner returns are included. Seats,
removable floor panels, anchor-divider details, working self-bailer and final
cabin-track mating geometry remain unmeasured/separate future parts. See
[interior research](INTERIOR_RESEARCH.md) for the fuller feature audit.

Latest coordinated plan revision: [bow proportions](releases/2026-10-23_bow-plan-proportions/README.md).
The upper opening is now 2400 long; the forward footwell starts at 1400 and
the well at 4000, giving a 2600 interior reference. This interpretation of
the published cockpit datum is provisional. See `BOW_PLAN_REVIEW.md`.
The gradual shoulder starts at 1550, before the upper opening at 1600.

## Print feedback and assembly revision — 2026-10-27

The user reports that the 2026-10-25 lower bow deformed during printing and
that the inclined/stepped split mated poorly. Heat was suspected, not measured.
The latest horizontal reinforced release supersedes that assembly design.
It transfers the rim and reinforced nose landing to the lower half, removes
the internal mating steps, sets the functional join to Z=25 mm, and raises
the upper by 2.4 mm for vertical blind sockets. New parts must be used as a
matched pair. Prior source-backed dimensions still refer to the unraised
prototype reconstruction. The earlier print failed; the new print is untested.

## Access correction — 2026-10-27

The user rejected the full forward landing because it defeated the removable
cover's purpose. Replace it with a nominal 4 mm horizontal perimeter glue land,
retaining a locally reinforced raised nose edge and small pin-seat webs.
The latest open-rim release implements this and reuses the accepted non-pocketed
upper unchanged. The bow is accessible before fitting the cover; the lower
locker wall, footwell shelf and main aft framing remain. No additional height
change. The previous closed-top horizontal lower is superseded, not erased.

## Partition contact correction — 2026-10-28

The user identified a vertical gap above the dashboard in the open-rim lower.
Actual mesh rays confirmed the partition stopped at 23.35 while the upper starts
at 25 mm. The same 1.65 mm slit existed above the motor-well partition. The
access cutter now protects these narrow wall tops. Both meet the unchanged
cover at Z=25; 164 wall-contact samples, 5128 rim/contact samples, 642 exterior
samples and all 25 material probes pass. No new deck sheet closes the open bow.
See `releases/2026-10-28_partition-joint/README.md`; physical fit is untested.

## Serviceable dashboard and socket reinforcement — 2026-10-28

Implemented full-height front socket webs with sloped roots, a separate panel
and footwell shelf on open-ended guides, and a lift-out two-peg stop bar.
The fixed forward compartment wall remains; the upper cover loses its internal
dashboard continuation while keeping the exterior. The lower projecting chine
strip is removed with a 0.015 mm skin allowance. All four STL meshes and sampled
material, movement and contact checks pass; physical fit is untested. See
`releases/2026-10-28_serviceable-dashboard/README.md` for dimensions, limits,
print orientation and removal sequence. Use the updated upper for this version.

## Release candidate 0.1 and successful print — 2026-10-30

The owner reports an excellent print of the latest variant and nominates it
as the candidate for release 0.1. Crucially, the model was manually rotated
lengthwise along the bed, parallel to an edge, **not diagonally**. Use this as
the successful print baseline. X-versus-Y alignment and exact printed-part
coverage were not specified. The last prepared job was the original second
plate, extracted to a single-plate file.

The archived white 3MFs still contain the earlier 45-degree preparation and
must not be mistaken for the saved successful placement. No geometry, process
settings or archived binary was changed by this documentation update. Reset
the in-plane angle, check bed clearance and re-slice when reproducing the
baseline. See `release-candidates/0.1/README.md` and its artifact hash manifest.
Assembly fit and watertightness remain unconfirmed; no final release tag made.
