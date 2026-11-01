# Transverse glue joint and independently sized hardware — 2026-11-01

Parent: `2026-11-01_front-skirt-sockets`. This construction revision preserves
that source and all earlier exports. The owner confirmed a transverse middle
cut into a bow and stern, with four glue-guide pins: two near the upper sides
and two evenly distributed along the bottom. The skirt must not receive a new cut.

## Length and scale

The source geometry is the accepted 170 mm reconstruction. Set `boat_length_mm`
in `source.scad` to choose the overall nominal length. The inspection scene has
two archived verified choices: 170 or 340 mm; it defaults to 340 mm, with a
nominal 170 mm bow and 170 mm stern. Actual bare bow pieces are slightly shorter
because the original projecting protective skirt is separate.

The new glue land is always 4 mm inward, its axial reinforcement is 3 mm on EACH
side of the cut, and its bores remain 2 mm regardless of overall length. The
new headless joint pins are 1.8 x 4 mm, leaving 0.2 mm nominal diametral clearance.
Use the length parameter and regenerate when changing size: uniformly scaling
a finished STL would also scale these fixed joint dimensions. Existing model
features and their original mating pins scale together with the original boat;
for example, the previous 2 mm hinge sockets become 4 mm at overall length 340.

## Split construction

The common cut plane is X=`boat_length_mm/2`. The lower hull and removable cover
are each exported as a bow and stern, giving four large printable components.
The lower's added U-shaped land follows the native inner hull section, using a
normal 4 mm inward offset and a small positive overlap into existing plating.
The cover's side rails receive inward reinforcement at the same station. All
mating faces lie in the same plane, without an intentional glue gap or an exterior
step. The opening remains accessible; no transverse sealed bulkhead is added.

Four shared axes run along X. The side axes are 2.5 mm below the lower hull's top.
The bottom axes divide the inner bottom span into thirds and are centred in the
land. At length 340, the side axes are Y=±51.0792, Z=47.5 and the bottom axes are
Y=±15.3448, Z=7.3389 mm. Both halves use the same axes. Straight bore diameter is
2 mm, depth 2.2 mm per half, with a short 2.3 mm lead-in at the mating face. The
3 mm axial land leaves 0.8 mm behind each new blind bore where it borders the
original hollow interior. Four 4 mm long printed pins have 0.4 mm total axial
clearance inside the paired sockets. Pin dimensions are nominal and unprinted.

The three existing skirt meshes, eighteen skirt studs and four cover locators
are reused with matching uniform model scaling. No new transverse cut is made
in any skirt part. Glue and align the hull/cover halves before fitting the skirt.

## Files

- `inspection-view.scad`: separated pastel halves, the unchanged skirt pieces,
  all pins, and a complete assembly. Choose 170/340 through `boat_length_mm`.
- `source.scad`: native parametric construction for another length or joint size.
- `joint-face-view.scad`: thin views of both actual lower mating sections.
- `print-<length>-<part>.scad`: print orientations for the four split components.
- `2026-11-01_sarepta_340mm_print_*.stl`: four already oriented exports; lower
  pieces retain the lengthwise baseline, cover pieces are inverted onto the bed.
- `2026-11-01_sarepta_joint_pin_1_8mm.stl`: print four copies for the new joint.
- `*_joint_*.stl`: exact assembled-coordinate component meshes for both sizes.

The maximum print-piece length for the 340 mm model is 170 mm. Check brim/support
clearance and re-slice for the actual printer. The older successful 0.1 placement
was lengthwise along the bed; archived diagonal slicer projects remain unchanged.
No new Bambu project, G-code, process setting or physical print is claimed.

## Provenance and checks

The native cavity-section probe was exported through repository `export_stl`;
`section-profile.json` records its contour, original cut datum, chine and hash.
`section-profile.scad` provides the same guide to the parametric pin positions.
`joint-axes.json` records the two verified configurations. `export.sh` regenerates
the two assembly-coordinate sets; the print wrappers are exported through the
same repository tool. Authorized destination: `stl/2026/2026.11/2026.11.01/`.
Exact unmodified tool exports are retained in `raw/`. Each cleanup log describes
only surface-preserving zero-area refinement. The generator sources, meshes,
reports, renders and logs are hashed in `manifest.json`.

`verification.json` passes 808 material probes across both sizes, closed
single-component mesh checks, planar bounds, matching mating-face areas, actual
2 mm bore measurements, 2.2 mm blind depths, and preserved sampled outer/bottom
surfaces. At 340 mm, each lower mating face is 1109.3304 mm² and each upper mating
face is 227.1821 mm²; opposite faces agree exactly in the exported meshes.
`print-verification.json` confirms the posed 340 mm pieces have length <=170 mm
and bed-plane Z within 0.00001 mm. These finite checks do not certify print fit,
adhesive strength, watertightness or global minimum wall thickness.
