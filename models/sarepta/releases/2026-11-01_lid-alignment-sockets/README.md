# Native lid joint with small alignment sockets — 2026-11-01

Parent: `2026-11-01_two-point-five-mm-bolt-joint`, committed as b50006d in author PR https://github.com/domyshev/3d-workshop/pull/2 before this lid follow-up. Historical sources and meshes are preserved.

Remove the complete inward upper joint reinforcement. Each lid half now has exactly the original lid shape, split at the common middle plane, minus its two small alignment sockets. The original roof-to-side corners provide the socket material. No inward pad or bolt/nut lug is added to the lid. The lower hull is byte-identical to the parent: its 2.5 mm flanges, 12 mm circular pads and four 4.3 mm M4 through bores remain.

At overall length 340 mm the two lid axes are Y=±50 mm, Z=58.6 mm. Matched blind sockets are 2 mm in diameter and 3.2 mm deep in EACH half along X. Print two chamfered headless guide pins, nominal diameter 1.8 mm and length 6 mm. The 0.2 mm diametral and 0.4 mm paired axial clearances are nominal; physical pin fit is untested. No lid bolt head or nut clearance is required. These small lid features scale uniformly with the original lid: at overall length 170 mm the sockets are 1 mm diameter by 1.6 mm depth and pins 0.9 mm by 3 mm. Independent lower-hull joint dimensions remain fixed millimetres.

## Artifacts and checks

- `source.scad`: native construction with lid sockets and guide pins.
- `inspection-view.scad`: separated pastel parts, two lid guides, existing hardware and complete assembly.
- `lid-face-view.scad`: thin cross-section from the actual archived lid export.
- `print-<length>-<part>.scad`: four main component poses.
- `2026-11-01_sarepta_340mm_lid_print_*.stl`: four print meshes, maximum length 170 mm.
- `2026-11-01_sarepta_340mm_lid_joint_pin.stl`: print two copies for the 340 mm boat.
- `*_lid_joint_*.stl`: assembled-coordinate components and pins for 170/340 mm.
- `verify_lid.py`, `lid-verification.json`: closed mesh checks, 800 material probes, paired mating faces, clear bore passages, blind bottoms and original corner support.

At 340 mm the combined upper volume equals the original unsplit lid volume minus 40.14782 mm³, exactly the intended two polygonal socket pairs within mesh precision. At 170 mm the removed volume is 5.01848 mm³. Explicit probes reject the old inward extensions. Lower meshes are byte-identical to the verified parent; its full lower-joint checks remain applicable. `print-verification.json` confirms all four 340 mm print poses lie on the bed and are at most 170 mm long.

Updated meshes use repository `export_stl` into the authorized project directory `stl/2026/2026.11/2026.11.01/`. Exact raw exports, surface-preserving cleanup logs, archived views and hashes are retained. No vertices are moved, holes filled or components discarded to repair the mesh. Existing skirt and cover locators are reused. Use the reported lengthwise print placement and check brim/support clearance when slicing. No new Bambu project or physical strength/fit test is included.
