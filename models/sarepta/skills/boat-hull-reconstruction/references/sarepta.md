# Sarepta context and project decisions

Read [the current dimensional audit](../../../DIMENSION_RESEARCH.md),
[pending corrections](../../../PENDING_CORRECTIONS.md), and
[the release history](../../../releases/README.md). They are maintained as the
source of truth; do not duplicate their dimensions here.

The user values faithful bottom and side shapes, especially the three bow stems
and paired tunnels. The cabin and outboard motors are separate later parts.
170 mm is the target size; 80 mm is the current print trial. The sharp plan bow,
fair external side arcs and continuous rim were accepted. The 2026-10-23 revision corrects the excessive height and adds framing;
the source audit and status table distinguish applied values from estimates.

Current source uses X bow-to-stern, Y transverse and Z above the keel baseline.
Full-size coordinates and model-millimetre wall thickness coexist. The 4600 mm
scaling reference follows the early article and does not resolve all source
variants. A new dimension-based revision must declare which source it follows.

OpenSCAD on the recorded Mac works through the x86_64 binary; the ARM invocation
previously failed CPU-feature checks. Re-discover the executable on another host.
Design previews should open in OpenSCAD. Bambu exports are made only on request.

The 2026-11-01 transverse glue-joint review now defaults to 340 mm overall,
with nominal 170 mm bow/stern halves. The 170 mm source and print evidence remain
archived. New joint land/bores/pins are fixed model millimetres while the original
boat and its older matching hardware scale together. Do not scale a finished
joint STL and claim its fixed hardware dimensions are preserved.


## Wider glue joint and removed bow frame — 2026-11-01

The [updated milestone](../../../releases/2026-11-01_wide-joint-clear-frame/README.md) uses a fixed 6 mm inward land and four 4 mm guide pins. Matching bores are 4.3 mm wide and 3.2 mm deep per half; axial reinforcement is 4 mm. Side bores are lowered by one fifth of the lower hull height (10 mm at overall length 340 mm). The nearest bow transverse frame is removed around its perimeter, preserving the longitudinal stringers. Both 170/340 mm configurations pass 840 material probes and recorded mesh checks. Four posed 340 mm parts remain at most 170 mm long. Skirt sections receive no new cut. Physical fit and glue strength remain untested.


## Through bolts and circular joint pads — 2026-11-01

The [bolt-joint milestone](../../../releases/2026-11-01_through-bolt-bosses/README.md) replaces blind guide sockets with four matched through holes, diameter 4.3 mm for M4 bolts. The 6 mm strip expands locally to 12 mm with circular pads; axes are 7 mm inward, 1 mm beyond the expanded strip midpoint. Existing lowered side stations, frame removal, skirt geometry and 170/340 mm configurations are retained. Simplified bolt/nut previews replace printed joint guides in the combined scene. Mesh and sampled hardware-clearance checks are recorded; physical fit and strength remain untested.


## Two-millimetre joint thickness — 2026-11-01

The [thinner joint milestone](../../../releases/2026-11-01_two-mm-bolt-joint/README.md) reduces axial strip and circular-lug thickness to 2 mm per half, 4 mm combined. Cover reinforcement uses the same depth. The 6 mm strip, 12 mm local pads, 7 mm axis inset and 4.3 mm M4 through bores remain. Both 170/340 mm configurations and posed 340 mm exports have recorded geometry checks. The selected thickness and physical strength remain untested.


## Two-and-a-half-millimetre joint thickness — 2026-11-01

The [thinner joint milestone](../../../releases/2026-11-01_two-point-five-mm-bolt-joint/README.md) adjusts axial strip and circular-lug thickness to 2.5 mm per half, 5 mm combined. Cover reinforcement uses the same depth. The 6 mm strip, 12 mm local pads, 7 mm axis inset and 4.3 mm M4 through bores remain. Both 170/340 mm configurations and posed 340 mm exports have recorded geometry checks. The selected thickness and physical strength remain untested.


## Native lid joint and glue-alignment sockets — 2026-11-01

The [lid follow-up](../../../releases/2026-11-01_lid-alignment-sockets/README.md) removes the inward upper reinforcement completely and puts two small paired blind sockets in the original roof-to-side corners. At overall length 340 mm they are 2 mm wide and 3.2 mm deep per half, with two 1.8 x 6 mm headless guide pins. These small lid features scale with the lid. Lower-hull meshes remain byte-identical to the 2.5 mm bolt-joint milestone. The exact native-lid volume difference matches only the intended socket pairs, and 800 material probes and mesh/print-pose checks pass. Physical fit remains untested.


## Roof-width lid mating tabs — 2026-11-01

The [corrected lid milestone](../../../releases/2026-11-01_roof-width-lid-tabs/README.md) restores mating tabs under the original horizontal rail span, clipped to the exact native roof footprint. At whole length 340 mm each tab face is about 9.39 x 5 mm, with 2.5 mm axial depth per half. Two centred 2 mm blind sockets, 2.2 mm deep, match two 1.8 x 4 mm guide pins. There is no projection inward past the roof edge. Lower-hull meshes remain byte-identical to the verified 2.5 mm M4 joint. Geometry, topology and print-pose checks pass; physical fit remains untested.


## Full-height lid mating tabs — 2026-11-01

The [full-height lid milestone](../../../releases/2026-11-01_full-height-lid-tabs/README.md) retains the accepted inward tab edge and extends each tab to the original lower lid plane. At overall length 340 mm the tab height is 10.23478 mm, axial thickness remains 2.5 mm per half and guide axes move to mid-height at Z=55.11739 mm. The 2 mm blind sockets and 1.8 x 4 mm guide pins remain. The outer wall is retained, the sloped-wall root is filled, and no tab extends below the lid. All 904 material probes, recorded topology/print-pose checks and sampled exterior comparisons pass. Physical fit remains untested.


## Four-millimetre lid guides and fastener reference — 2026-11-01

The [larger lid-guide milestone](../../../releases/2026-11-01_four-mm-lid-guides/README.md) increases the sockets to 4 mm and smooth lid guides to 3.8 x 4 mm for the whole 340 mm boat. Two guides are needed; paired blind depths remain 2.2 mm per half. Full-height tabs and the lower hull remain unchanged. The body seam uses four M4 bolts with nuts through 4.3 mm holes, not smooth guide pins. [FASTENERS.md](../../../FASTENERS.md) lists all current sizes and quantities for 340/170 mm whole models. Geometry and print-pose checks pass; physical fit remains untested.
