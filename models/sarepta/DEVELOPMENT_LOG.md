# Sarepta hull — first reconstruction

170 mm hull study with an open cockpit, hollow foredeck, side decks, and an
original-style recessed outboard transom. The cabin and motors are not included.

## Geometry and dimensions

- Model length: 170 mm; maximum beam: 59.1304 mm; height: 29.6391 mm.
- Reference length: 4600 mm, following the 1974 article; scale approximately 1:27.06.
- Nominal transverse shell offset: 1.2 mm. This is not a certified minimum normal
  wall thickness everywhere on the three-dimensional surface.
- Foredeck and side deck skin: 1.2 mm vertical thickness.
- Central transom: 2 mm model thickness; top approximately 14.78 mm above the
  baseline, representing the reported 400 mm original transom height.
- Motor-well floor: 8 mm above the baseline. Its depth and partition geometry are
  provisional model dimensions, not measurements from a factory drawing.
- The extreme stem is solid. The hollow foredeck opens into the cockpit.
- The central cockpit opening is approximately 94.35 by 46.58 mm.

Change the parameters at the top of `sarepta_hull.scad`. The `hull` selector is the
complete part; `outer`, `inner`, and `sections` are inspection views.

## Sources and fidelity

1. [1974 introduction, Katery i Yakhty No. 48](https://www.barque.ru/projects/1974/powerboat_trimaran_sarepta).
2. [Published body plan](https://www.barque.ru/image/12239/3), downloaded as
   `reference/sarepta-lines-1974.jpg`.
3. [General arrangement illustration](https://www.barque.ru/image/12239/8),
   downloaded as `reference/sarepta-arrangement-1974.jpg`.
4. [Handbook-derived specification and illustrations](https://motorka.org/m_lodki/579-sarepta.html),
   including the 400 mm transom height. This later source lists 4650 mm overall
   length rather than the 4600 mm in the 1974 article.
5. The user's bow-quarter photograph supplied in the conversation.

Reference images retain their original authorship; they are reference material,
not repository-authored drawings. The handbook GIFs are lower-resolution copies
kept for comparison.

The body plan supplies transverse shapes only. Five forward section shapes were
manually approximated from the scan. The table exposes the keel, bottom samples,
tunnel crowns, chines, and sheer coordinates. The aft bottom approaches the
reported 8.5-degree deadrise and 1300 mm chine beam.

**This is an interpretive first reconstruction, not an exact factory replica.**
The positions of the sections along the length are assumed at 460 mm intervals;
the stem closure, longitudinal fairing, aft sections, sheer and deck camber are
reconstructed. The vertical transom is a simplification; its original rake has
not been established. Motor-well dimensions and cockpit boundaries are also
provisional. These assumptions must be revisited if a longitudinal lines plan,
dimensioned original drawing, or measurements of a surviving boat become available.

The distinctive paired bow tunnels and their transition into a single shallow-V
aft bottom are modeled explicitly. Monotone cubic interpolation fairs the section
coordinates longitudinally; the surfaces between transverse sample points remain
ruled triangular panels. The model omits the original 30 mm chine spray flange,
pressed side stiffening grooves, deck hatches, fittings, and cabin attachment
features. The external contours have not been independently measured against an
original hull.

## Verification — October 19, 2026

- OpenSCAD 2026.06.12 full boolean evaluation: manifold, `NoError`, genus 0.
- Inspection mesh: 2891 vertices and 5778 triangles, one connected component.
- Every mesh edge has two oppositely directed incidences; positive signed volume;
  no zero-area triangles. Material volume approximately 41194.7 cubic mm.
- Bounding dimensions checked against the 170 mm design length.
- Rendered and visually inspected `previews/hull-above.png` and
  `previews/hull-bottom.png`.
- No physical print, flotation, leak, loading, slicing, support, or motor-fit test
  has been performed. Print orientation and supports remain to be prepared.

On this Mac the bundled OpenSCAD ARM build reports a CPU-feature error in the
agent environment; the x86_64 binary works through `arch -x86_64`. Rendering PNGs
also requires access to the macOS graphics system.

STL export must use the repository's `export_stl` tool and a user-supplied
`STL_BASE_PATH`, resolved to `2026/2026.10/2026.10.19/` for this iteration.
No STL was exported while that destination was unavailable. The temporary 3MF
used for mesh checks is an inspection artifact, not a configured printer project.


## 80 mm print trial — October 20, 2026

`sarepta_hull_80mm.scad` selects an 80 mm
outer length. The external proportions scale uniformly; the nominal shell and
vertical deck thickness remain 1.2 mm, and the transom remains 2 mm thick. The
motor-well floor height scales with length. The original 170 mm defaults remain.

- Checked dimensions: 80 by 27.8261 by 13.9478 mm.
- OpenSCAD full evaluation: manifold, NoError, genus 0; 2892 vertices, 5780 faces.
- Exported STL using `export_stl` to the user-authorized project-local base
  `stl_exports`, under `2026/2026.10/2026.10.20/`.
- Prepared and sliced `2026-10-20_sarepta_80mm_A1mini.3mf` using installed Bambu
  Studio 02.07.01.62 profiles: A1 mini, 0.4 mm nozzle, Generic PLA, 0.16 mm layers,
  three wall loops, 15 percent infill, organic tree supports from the build plate,
  0.16 mm support contact gap, 4 mm outer brim, and Textured PEI at 55 C.
- The model is upright with its keel on the plate. Automatic supports are intended
  to carry the raised bow and outboard bottom surfaces.
- Slicing completed with the model inside the build area. Estimate: 46 min 37 sec,
  8.43 g including supports and brim. These are slicer estimates, not print results.
- The slicer retains a Generic PLA bed-temperature advisory: the profile's 45 C
  vitrification value is below the selected 55 C bed temperature. The actual
  filament and plate selection should match the user's material before printing.
- Verified the 3MF archive, stored machine/process settings, and 80 mm mesh length;
  inspected the generated plate thumbnail. Physical printing remains untested.


## Bow correction — October 21, 2026

The initial bow incorrectly collapsed all longitudinal contours into a tiny common
end section. That flattened the centre stem and both outboard stems and erased
the upper tunnel shapes. User photographs identified the mismatch.

The outer loft now has separate bottom and deck grids sharing the entire bow
boundary. The three stem edges and two tunnel creases continue to this boundary;
there is no separate bow-closing face. Each contour has its own longitudinal
endpoint. The assumed fore/aft endpoint offsets are 0 mm for the centre stem,
100 mm for each outboard chine, 160 mm for each tunnel and 180 mm at the sheer
(full-size reconstruction coordinates). Intermediate bottom samples use 40, 85,
and 125 mm offsets. These offsets are interpretations of the photographs, not
factory dimensions. The deck uses a transverse parabolic camber and joins the
bottom along matching vertices at the bow. The aft bottom and transom are retained.

Verification of the corrected final meshes:

- 170 mm: 3533 vertices, 7062 triangles; dimensions 170 x 59.1304 x 29.6391 mm.
- 80 mm: 3542 vertices, 7080 triangles; dimensions 80 x 27.8261 x 13.9478 mm.
- Both OpenSCAD evaluations: manifold, NoError, genus 0. Mesh edges have opposite
  paired incidences, triangles have nonzero area, and signed volume is positive.
- A non-adjacent triangle segment-crossing check found no crossings in either
  mesh. This is a numerical check, not a proof of exact geometric fidelity.
- Inspected updated bottom, upper and bow-quarter renders. `bow-closeup.png`
  enlarges the bow area for checking all three edges and both tunnels.
- Re-exported the 80 mm STL with `export_stl` and re-sliced the Bambu project in
  `stl_exports/2026/2026.10/2026.10.21/`. The October 20 exports remain available.
- Bambu slice estimate: 45 min 9 sec and 8.30 g, with the same A1 mini / 0.4 mm /
  PLA / 0.16 mm process. The mesh is inside the bed area and supports are included.
- The slice contains 87 layers. The prior Generic PLA bed-temperature advisory
  remains; the CLI also logs `ZFiller: encounter idx from clip: 5` during clipping,
  then completes successfully. No additional warning appears in slice metadata.
- Physical printing and comparison with an actual Sarepta hull remain untested.


## Continuous stem curves — October 21, 2026, second revision

The previous correction retained the bow endpoints but introduced a derivative
jump where each line's X offset stopped at the first forward section. The user
identified the resulting bend in all three stems. This revision supersedes the
`sharp_bow` exports earlier on October 21.

The bow now uses seven independent physical-X Hermite curves on each half. Their
upper endpoints are found by intersecting a translated reference stem profile
with the 750 mm deck height. The reference centre profile runs from (X=0,Z=750)
to (X=460,Z=220), with an initial dz/dx of -1.6. Each upper endpoint uses the
reference profile's local derivative; each aft endpoint uses the next hull
section's derivative. The former hand-selected X endpoint offsets are removed.
The shared deck/bottom boundary and sharp centre and outboard creases remain.
There are 48 samples in the bow segment, versus 12 in each aft segment.

This is still a photographic reconstruction; slope choices and the reference
profile have not been measured on a factory hull.

Verification:

- `verify_bow.scad` checks all seven distinct seam tangents and all three stem
  creases near the deck. Finite-difference seam angle error is below 0.001 degrees
  (observed maximum 0.000101 degrees). Near-deck changes of surface normal across
  each stem remain approximately 62.7 degrees centrally and 95.8 degrees outboard;
  the check rejects flattened creases below 20 degrees. These are normal-change
  angles, not the included V angles or deadrise.
- 170 mm mesh: 4397 vertices and 8790 triangles. 80 mm mesh: 4406 vertices and
  8808 triangles. Both evaluate as manifold, NoError, genus 0, with paired opposite
  edges, positive signed volume, and no zero-area triangles. The numerical
  non-adjacent triangle segment-crossing check found no crossings.
- Outer dimensions remain 170 x 59.1304 x 29.6391 mm and
  80 x 27.8261 x 13.9478 mm. The transom and aft body remain unchanged.
- Updated and inspected lower, upper, and near-frontal renders.
  `previews/bow-continuous-closeup.png` and `previews/bow-continuous-front.png`
  specifically show the three bows and tunnel continuation.
- Exported `2026-10-21_sarepta_hull_80mm_continuous_bow.stl` through `export_stl` and
  prepared `2026-10-21_sarepta_80mm_continuous_bow_A1mini.3mf` in the same dated
  project-local export directory. Earlier files are retained for comparison.
- Slicing completed: 87 layers, 43 min 58 sec, 8.18 g estimated, with supports,
  model inside the build area, and the same PLA / A1 mini / 0.4 mm / 0.16 mm setup.
  The previously documented bed-temperature advisory and nonfatal ZFiller log
  diagnostic remain. Physical printing has not been tested.


## Fair guide surfaces and continuous flat deck — October 22, 2026

The user identified remaining dents and a conceptual deck error: the three
underlying bows should be covered by a continuous planar sheet, rather than a
scalloped deck edge. This revision supersedes the October 21 bow versions.

Reference research and downloads:

- Saved all 92 full-resolution images from the user-provided Karopka gallery in
  `reference/karopka/`, with URL manifest, attribution and four contact sheets.
  Images 12, 33, 34 and 87 were particularly useful for plan, bottom and actual
  boat comparisons. The downloaded set occupies approximately 59 MiB.
- Reviewed the public `marine-engineer-naval-architect` skill at
  https://github.com/wonsukchoi/domain-experts/blob/main/roles/marine-engineer-naval-architect/SKILL.md .
  Its emphasis is stability, powering and regulatory calculations; it was not
  installed or treated as a hull-surfacing workflow.
- Applied relevant curve-fairing guidance from McNeel's official boat tutorial:
  https://docs.mcneel.com/rhino/6/usersguide/en-us/html/ch-16_boathull.htm .
  The useful principles are a small set of guide curves and curvature checks
  before constructing the surfaces.

Geometry:

- Replaced the short patched bow extensions with three independent convex
  quintic Bezier guides: centre stem, tunnel crown and outboard stem. The side
  stem is mirrored. Their final three vertical control ordinates coincide, so
  they meet their aft flat continuations with zero slope and curvature.
- Central panels are generated between the centre and tunnel guides, with a
  small smoothly vanishing transverse curvature term; the former independently
  fitted intermediate contours are removed. Outboard panels follow the same
  guide framework. Increased transverse sampling reduces visible triangulation.
- All deck heights are fixed at 750 mm full size. Added a 1.2 mm model-thickness
  foredeck sheet with a continuous shallow-V, rounded-shoulder plan outline.
  It closes the gaps above the three underlying bows. The sheet is deliberately
  overlapped with the hull; its aft side edges avoid coincident Boolean edges.
- The cockpit remains open and the recessed outboard transom is retained. Shell
  and deck thickness parameters remain 1.2 mm; a minimum wall thickness over the
  entire altered three-dimensional shell has not been certified. The inner cavity
  still follows the prior station-table reconstruction.
- External guide fits, plan outline and loft parameters remain reconstructions,
  not measurements of a factory hull. The model-kit photographs are secondary
  references and are not assumed to be dimensionally exact.

Verification:

- `verify_bow.scad` checks 1001 samples per guide for monotone X/Z and no reversal
  of signed profile curvature, verifies zero slope/curvature at aft joins, and
  checks that the external surface does not protrude through the deck plane.
- OpenSCAD full evaluations: manifold, NoError, genus 0 at 170 and 80 mm.
- 170 mm mesh: 14172 vertices, 28340 triangles, 170 x 59.1304 x 27.7174 mm.
- 80 mm mesh: 13863 vertices, 27722 triangles, 80 x 27.8261 x 13.0435 mm.
- Both final inspection meshes have paired opposite edge incidences, positive
  volume, Euler characteristic 2, and no zero-area triangles. Volumes are about
  40359.95 and 6235.23 cubic mm respectively. The flat-deck revision intentionally
  reduces height from the earlier crowned-deck versions.
- Inspected lower, upper and orthographic plan renders. The review board is
  `previews/2026-10-22_fair-bow-and-flat-deck.png`.
- Exported through `export_stl` and sliced the new `fair_flat_deck` 80 mm Bambu
  project under `stl_exports/2026/2026.10/2026.10.22/`. Estimate: 45 min 23 sec,
  8.71 g, 81 layers; supports included and geometry within the bed area.
- The prior PLA bed-temperature advisory and ZFiller CLI diagnostic remain;
  slicing completes successfully. Physical printing and dimensional comparison
  with a surviving Sarepta hull remain untested.


## 2026-10-22 photo-matched bow plan revision

- Preserved the accepted flat-deck source in `history/2026-10-22_fair_flat_deck.scad`.
- Estimated the apparent included bow angle from the supplied near-top photograph
  at approximately 132 degrees. This is a perspective-dependent reference, not
  a factory measurement. Changed the model from 154.01 to 132.50 degrees while
  retaining overall length and the centre tip position.
- Moved the upper side stems and tunnel guides aft using affine longitudinal
  transformations of their Bezier controls. All three profiles retain convex
  curvature and their smooth aft joins. The foredeck remains flat and continuous.
- Rebuilt the cavity from the same exterior guide grid with transverse insets.
  This replaces the earlier station-table cavity, which intersected the revised
  bow. A global minimum wall thickness has not been certified.
- Guide curvature and aft-join checks pass; the plan-angle regression reports
  132.501 degrees. At both 170 and 80 mm, inspection meshes contain one closed
  component, paired opposite edge incidences, Euler characteristic 2, positive
  volume and no zero-area triangles. OpenSCAD reports genus 0.
- Final 80 mm mesh: 20860 vertices, 41716 triangles, dimensions
  80 x 27.8261 x 13.0435 mm. The 170 mm mesh has 21170 vertices and
  42336 triangles. Updated plan, upper and lower preview images.
- Exported `2026-10-22_sarepta_hull_80mm_photo_bow.stl` through the repository
  exporter into `stl_exports/2026/2026.10/2026.10.22/`. Opened the adjacent
  `photo_bow_preview.scad` wrapper in OpenSCAD to display the exact exported STL
  initially from above. Per the current design workflow, no Bambu export was made
  for this revision. Physical printing remains untested.


## 2026-10-22 hatch and continuous protective rim

- Preserved the preceding source as `history/2026-10-22_photo_bow.scad`.
- Added a rounded rectangular foredeck opening into the bow locker. Its estimated
  full-size dimensions are 500 x 450 mm with 55 mm corner radii, centred 950 mm
  aft of the bow. Placement follows the arrangement drawing; these dimensions
  are reconstruction choices, not measured factory dimensions. At 80 mm model
  length the opening is approximately 8.70 x 7.83 mm. No hatch lid is included.
- Replaced the S-shaped bow sheer in plan with a convex cubic shoulder. The side
  stem's transverse progression is now concave and monotone, eliminating its
  former inflection. Retained convex vertical stem profiles and smooth aft joins.
- Extended the top plate along both sides to the stern. Its shoulder edge is the
  master curve; the hull sheer follows a 50 mm full-size normal inward offset.
  The upper centre and side stems are set back by the same perpendicular amount
  from the straight bow edges. The plate bridges the recessed tunnel tops as
  before. It ends flush at the stern, with no aft overhang.
- The nominal 50 mm rim scales to 0.870 mm at 80 mm hull length and 1.848 mm at
  170 mm. Overall length and deck beam remain unchanged. Wall/deck thickness
  remains 1.2 mm; minimum shell thickness has not been globally certified.
- Regression checks cover convex vertical profiles, smooth aft joins, convex
  plan shoulders, the normal shoulder offset, stem-tip setbacks, and the
  132.501-degree included bow angle. All checks pass.
- Full evaluations at 80 and 170 mm report NoError and genus 1, as expected
  because the hatch and cockpit connect to the same cavity. Both meshes have
  one connected component, Euler characteristic 0, paired opposite edges,
  positive volume, and no zero-area triangles.
- 80 mm: 30949 vertices, 61898 triangles, 80 x 27.8261 x 13.0435 mm,
  volume approximately 6163.01 cubic mm.
- 170 mm: 31704 vertices, 63408 triangles, 170 x 59.1304 x 27.7174 mm,
  volume approximately 40544.32 cubic mm.
- Updated plan, upper and lower preview renders. Exported the 80 mm
  `hatch_fair_rim` STL through `export_stl` into the dated export directory and
  opened its exact-mesh wrapper in OpenSCAD. No Bambu export was made.


## 2026-10-22 reverse-flared upper hull and embossed foredeck

- Preserved the accepted lower-hull revision in
  `history/2026-10-22_hatch_fair_rim.scad`. Lower bow guides, convex plan shoulders
  and the protective seam outline remain the reference geometry.
- Added an upper hull above the seam at full-size Z=750 mm. Its height increases
  linearly from 80 mm at the bow to 200 mm at the stern. Its upper edge is inset
  a further 70 to 100 mm, giving the opposite side inclination visible in the
  supplied stern section. These heights and setbacks are approximate fits, not
  certified factory measurements. The deck rises gently towards the stern.
- Built the upper envelope from native planar sections and their convex hull,
  with a matching inset cavity and 1.2 mm vertical roof thickness. The convex
  envelope slightly simplifies the small aft curvature of the sampled outline.
  The central transom and outboard well remain open in their original layout.
  Continued the well bulkhead up to the inclined deck and closed the aft quarter
  cavities within the transom thickness. A small overlap avoids coincident faces.
- Opened the redundant flat sheet only within the protected inner cavity,
  connecting the lower and upper interior without cutting the accepted lower
  outside surface. The hatch now opens through the raised upper foredeck.
- Added a 12.5 mm full-size raised pad around the hatch, with a forward-pointing
  outline and rounded corners. Added two rounded longitudinal ribs, 15 mm high
  and approximately 38 mm wide, following the sides of the foredeck. At 80 mm
  hull length these relief heights are 0.217 and 0.261 mm; at 170 mm they are
  0.462 and 0.554 mm. They deliberately retain the shallow stamping proportions
  described by the user. Physical reproduction depends on print layer height.
- Original bow-profile and plan-curvature regressions pass, together with upper
  height, inward-setback and shallow-relief checks.
- Final inspection meshes at 80 and 170 mm: NoError, genus 1, one connected
  component, Euler characteristic 0, paired opposite edge incidences, positive
  volume and no zero-area triangles. Minimum shell thickness has not been
  globally certified.
- 80 mm: 26028 vertices, 52056 triangles, 80 x 27.8261 x 16.5217 mm,
  volume approximately 7025.43 cubic mm.
- 170 mm: 26349 vertices, 52698 triangles, 170 x 59.1304 x 35.1087 mm,
  volume approximately 44466.82 cubic mm.
- Updated upper, lower, plan and stern preview renders; exported the 80 mm
  `upper_belt_relief` STL through the repository exporter and opened its exact
  mesh in OpenSCAD. No Bambu export was made. Physical printing remains untested.

## 2026-10-23 — Evidence archived, dimensions and framing revised

Archive checkpoint `cc04d8c` was pushed first. The subsequent revision maps the
reverse belt inside the 750 mm side height, uses a 375 mm centre engine seat,
and sets a 2600 x 1280 cockpit envelope. Added a separate bow locker, raised
motor-well floor, estimated central transom notch, transverse/longitudinal
framing, side corrugations and 30 mm chine spray flanges. See
[decisions and limitations](TRANSOM_AND_FRAMING.md).

Both actual binary STL sizes pass edge pairing, vertex links, nonzero faces,
positive volume and single-component checks; Euler characteristic 2. Bow
curvature, aft joins, accepted plan angle and normal rim offsets pass regression
checks. A continuous flange sweep and small internal Boolean overlaps avoid
point pinches and low-precision STL slivers. No physical print yet.

New images from the user and the first-hand Progress-4 kit review are archived.
The review identifies PRG-4-43 as 17 physical photopolymer-printed parts, not
STL files. Sarepta has a separate 19-part physical kit review.

## 2026-10-23 — Straight side corrugations

User photos showed that the previous side ridges curved upward and extended
too far into the bow. Replaced fixed chine-to-seam fractions with horizontal
side-surface intersections at estimated Z=280/425, X=1600..4600. Both strips
have flat forward ends and terminate flush at the transom. Other geometry is
unchanged. Archived both binary STL sizes and three supplied images.
Edge/vertex checks and new ridge-level/placement assertions pass; physical
printing remains untested. See the straight-side-ridges release.

## 2026-10-23 — Forward leg space and detailed interior audit

Reviewed the factory passport/arrangement, primary article, handbook, actual
helm and open-locker owner photographs, and a first-hand 1976-hull restoration
account. Findings, attribution and unresolved details are in `INTERIOR_RESEARCH.md`.

Added a reconstructed stepped watertight boundary with a nominal 200-high
upper instrument face and 300 forward reach below it; kept the locker separate
and accessible through its hatch. Widened upper side landings inward by 80
per side without editing the frame definition; added backed recesses and two
estimated well scuppers. Deck beads are now straight, 560 long and 10 high.
Grey model and rendered mesh views replace yellow presentation.

Both binary STL sizes pass current topology checks and eight independent
material samples for spaces/partitions/ledges. Guide and dimensional regressions
pass at both sizes. A true centre-section image is made from the actual STL.
No physical print or full minimum-wall/self-intersection check. Fixed print
thickness causes different small internal openings at the two sizes, recorded
in the new release instead of claiming identical scaled topology.
