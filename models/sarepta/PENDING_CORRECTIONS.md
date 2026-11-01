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

## Lightweight print-feedback revision — 2026-10-31

See [lightweight open deck](releases/2026-10-31_lightweight-open-deck/README.md)
for the new matched set. Single roof skin/open ribs, a single higher glue-in
panel without retainer, an opened central bow partition, thin side-strip glue
locators and a higher motor-transom top are implemented and digitally checked.
Physical fit, strength and flotation are untested; this does not replace the
reported successful-print baseline with a new physically verified release.

The protective perimeter rim is now separate in the detachable-rim milestone below.
Remaining construction requests: split lower and upper transversely with reinforced
locating joints; add a separately printable opening hatch lid and hinge. The hinge direction is
only photo-inferred at present, not established as a factory specification.

## Fair cover joint — 2026-10-31

Owner screenshots exposed bow-side thinning and cover-to-lower offset in the lightweight revision. The [fair-joint revision](releases/2026-10-31_fair-cover-joint/README.md) corrects the cover exterior and cavity and moves both halves' guide bores inward. Sampled join, tangent, wall and unchanged lower-exterior checks pass. Physical fit remains untested.

## Stern and guide corrections — 2026-10-31

The [clean-stern revision](releases/2026-10-31_clean-stern/README.md) replaces stepped mating-edge pockets, boxed stern sides and the inset transom cap. The added transom rise is halved; drain diameter is doubled; both halves' blind guide bores are enlarged to 2 mm with lead-ins for 1.6 mm pins. All sampled geometry checks pass. Physical printing, fit and drainage remain untested.

## Continuous belt and open stern — 2026-10-31

The [continuous-belt revision](releases/2026-10-31_continuous-belt/README.md) supersedes the triangle-normal fairing: straight planar V bow, trimmed shoulder offset, a shared surface across the horizontal join, closed rear corners, removed raised well floor and aligned full-height divider contact. The bottom remains unchanged in sampled comparisons. Physical print and fit remain untested.

## Panel hidden and obsolete bow supports removed — 2026-10-31

See [open-bow revision](releases/2026-10-31_open-bow/README.md). The dashboard is temporarily hidden, and its old shelf/lap and the excess internal bow webs are removed. External plating, bottom and current blind guide seats remain in place. Digital checks pass; print fit and strength remain untested.

## Level stern ribs and additional bow cleanup — 2026-10-31

The [current revision](releases/2026-10-31_clean-bow-floor/README.md) includes horizontal stern ribs stopped at the last transverse floor, two aligned outlets 0.8 mm above their crests, and removal of remaining inner bow-floor remnants. Original bottom/exterior and exposed stringer heights are unchanged in sampled comparisons. Physical print and fit remain untested.

## Detachable protective rim — 2026-10-31

