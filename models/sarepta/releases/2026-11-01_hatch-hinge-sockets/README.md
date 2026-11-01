# Top-entry hatch-hinge sockets — 2026-11-01

Parent: `2026-11-01_fair-bow-root`; scale reference 170/4600.
The owner requested two approximately 2 mm blind pin sockets in the upper cover
immediately forward of the hatch, with solid reinforcement where the cover was
previously hollow. Vertical insertion from the outside/top was explicitly
confirmed. All dimensions below are model millimetres, not factory callouts.

## Geometry

- Axes: X=32.2, Y=-5/+5 mm; spacing 10 mm, symmetric about the boat centreline.
- Nominal bore diameter: 2.0 mm. Straight cylindrical top entry without a head pocket.
- Each socket is 2.8 mm deep from the existing embossed pad surface.
- A 4.4 mm diameter solid boss fills the underside cavity, making the local total
  thickness 3.2 mm. Its upper end overlaps the existing roof skin by 0.2 mm.
- Closed bottom thickness: 0.4 mm. Nominal surrounding radial wall: 1.2 mm.
- The hatch front is X=35.1087 mm; the boss footprint ends at X=34.4, preserving
  approximately 0.7087 mm of plan clearance to the opening. No hatch edge is cut.
- Bosses stop above Z=27.3793 mm, leaving clearance above the lower hull's Z=25
  mating plane. No lower-hull or skirt component is modified.

These are hinge mounting-pin sockets. The hinge bodies, hatch lid and matching
pins are not added in this revision. Printed bore size and hinge fit are untested.

## Files and provenance

`source.scad` adds the two cylinders and subtracts only their blind bores from
the archived parent upper mesh. `export.sh` uses repository `export_stl` and an
authorized absolute dated destination. Exact unmodified tool output is archived
in `raw/`; `cleanup-upper.json` records that no facet or coordinate changes were
needed. Other six component meshes are byte-identical copies of the parent.
`manifest.json` records the source, export path, hashes and file sizes.

`inspection-view.scad` shows separated pastel components and a complete assembly.
`hinge-top.png` shows the two sockets ahead of the opening. `hinge-bottom.png`
shows their solid reinforcing bosses and closed undersides. These pictures are
rendered from the exact final archived STL, not a separate live approximation.

## Checks

`verify.py` samples the open bore volume, full blind bottoms, reinforcement rings,
roof bridges and unchanged hatch opening. Actual STL measurements are diameter
1.99999994 mm, depth 2.79999924 mm and bottom thickness 0.39999962 mm. Sampled
neighbouring surface intersections are unchanged, all other components compare
byte-for-byte with their parent, and the upper mesh passes closed single-component,
positive-volume, paired-edge and vertex-link checks. Checks are finite geometry
samples; physical hinge mounting and print tolerances remain untested.
