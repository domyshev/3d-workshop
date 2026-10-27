---
name: boat-hull-reconstruction
description: Reconstruct and refine printable boat hull geometry from dimensioned drawings and photographs, including fair guide curves, hard chines and multi-bow cathedral hulls. Use for scale-model CAD work, not ship stability or structural certification.
---

# Boat hull reconstruction

Produce a visually fair, dimensionally traceable and printable hull while
preserving the user's chosen scale, accepted shapes and separate-part plan.

## Establish the evidence before geometry

For this project read [Sarepta context](references/sarepta.md), then the linked
dimensional audit and pending corrections. Separate explicit printed dimensions,
scaled drawing estimates, perspective-photo estimates and implementation choices.
Name the production variant and coordinate datums. Never promote a frame label
to a measured station position. An STL passing topology checks is not proof of
a factory-accurate shape.

When a dimension conflicts, keep the source distinction visible. Map keel datum,
side height, seam, upper deck and motor-transom height before modifying their
coordinates. An upper belt is part of overall side height, not an automatic
addition above it. Use a nearby boat's dimensions only as labelled estimates.

## Fair curves before surfaces

Use the fewest guide curves/control points that can represent the evidence.
Inspect profile, plan and transverse sections independently; check curvature
variation and intentional versus accidental inflections. Read
[fairing and topology](references/fairing.md) for the useful mathematical checks
and failure cases. Prefer an explicit crease or patch boundary for a hard chine;
smoothing every edge erases the real hull's construction.

For a cathedral bow, preserve separate centre stem, two side stems and tunnel
crowns to their genuine upper boundaries. Do not collapse them into a tiny
common end cap. Fair longitudinal joins as well as endpoint positions. A flat
or gently inclined continuous deck can bridge the three noses without forcing
the lower tunnel shape into a scalloped deck outline.

Treat the hull side, reverse-flared upper belt, protective rim, chine flange and
pressed stiffening grooves as different features. Derive a uniform rim from a
normal offset, rather than independently tuning unrelated outlines. A flange
is not implied at every seam. Preserve accepted lower guides while adjusting
upper height; avoid globally squashing the mesh.

## Build and verify the solid

Keep nominal print wall/deck thickness in model millimetres separate from
prototype metal thickness. Update internal cavities with exterior changes.
A wide lower-hull cutter can punch through inward-sloping upper sides. Use
well-defined overlaps at Boolean joins; avoid coincident skins and floating
bridges. Use source-backed bulkheads and leave only intended compartment openings.

Evaluate the supported sizes, inspect front/side/top/bottom/stern views and
critical cross-sections, and check the exact exported mesh. The bundled
[scripts/inspect_stl.py](scripts/inspect_stl.py) reports bounds, degenerate triangles,
edge incidence, vertex links, components, Euler characteristic and volume using the standard
library. Interpret topology against intended openings: a hatch connected to
an open cockpit can legitimately give genus one. Validate visual fairness
separately; higher tessellation alone does not remove a geometric dent.

## Split parts after physical-print feedback

Distinguish a visible prototype seam from a functional glue plane. If the user
needs a horizontal printable mating face, use one global Z plane and ensure
neither part crosses it; do not keep hanging returns on the upper via ownership
exceptions that introduce steps. Transfer returns to the lower and connect
them with a narrow continuous perimeter landing. Preserve open access to the
lower interior when the cover is removed; never replace that access with a
full nose sheet unless explicitly requested. Strengthen shallow bow tips with
a raised edge/rim and small local socket webs rather than closing the bay. Declare any added height separately from prototype
measurements and preserve openings when adding reinforcement. Generate pin
bores on shared axes normal to the new plane, retaining blind end walls.
Check the actual meshes for planar bounds and sampled contact support. A
reported warped print is feedback, not proof of temperature as its cause.

## Preserve a reviewable milestone

Keep the prior accepted source and exported STL. Record dimensions, evidence,
changes, remaining assumptions, geometry checks and physical-print status.
Render historical comparison pictures by importing each actual archived STL
with common cameras. Do not illustrate an old STL with the latest live source.
Follow repository export rules and the user's current viewing/slicer preferences.
This skill does not authorise external messages, publishing or Git pushes.

## Sources and scope

Read [method sources](references/method-sources.md) when revisiting the underlying
guidance. The external naval-architect role is reviewed reference text, not a
dependency. This project-local skill is an original workflow distilled from the
iterations and the official McNeel fairing tutorial.