See [detachable-rim revision](releases/2026-10-31_detachable-rim/README.md). The inward bow-board return is trimmed; the skirt is now three separately printable pieces with fourteen side-inserted micro pins and blind hull pockets. Actual archived mesh, sampled geometry and clearance checks pass; physical print and fit remain untested. Prior geometry checkpoint: [PR #1](https://github.com/domyshev/3d-workshop/pull/1).

## Closed bow cap and hidden skirt studs — 2026-11-01

The [new correction](releases/2026-10-31_blind-rim-closed-bow/README.md) removes the bow cutter that opened two triangular passages, restores the original cap and blends the board root. Separate 0.8 x 1.5 mm headless studs now enter blind pockets in both hull and skirt; neither component is pierced. Actual archived meshes, 564 inherited material checks and 458 additional probes pass, including 24 checks in the former bow openings. Physical printing and assembled fit remain untested.

## Fair inner bow-board root — 2026-11-01

The [fair-root revision](releases/2026-11-01_fair-bow-root/README.md) replaces the projecting rectangular root/end with one swept inner transition to the horizontal landing, fading into the original sidewall. The accepted bow cap and all hidden stud/skirt components are preserved. The exact exported meshes, closure probes, legacy regression and targeted end-face checks pass; physical print and fit remain untested.

## Forward hatch-hinge mounting sockets — 2026-11-01

The [hinge-socket revision](releases/2026-11-01_hatch-hinge-sockets/README.md) adds two 2 mm top-entry blind bores ahead of the hatch, at X=32.2 and Y=±5 mm. Solid 4.4 mm underside bosses support the 2.8 mm deep holes with 0.4 mm closed bottoms. The upper export and sampled geometry checks pass; all other component meshes are byte-identical. Physical hinge/print fit remains untested.

## Forward protective-skirt sockets — 2026-11-01

The [front-socket revision](releases/2026-11-01_front-skirt-sockets/README.md) adds four matching pairs of blind 1 mm sockets on the forward V faces and inner bow skirt. Existing 0.8 x 1.5 mm headless studs remain hidden in both components. There are now eighteen skirt studs. Both modified exported meshes and finite fit/closure checks pass; physical assembly is untested.

## Transverse glue joint — 2026-11-01

The [new split construction](releases/2026-11-01_transverse-glue-joint/README.md) divides lower hull and cover into bow/stern pairs, with a 4 mm inward land and four paired blind 2 mm guide bores. Side axes are near the upper edge and bottom axes divide the inner span evenly. The source defaults to 340 mm overall; each nominal half is 170 mm. New joint hardware remains fixed millimetres. The original three skirt sections are reused without a new cut. Both 170/340 mm sets and bed-oriented 340 mm exports pass their recorded finite geometry and topology checks; physical print, pin fit and glue strength remain untested.


## Wider glue joint and removed bow frame — 2026-11-01

The [updated milestone](releases/2026-11-01_wide-joint-clear-frame/README.md) uses a fixed 6 mm inward land and four 4 mm guide pins. Matching bores are 4.3 mm wide and 3.2 mm deep per half; axial reinforcement is 4 mm. Side bores are lowered by one fifth of the lower hull height (10 mm at overall length 340 mm). The nearest bow transverse frame is removed around its perimeter, preserving the longitudinal stringers. Both 170/340 mm configurations pass 840 material probes and recorded mesh checks. Four posed 340 mm parts remain at most 170 mm long. Skirt sections receive no new cut. Physical fit and glue strength remain untested.


## Through bolts and circular joint pads — 2026-11-01

The [bolt-joint milestone](releases/2026-11-01_through-bolt-bosses/README.md) replaces blind guide sockets with four matched through holes, diameter 4.3 mm for M4 bolts. The 6 mm strip expands locally to 12 mm with circular pads; axes are 7 mm inward, 1 mm beyond the expanded strip midpoint. Existing lowered side stations, frame removal, skirt geometry and 170/340 mm configurations are retained. Simplified bolt/nut previews replace printed joint guides in the combined scene. Mesh and sampled hardware-clearance checks are recorded; physical fit and strength remain untested.


## Two-millimetre joint thickness — 2026-11-01

The [thinner joint milestone](releases/2026-11-01_two-mm-bolt-joint/README.md) reduces axial strip and circular-lug thickness to 2 mm per half, 4 mm combined. Cover reinforcement uses the same depth. The 6 mm strip, 12 mm local pads, 7 mm axis inset and 4.3 mm M4 through bores remain. Both 170/340 mm configurations and posed 340 mm exports have recorded geometry checks. The selected thickness and physical strength remain untested.


## Two-and-a-half-millimetre joint thickness — 2026-11-01

The [thinner joint milestone](releases/2026-11-01_two-point-five-mm-bolt-joint/README.md) adjusts axial strip and circular-lug thickness to 2.5 mm per half, 5 mm combined. Cover reinforcement uses the same depth. The 6 mm strip, 12 mm local pads, 7 mm axis inset and 4.3 mm M4 through bores remain. Both 170/340 mm configurations and posed 340 mm exports have recorded geometry checks. The selected thickness and physical strength remain untested.


## Native lid joint and glue-alignment sockets — 2026-11-01

The [lid follow-up](releases/2026-11-01_lid-alignment-sockets/README.md) removes the inward upper reinforcement completely and puts two small paired blind sockets in the original roof-to-side corners. At overall length 340 mm they are 2 mm wide and 3.2 mm deep per half, with two 1.8 x 6 mm headless guide pins. These small lid features scale with the lid. Lower-hull meshes remain byte-identical to the 2.5 mm bolt-joint milestone. The exact native-lid volume difference matches only the intended socket pairs, and 800 material probes and mesh/print-pose checks pass. Physical fit remains untested.


## Roof-width lid mating tabs — 2026-11-01

The [corrected lid milestone](releases/2026-11-01_roof-width-lid-tabs/README.md) restores mating tabs under the original horizontal rail span, clipped to the exact native roof footprint. At whole length 340 mm each tab face is about 9.39 x 5 mm, with 2.5 mm axial depth per half. Two centred 2 mm blind sockets, 2.2 mm deep, match two 1.8 x 4 mm guide pins. There is no projection inward past the roof edge. Lower-hull meshes remain byte-identical to the verified 2.5 mm M4 joint. Geometry, topology and print-pose checks pass; physical fit remains untested.


## Full-height lid mating tabs — 2026-11-01

The [full-height lid milestone](releases/2026-11-01_full-height-lid-tabs/README.md) retains the accepted inward tab edge and extends each tab to the original lower lid plane. At overall length 340 mm the tab height is 10.23478 mm, axial thickness remains 2.5 mm per half and guide axes move to mid-height at Z=55.11739 mm. The 2 mm blind sockets and 1.8 x 4 mm guide pins remain. The outer wall is retained, the sloped-wall root is filled, and no tab extends below the lid. All 904 material probes, recorded topology/print-pose checks and sampled exterior comparisons pass. Physical fit remains untested.


## Four-millimetre lid guides and fastener reference — 2026-11-01

The [larger lid-guide milestone](releases/2026-11-01_four-mm-lid-guides/README.md) increases the sockets to 4 mm and smooth lid guides to 3.8 x 4 mm for the whole 340 mm boat. Two guides are needed; paired blind depths remain 2.2 mm per half. Full-height tabs and the lower hull remain unchanged. The body seam uses four M4 bolts with nuts through 4.3 mm holes, not smooth guide pins. [FASTENERS.md](FASTENERS.md) lists all current sizes and quantities for 340/170 mm whole models. Geometry and print-pose checks pass; physical fit remains untested.


## Lid through bolts

The current lid uses two through holes for bolts, 4.3 mm diameter at overall length 340 mm. See [FASTENERS.md](FASTENERS.md).
