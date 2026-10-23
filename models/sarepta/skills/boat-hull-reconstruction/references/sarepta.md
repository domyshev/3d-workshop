# Sarepta context and project decisions

Read [the current dimensional audit](../../../DIMENSION_RESEARCH.md),
[pending corrections](../../../PENDING_CORRECTIONS.md), and
[the release history](../../../releases/README.md). They are maintained as the
source of truth; do not duplicate their dimensions here.

The user values faithful bottom and side shapes, especially the three bow stems
and paired tunnels. The cabin and outboard motors are separate later parts.
170 mm is the target size; 80 mm is the current print trial. The sharp plan bow,
fair external side arcs and continuous rim were accepted. Current excessive
height is acknowledged and awaits correction at the archive checkpoint.

Current source uses X bow-to-stern, Y transverse and Z above the keel baseline.
Full-size coordinates and model-millimetre wall thickness coexist. The 4600 mm
scaling reference follows the early article and does not resolve all source
variants. A new dimension-based revision must declare which source it follows.

OpenSCAD on the recorded Mac works through the x86_64 binary; the ARM invocation
previously failed CPU-feature checks. Re-discover the executable on another host.
Design previews should open in OpenSCAD. Bambu exports are made only on request.
