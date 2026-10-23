```text
*****  ****        ‖   ‖  *****  ****   *****  ‖      *****  ‖   ‖  *****
    ‖  ‖   ‖       ‖* *‖  ‖   ‖  ‖   ‖  ‖      ‖        ‖    ‖*  ‖  ‖
*****  ‖   ‖       ‖ * ‖  ‖   ‖  ‖   ‖  ****   ‖        ‖    ‖ * ‖  ‖ ***
    ‖  ‖   ‖       ‖   ‖  ‖   ‖  ‖   ‖  ‖      ‖        ‖    ‖  *‖  ‖   ‖
*****  ****        ‖   ‖  *****  ****   *****  *****  *****  ‖   ‖  *****
```

# Personal Engineering Workshop

This project is my working space for OpenSCAD models, experiments with printable mechanisms, and practical experience with 3D printing.

It preserves source files, intermediate designs, tested solutions, and a history of internal achievements. An achievement can be a new model, a working fit, an established workflow, or a useful finding from a physical test.

Individual models are published through separate projects. This repository preserves their development history and the workshop's shared tools.

## Development History and Achievements

This chronology was reconstructed from Git history, source files, notes, and surviving artifacts. Dates identify recorded milestones and may differ from when the work actually began. Geometry checks and print preparation are distinguished from printing and physical testing.

### March 9, 2026 — Funny ATV begins

Created the first side of a vehicle model. This is the beginning of the project's recorded history.

### March 10–21, 2026 — Gears and axle placement

Added gears, additional large gears, gear phase control, and paired mirrored gears. Developed calculations for axle positions, distances, and angles.

Hole and component placement gradually moved to calculated coordinates.

**Outcome:** a foundation for a parametric gear mechanism. Physical testing of the mechanism is not documented.

### March 22–25, 2026 — Model organization and fit preparation

Separated models and library components. Added a grid of LEGO pin holes to the side frame and refined hole dimensions for axles and gears.

Created a fit sample and prepared dimensions for printing.

**Outcome:** reusable components and a dedicated fit-testing sample. Physical results for the sample are not documented.

### March 29, 2026 — Connector frame

Added a connector frame to join Funny ATV components.

**Outcome:** progress from an individual side frame toward a three-dimensional assembly.

### April 12, 2026 — Bathroom holder and continued frame development

Created a circular bathroom holder with mounting cutouts. Separately continued work on a cutout in the motor holder.

**Evidence:** source files and change history. Printing and physical testing are not documented.

### April 19, 2026 — Holder mounting reinforcement

Added a screw hole and reinforced the area around a perpendicular peg.

**Outcome:** refined mounting geometry and reinforcement of a loaded area.

### July 2, 2026 — Threaded connections and export tools

Added a lid, internal ribs, a threaded hole, and an M10 screw to the phone holder model.

Explored different thread profiles, then adopted Dan Kirshner's `threads.scad` library. Added a thread-pair sample, part toggles, simplified preview geometry, and an STL export tool.

Started tuning clearances for printed threaded connections.

**Outcome:** a shared process for modeling and exporting printable threads.

### July 3, 2026 — Tested M10 threads and a hollow phone base

Refined thread fits and recorded the parameters of a physically tested printed pair:

- Pitch: 1.5 mm.
- Internal thread diameter: 10.4 mm.
- External thread diameter: 9.8 mm.

Created a hollow base based on iPhone 15 Pro Max dimensions and added two upper brackets.

**Evidence:** notes documenting physically tested threads, source files, and historical exports.

### July 5, 2026 — First phone stand print and test

Recorded printing a stand with a hollow base, brackets, and bolts.

Testing revealed base leaks, failure of one bolt and the brackets, and insufficient base weight even when filled with water.

**Outcome:** practical findings for the next iteration. The recorded explanations for leaks and failures are hypotheses, rather than established causes.

### July 5, 2026 — Larger ballast base

Developed a 140 × 80 × 50 mm base with a separate bracket, thicker lid, internal ribs and supports, and M20 threaded filling ports.

Calculated usable volume increased from approximately 87 to 311 cm³. Refined the internal supports for printing while preserving fill volume.

Organized STL artifacts by date.

**Evidence:** source files, calculations, and historical exports. Physical testing of this version is not documented.

### July 11, 2026 — Modular link and triangular MagSafe frame

Developed and repaired a modular-link coupling. Prepared a functional export and geometry checks for the connection.

Built two parallel triangular frames from repeated links, with transverse axes and a spacer.

Also preserved a print project for the earlier stand and PETG printing notes.

**Outcome:** a modular connection applied to a complete stand design. Physical assembly is not documented.

