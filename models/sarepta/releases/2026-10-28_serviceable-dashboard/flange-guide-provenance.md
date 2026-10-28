# Flange-cut guide provenance

The cutter samples the accepted native `guide_point(2, r)` and
`side_at_height(r, z)` functions at `fair_rows[6:]` from the 2026-10-23
bow-plan source. Each row records [X, inner lower Y, lower Z, inner upper Y,
upper Z]. The cutter is 1 mm high around the original chine, extends 0.15 mm
beyond the strip endpoints and leaves a 0.015 mm transverse skin allowance.
It removes the former roughly 1.1 mm projecting flange without subtracting
coincident native/float32 surface patches. The retained allowance is below
the selected FDM nozzle/line width; no independent 0.35 mm-thick ledge remains.
Coordinates are stored in `source.scad`; this is a print simplification,
not new prototype measurement evidence.
