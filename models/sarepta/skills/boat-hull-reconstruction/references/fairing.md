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