### July 11–12, 2026 — Ballast cassette and MagSafe mount

Developed an internal cassette with approximately 136.8 cm³ of usable volume, reinforced sleeves, a sliding lid, and a locking pin.

Refined wall thickness around the lid. Added a MagSafe bridge, keys connecting it to the frames, and fit gauges for different puck variants.

**Evidence:** source files and historical checks of volume, clearances, contacts, and geometry validity.

### July 12, 2026 — Triangular stand print set

Prepared individual printable parts, assembly views, and exploded views. Documented the bill of materials, assembly order, print settings, and ballast requirements.

The history records successful model and exported-mesh checks.

**Outcome:** a design prepared as a complete print set. Physical testing of the full stand is not documented.

### July 12, 2026 — Mechanical block exploration

Created an interactive concept board for a household mechanical construction system, with four main directions and ten lock options.

Developed ten connection types: dovetail, bayonet, snap hook, wedge key, T-track, split pins, printed thread, detent slider, cam clamp, and rack pawl.

Exported 22 prototype parts.

**Evidence:** the concept board, source files, and historical geometry checks. Physical comparison of the prototypes is not documented.

### July 12, 2026 — Printed fasteners and indexed links

Developed printed bolts, hex nuts, and wing nuts for the modular connection.

Created a link with 7.5° angular indexing and an enlarged version for M8 hardware. Developed separate printed bolt and nut parts for the M8 version.

**Evidence:** source files, historical STLs, and recorded checks of supported angles and mesh validity. Physical testing is not documented.

### August 7, 2026 — Artifact cleanup

Removed previously stored STLs, print projects, and images from the current tree. These materials remain available in Git history.

**Historical context:** an artifact's absence from the current directory does not mean it was never created.

### August 10, 2026 — Super Cubes begins

Developed a 20 mm chamfered cube with six M8 × 1.25 threaded sockets and a separate threaded cylinder.

Added individual part selection, simplified preview geometry, and export to an external directory.

**Evidence:** source files and a recorded successful part export.

### August 11, 2026 — More Super Cubes parts and Bambu Studio projects

Added short and long sleeves, plus threaded cylinders of different lengths.

Developed a workflow for assembling several parts into one Bambu Studio project and copying printer and filament settings from a reference project.

**Evidence:** historical checks of exported parts and the generated 3MF project structure.

### August 13–15, 2026 — Super Cubes connector variants

Surviving local exports show development of double-ended sockets, short axes, plugs, and print sets.

**Evidence:** current source files, an image, and local STL and 3MF files. File dates identify exports; the extent of physical testing needs clarification.

### August 19, 2026 — MagSafe ring holder

Started a new holder design with a split clamp ring. The history notes that the ring was printed.

Subsequently added a vertical support and platform. Moved earlier holder designs into a historical folder.

**Evidence:** development history and local print projects.

### August 20, 2026 — Holder 0.1 assembly

Added a retaining border to the ring and a hex-key recess to the threaded connector. Recorded the version 0.1 holder assembly with its ring, support, base, and M12 fasteners.

**Outcome:** individual components combined into a new modular design.

### August 21, 2026 — Preserving tested 0.1 fits

Development notes record that version 0.1 thread fits were physically tested by printing.

Defined requirements for a future thread-library replacement: preserve parameters, test the main mating pairs, and check compatibility with already printed parts.

**Outcome:** tested geometry preserved as a foundation for further development.

### August 25, 2026 — Full-height and compact holder configurations

Local exports survive for both full-height and compact configurations, including bases, supports, sleeves, connectors, and fasteners.

**Evidence:** local artifacts. Export dates do not establish exact development or physical testing dates.

### September 30, 2026 — Current MagSafe holder source preserved

Added the complete current source to the repository, including full-height and compact configurations, assembly modes, individual parts, M12 fasteners, and indexed joints.

The history records a successful final render of the overall scene.

**Outcome:** the current design preserved in the workshop with its dependencies.

### September 30, 2026 — Separate toothed insert experiment

Created an experiment with cylindrical recesses in the clamp ring and a toothed insert modeled as an independent part.

Successful renders of the overall scene and individual parts are recorded for the committed version. Subsequent local changes enlarge the insert and position inserts in the assembly.

**Status:** ongoing experiment. Checks of the committed version do not validate subsequent changes.

### October 19, 2026 — Sarepta hull reconstruction

Created a [170 mm Sarepta hull study](models/sarepta/README.md) from the published
1974 body plan and arrangement illustrations, with explicit bow tunnels, a
shallow-V aft bottom, hollow foredeck, open cockpit, and recessed outboard transom.
The cabin and motors are deferred.

