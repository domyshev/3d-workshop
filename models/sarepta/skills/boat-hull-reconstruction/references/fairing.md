# Fairing checks and demonstrated failure modes

## Curve checks

For a planar guide r(t)=(x(t),z(t)), signed curvature is
`(x' z'' - z' x'') / (x'^2 + z'^2)^(3/2)`. Inspect its sign and variation where
the reference calls for a convex stem; do not forbid intended inflections in
unrelated sheer lines. Reject singular derivatives and unintended loops.
The sign can be checked without division when only a reversal test is needed.
Repeat in XY for a shoulder: smooth Z profiles do not guarantee a fair plan.

Matching endpoints gives positional continuity. Check tangent direction across
a join and curvature behaviour where required. For the current quintic profile
construction, the final three control-point Z values coincide, producing zero
Z slope and curvature at its flat continuation. This is a specific construction,
not a universal requirement for all hulls. Preserve hard transverse creases.

Use common parameter correspondence along ruled surface strips. Check row
ordering, cross-sections, symmetry and triangle orientation. Independently
interpolated intermediate points can create a pocket even between fair guides.
Avoid using extra triangles to disguise a poorly constrained surface.

## Photo interpretation

A near-plan photo can suggest a bow angle, but perspective, lens distortion and
kit inaccuracies remain. Compare both sides, choose long edge spans, document
point selection and report an estimate. Do not treat an apparent 132-degree
angle as a factory callout. True scale requires calibrated drawings or a survey.

## Shells and offsets

Use an inward/outward normal offset for a uniform projected rim; handle corners
and offset self-intersections. Profile leg size and installed lip projection
are different measurements. A transverse YZ inset is not a proof of minimum
normal thickness over a three-dimensional shell. Explicitly retain that limit.

A narrower upper belt needs its own cavity or bounded cuts. Simply extending
a broad bottom cavity upward can cut through it. Shared edges or coplanar
Boolean faces can generate slivers and collapsed triangles on export. Overlap
inside the solid instead of leaving coincident shells, then check the final
STL's precision, not only a higher-precision intermediate format.

## What failed in this project

- A common tiny bow section flattened three distinct stems.
- Local X patches fixed endpoints but kinked the stem curves.
- Tangent continuity alone left curvature dents.
- An S-shaped plan shoulder remained concave despite fair vertical profiles.
- A deck following tunnel recesses produced the wrong scalloped top perimeter.
- Adding an upper belt above a complete published side height made the hull tall.
- Extending old cavities and using coincident surfaces created holes/slivers.
- A new raised deck required the motor-well bulkhead to continue upward; a
  floating roof bridge otherwise created unintended internal passages.

## Evaluation

At each material revision compare bounding dimensions and the appropriate
sections against identified datums. Check nonzero faces, paired oppositely
directed edges, components and positive signed volume. Euler characteristic
is diagnostic, not a stand-alone pass criterion. Inspect lower and upper
views with lighting that exposes dents, then compare orthographic silhouettes.
Mesh checks, slicer completion and successful physical printing are separate
evidence levels. None certifies hydrodynamics or factory fidelity.

## Dimension/framing revision findings

Paired edges can still miss two surface sheets touching at one point. The
checker now also requires each vertex link to be one closed cycle. Inspect
the exported binary STL as well: ASCII precision can hide faces which collapse
at the 32-bit precision used by binary STL and many slicers.

Small internal overlaps and a slight offset of the rib-clipping solid eliminated
coincident facets. A continuous swept chine strip replaced hundreds of
overlapping segment caps, removing tiny Boolean slivers in binary export.
The new two-scale release is single-component with Euler characteristic 2;
this is consistent with its separate hatch-accessed locker and open cockpit,
not a universal genus requirement for every hull.

A constant fraction between a rising chine and a sloping seam does not produce
a horizontal side corrugation. For the Sarepta photo correction, intersect the
side panel with a constant-Z plane, solve the longitudinal parameter for X,
and follow only the transverse Y variation. Flat end caps and a flush transom
termination are independent of the rounded ridge cross section.

## Interior boundaries and inspection

Do not conflate a short instrument panel with the watertight bow-locker
boundary. A footwell may use a stepped boundary: a horizontal ceiling and a
forward lower wall preserve separation. Its dimensions require source evidence
or an explicit reconstruction label. Check actual exported material at leg
space, partition, ceiling and hatch-access points, and inspect a central slice.
A full half-cut can hide voids behind the far sidewall; a thin centre section
shows material versus air more clearly. Frame tips can be covered by wider
landing strips without changing the frames.

Keep blind pocket cuts clear of roof/bulkhead Boolean junctions. Tangent
drain bores need a small positive overlap with the floor. Fixed printable wall
thickness can change small openings/topology between scales; report exact
mesh metrics and avoid treating genus as universally fixed across revisions.

## Bow plan narrowing and proportions

Convexity alone does not constrain where a plan begins to narrow. Three
control points at full half-beam can concentrate the taper near the bow and
still pass a curvature-sign check. Inspect width at fixed X stations and
the visible shoulder relative to the cockpit front, hatch and closed deck.

At a deliberate V/shoulder junction, trim the shoulder's normal offset where
it intersects the forward-edge inset; an untrimmed endpoint normal can
protrude ahead of the V or cross the side chine. Local corner rounding must
retain the intended sharp foremost tip. Give cap skins a positive overlap
when coplanar loft/sheet faces produce collapsed binary-STL triangles.

General-arrangement diagrams, photos and kit reconstructions may disagree.
Record approximate pixel landmarks and uncertainty; do not promote an
image-normalised ratio to a factory dimension. Coordinate deck/hatch/pad
changes with the cockpit/footwell while preserving accepted stern datums.
