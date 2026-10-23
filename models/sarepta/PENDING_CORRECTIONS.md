# Correction status — 2026-10-23

The evidence/archive checkpoint was committed and pushed as `cc04d8c` before
geometry revision. The new [dimension/framing release](releases/2026-10-23_dimensions-framing/README.md)
implements the following changes. All dimensions are prototype mm unless stated.

| Item | Status | Remaining qualification |
| --- | --- | --- |
| Side height | Applied: upper deck datum 750; belt included below it | Seam heights 670..550 and upper setbacks 40..50 are estimated |
| Motor transom | Applied: centre seat 375, shoulders 425 | Notch depth 50, width 360 and vertical panel rake are reconstructed |
| Cockpit | Applied: opening envelope 2600 x 1280 | Placement X=1400..4000 remains estimated |
| Aft bottom | Retained: guide beam 1300, approx. 8.5 degrees | Guide width excludes added 30 mm chine flanges; factory measurement endpoints need confirmation |
| Bow locker | Applied: separated by full bulkhead | Bulkhead placement and locker volume not factory-certified |
| Internal framing | Applied: transverse floors/side frames, longitudinal members, transom knees | Frame positions and profiles simplified and thickened for printing; no kit X lattice copied |
| Side corrugations | Applied: two ridges on each side | Width, depth and endpoints estimated |
| Chine spray flange | Applied: nominal 30 wide | Thickness enlarged to >=0.35 model mm; forward taper estimated |
| Protective rim | Preserved: normal 50 overhang | User estimate; published 2 x 20 x 25 profile does not establish installed overhang |
| Motor well | Applied: raised floor, estimated fall to stern | Exact floor height/slope, panel rake and scupper layout unresolved; scuppers not modelled |
| Hatch/pad/paired ribs | Preserved | 500 x 450 opening, pad/rib dimensions and positions remain visual estimates |
| Production variant | Coherent early 4600 x 1600 envelope retained | Passport length/beam ambiguity and later production construction are not merged into an exact variant |

Cabin, hatch lid and outboard motors are future separate parts. No physical
print has been verified. The 80 and 170 mm binary STLs pass current paired-edge,
vertex-link, positive-volume and single-component checks. Published sources
and their conflicts remain in [the dimensional audit](DIMENSION_RESEARCH.md).
