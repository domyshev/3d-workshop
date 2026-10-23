# Sarepta STL development history

Seven surviving 80 mm exports, preserved byte-for-byte on 2026-10-23. Original
exports were made with the repository exporter. Copying them here does not
regenerate or repair them. Each view imports its own archived STL with common
orthographic camera settings.

**The latest archived stage still has the known excessive hull height.** It is
the current visual reconstruction, not the dimension-corrected final model. See
[pending corrections](../PENDING_CORRECTIONS.md) and [the dimensional audit](../DIMENSION_RESEARCH.md).

![Milestone comparison](comparison.jpg)

| Stage | What changed | Mesh size, mm | Known limitation |
| --- | --- | --- | --- |
| [Initial printable hull](2026-10-20_initial/README.md) | Initial station-table reconstruction and 80 mm trial. | 80.000 x 27.826 x 13.948 | Bow contours collapsed near the deck; stem shape and longitudinal station positions were provisional. |
| [Separate sharp bow edges](2026-10-21_sharp-bow/README.md) | Preserved individual centre/side stem endpoints and paired bow tunnels. | 80.000 x 27.826 x 13.948 | Stem lines still kinked where endpoint offsets transitioned into the body. |
| [Continuous stem tangents](2026-10-21_continuous-bow/README.md) | Replaced short endpoint offsets with independent Hermite profiles and smoother joins. | 80.000 x 27.826 x 13.948 | Remaining curvature dents and scalloped foredeck perimeter; superseded. |
| [Fair guides and continuous foredeck](2026-10-22_fair-flat-deck/README.md) | Adopted three convex quintic Bezier guide profiles, smooth flat aft joins and a continuous foredeck. | 80.000 x 27.826 x 13.043 | Plan-view bow was too blunt, around 154 degrees; reconstruction remains approximate. |
| [Sharper photographic bow plan](2026-10-22_photo-bow/README.md) | Matched an apparent near-top photo angle of about 132 degrees; model angle 132.501 degrees. | 80.000 x 27.826 x 13.043 | Photographic angle is not a factory dimension; hatch, side-curve and rim work followed. |
| [Hatch, fair side arcs and continuous rim](2026-10-22_hatch-fair-rim/README.md) | Added the hatch opening, removed the S-shaped shoulder and continued the protective rim around the bow and sides. | 80.000 x 27.826 x 13.043 | Flat upper deck omitted the reverse-flared upper belt; 50 mm prototype rim and hatch sizes were estimates. |
| [Upper belt and shallow foredeck relief](2026-10-22_upper-belt-relief/README.md) | Added inward-sloping upper sides, a pointed raised pad around the hatch and two shallow rounded ribs. | 80.000 x 27.826 x 16.522 | CURRENT GEOMETRY, AWAITING DIMENSION CORRECTION: seam was incorrectly placed at 750 mm before adding the upper belt, giving up to 950 mm prototype height. Transom remains 400 rather than passport 375 mm. |

## Reproduce the inspection and pictures

Use `../skills/boat-hull-reconstruction/scripts/inspect_stl.py <file.stl>` for
mesh metrics, and `../tools/render_release_previews.py` for the common views.
On the recorded Mac, pass `--openscad /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD --x86`.
The first three stages retain exact exported meshes but no independently verified
parametric snapshots. The four later stages include source snapshots and 80 mm entry points.

No stage is documented as a successful physical print. Historical Bambu slicing
estimates in the development log apply only to their named versions and settings.