**Evidence:** OpenSCAD manifold evaluation, a connected closed inspection mesh,
dimension checks, and inspected top and bottom renders. Longitudinal section
positions and several details are reconstructed; this is not a verified factory
replica. Printing, slicing, flotation, and motor fit have not been tested.

### October 22, 2026 — Sarepta guide surfaces and flat foredeck

Rebuilt the bow with convex Bezier guide curves and added a continuous planar
foredeck after photographic review. Saved 92 user-requested gallery references
with source URLs. Checked curve convexity, flat aft joins, closed meshes at 170
and 80 mm, and prepared a new sliced A1 mini trial. The geometry remains a
reconstruction; physical printing is untested. See the [model notes](models/sarepta/README.md).

### October 23, 2026 — Sarepta dimensions and internal framing

Corrected the bare-hull height and motor-transom datum, added the published
cockpit envelope, separate bow locker, raised motor well, interior framing,
side corrugations and chine flanges. [The new milestone](models/sarepta/releases/2026-10-23_dimensions-framing/README.md)
contains 80 and 170 mm binary STLs and pictures of their actual meshes. Both
sizes pass edge/vertex topology and guide-curve checks; physical printing
and unmeasured factory details remain unverified. A subsequent
[photo correction](models/sarepta/releases/2026-10-23_straight-side-ridges/README.md)
keeps the side corrugations horizontal, ends them before the bow and extends
them flush to the transom.

### October 23, 2026 — Sarepta evidence and mesh archive

Preserved the full recovered factory passport, original reference images, offline
source/tutorial snapshots, dimensional conflicts and pending corrections in the
[Sarepta project](models/sarepta/README.md). Added a local hull-reconstruction
skill and seven surviving STL milestones, each with views rendered from its
actual mesh. Source attribution and checksum verification accompany the archive.
The archive checkpoint records the known excessive hull height; dimensional
corrections are subsequent work, not claimed by the archived versions.

## Areas of Work

- **[Funny ATV](models/funnyAtv.scad):** gears, frames, and LEGO-compatible connections.
- **[Sarepta](models/sarepta/README.md):** a 170 mm reconstruction of the motorboat hull.
- **[Bathroom holder](models/bathroomHolderCircle.scad):** household mounting and structural reinforcement.
- **[Phone / MagSafe holder](models/iphone_holder/):** bases, supports, clamps, and indexed connections, including [historical designs](models/iphone_holder/old/) and the [insert experiment](models/iphone-holder-ring/).
- **[Super Cubes](models/super_cubes/):** a threaded modular construction system.
- **[Mechanical blocks](models/mechanical_blocks/):** exploration of locks and household construction interfaces, with an [interactive concept board](concepts/smart-mechanical-blocks/).
- **[Shared libraries](lib/) and tools:** reusable geometry and print preparation.

## Recording New Achievements

Add an entry after a meaningful result, including:

- A date or period.
- What was achieved.
- Links to source files and available evidence.
- How it was checked: geometry, printing, assembly, or use.
- Lessons learned and known limitations.

Group small changes from one iteration into a single entry. Distinguish creation, testing, and repository-recording dates when they matter to the history.

## Working with the Project

Models are developed in OpenSCAD. Shared libraries support several areas of work.

Export STLs with [`export_stl`](export_stl). Select an individual part when exporting an assembly model. Supply an explicit output directory following `<STL_BASE_PATH>/<YYYY>/<YYYY.MM>/<YYYY.MM.DD>/`; the base path must be provided for the current export. Exported filenames include the export date.

For example, after resolving the destination directory:

```bash
./export_stl super_cube --source models/super_cubes/cube1.scad \
  --output-dir "$destination_dir" -- -D 'part="cube"'
```

[`export_bambu_project`](export_bambu_project) prepares Bambu Studio projects. See the [thread fit reference](docs/printing/thread-fit.md), [PETG printing notes](BAMBU_LAB.md), and [holder development notes](models/iphone_holder/DEVELOPMENT_NOTES.md) for recorded parameters and context.

Historical models are preserved with their development context. Successful check records apply to the stated milestone: rerunning older checks may require restoring source paths and historical artifacts. Local exports under `stl_exports/` are ignored by Git.

## Licensing

The bundled Dan Kirshner `threads.scad` library (version 2.7) is licensed under GPL-3.0-or-later. The repository-authored OpenSCAD models using it directly or indirectly are distributed under the same terms; their scope is listed in [Licensing and Third-Party Notices](THIRD_PARTY_NOTICES.md).

The [complete GPLv3 text](LICENSES/GPL-3.0-or-later.txt) is included. Original library credits and notices are preserved. Unrelated repository content has no blanket license assigned by this notice.
