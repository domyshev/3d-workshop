# Wide transverse joint and clear bow frame — 2026-11-01

This revision replaces the initial transverse-glue-joint construction while preserving its source and exports. The default whole boat is 340 mm, split into nominal 170 mm bow and stern pieces. Archived inspection configurations are 170 and 340 mm.

The inward glue land is 6 mm wide. Its axial reinforcement is 4 mm per half. Four headless guide pins are nominally 4 mm in diameter and 6 mm long. Matching blind bores are 4.3 mm in diameter and 3.2 mm deep in each half, with a short 4.6 mm mouth lead-in. This leaves 0.8 mm of material behind each bore and 0.4 mm total axial clearance for the pin. These new joint dimensions remain fixed in millimetres when the source length parameter changes; uniformly scaling an exported STL scales them too.

At overall length 340 mm, the lower hull is 50 mm high excluding the lid. Both side bore axes move down 10 mm, one fifth of that height, from Z=47.5 to Z=37.5 mm. Their common Y coordinates are ±48.45355 mm. The bottom axes remain evenly spaced at Y=±15.34478 mm, Z=8.35763 mm. All four bores are shared by the two lower halves. At 170 mm overall length the side axes are lowered by 5 mm. Previous high bores are absent.

The nearest original transverse frame on the bow half, at X=162.60870 mm for the 340 mm boat, is removed around the floor and both side walls. Exact original longitudinal stringer cross-sections are retained using archived guards. The new joint land supplies reinforcement at the cut. The original plating, other frames, cover and skirt attachment geometry remain as recorded by the finite comparison checks.

Lower hull and cover each have bow/stern components. The three original skirt sections are reused without another transverse cut. Existing skirt studs and cover locators scale uniformly with their original mating geometry. Only the new joint hardware has independent millimetre dimensions.

## Files and verification

- `inspection-view.scad`: pastel separated parts, all fasteners and complete assembly; choose 170 or 340 with `boat_length_mm`.
- `source.scad`: editable construction and dimensions.
- `joint-face-view.scad`: both lower mating faces.
- `print-<length>-<part>.scad`: print poses for the four large parts.
- `2026-11-01_sarepta_340mm_wide_print_*.stl`: four posed print meshes, at most 170 mm long.
- `2026-11-01_sarepta_joint_pin_4mm.stl`: print four copies.
- `*_wide_joint_*.stl`: assembly-coordinate parts for both verified sizes.
- `stringer-guards.json`, `section-profile.json`, `joint-axes.json`: archived construction measurements.

Exports use repository `export_stl` into the owner-authorized project STL directory `stl/2026/2026.11/2026.11.01/`. Unmodified exports remain in `raw/`. Cleanup logs record only surface-preserving zero-area refinement. No vertex displacement, hole filling or component removal is used to repair meshes. `manifest.json` hashes this milestone's files.

`verification.json` passes 840 material probes, closed single-component mesh checks, shared planar mating faces, measured 4.3 mm bores and 3.2 mm blind depths, removed frame webs, preserved longitudinal stringers, filled former bore positions and sampled unchanged exterior/bottom surfaces. At 340 mm, lower mating faces are 1362.09134 mm² and upper faces 304.17212 mm² on each side. `print-verification.json` verifies all four posed 340 mm parts fit within 170 mm length and have minimum Z within 0.00001 mm of the bed. Bottom-section probes outside the bore volumes find continuous solid attachment between land and plating.

The reported successful print baseline was lengthwise on the bed. Re-slice and check brim/support clearance for the actual printer. No new Bambu project or physical test is included. Pin fit, glue strength, watertightness and global minimum wall thickness are unverified.
