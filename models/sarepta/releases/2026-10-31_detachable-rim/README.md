# Detachable protective rim and clean bow-board edge

Revision: 2026-10-31, following `clean-bow-floor`. Scale reference remains 170/4600.
The earlier completed geometry work is published in [PR #1](https://github.com/domyshev/3d-workshop/pull/1).
This subsequent construction revision is preserved locally as a new milestone.

## Changes

- Trim the inward hanging bow-board return to one vertical inner edge. The old access-opening outline is expanded by 0.3 mm in plan over the forward 58 mm; this is a modelling clearance, not a factory measurement. The external bow plating below the rim band is preserved.
- Separate the protective skirt into one bow piece and two aft strips. Their joints at X=58 have a 0.2 mm gap. Retain the actual original inclined outer shape and thickness, rather than fitting an unrelated ring.
- Remove the integrated skirt from the lower hull. A coherent 0.03 mm inset cutter avoids coincident inherited STL facets. A 0.12 mm outward skirt offset provides approximately 0.15 mm separation.
- Add 14 separate headed side locators, seven on each side at X=20, 42, 70, 95, 120, 145, 163 mm. Separate pins allow the bow piece to be fitted without spreading a closed arc.
- Pins: 0.8 mm shaft diameter, 2.6 mm shaft length, 0.2 mm tapered tip; head diameter 1.2 mm and thickness 0.25 mm. Each pin passes from the outside through a 1 mm skirt bore into a 1 mm hull bore. Hull pockets are blind, 0.95 mm deep, with a short entry chamfer. Actual assembled insertion is 0.762–0.777 mm.
- Keep the cover and four existing vertical cover locators byte-identical to the parent. The dashboard remains hidden.

## Inspection and printing

Open `inspection-view.scad`: the lower hull, inverted cover, three skirt pieces, fourteen skirt pins and four cover pins are separated for inspection beside a complete assembly. Colours are pastel blue, sand, lavender and sage. `assembly-view.scad` shows only the assembled model.

The assembly-coordinate STLs are explicitly labelled `detachable_*`. The `print-rim-*.scad` wrappers rotate each skirt's inclined underside onto Z=0 for separate printing. The single `rim_pin` STL is upright on its head; make fourteen copies. Pin dimensions and bore clearances are nominal print allowances. Fit and durability of these small pins require a physical trial.

## Export and provenance

Generate cutters with `python3 generate_clearance.py`. The original shared guide table remains archived in `../2026-10-31_level-stern-ribs/belt-guides.json`. Locator axes record X, hull interface Y, Z, and original skirt outer Y in millimetres.

Run `export.sh` with the conversation-authorized absolute dated destination. Exports use the repository `export_stl`, Manifold and binary STL. `raw/` stores exact unmodified tool exports. `clean_export.py` removes only zero-area facets, with no vertex movement, component deletion or hole filling; individual cleanup logs record counts and unchanged volume. Upper and vertical pin meshes are copied unchanged from the parent. `manifest.json` records hashes, sizes, origin paths and dates.

## Verification

`regression.py` preserves the prior material, guide, joint, wall, floor-rib and drain checks, excluding the intentionally removed exterior rim band from exterior/bottom comparisons. `verify.py` checks all seven final mesh files and additional skirt/pin pocket probes. Both reports pass: all meshes are single connected closed surfaces with positive volume, paired edges and valid vertex links. Measured side clearances are approximately 0.15 mm; bottom/exterior samples below the skirt band have zero change; both drain clearances remain 0.8000004 mm.

Bow and combined inspection pictures render the exact archived STL files. Checks are finite samples, not a global minimum-wall or self-intersection proof. No new physical print, assembled fit, strength or watertightness has been verified. Earlier releases and the reported successful 0.1 print baseline remain preserved.
