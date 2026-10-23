# Interior, foredeck and small features — 2026-10-23

## Evidence examined

- Complete locally preserved factory passport, especially appendix 1 assembly
  view, appendix 2 plan/seat layout and construction description.
- [1974 design/construction article](https://www.barque.ru/projects/1974/powerboat_trimaran_sarepta),
  its general arrangement, exploded sections and construction nodes.
- [Novak handbook excerpt](https://motorka.org/m_lodki/579-sarepta.html).
- [Owner restoration article](https://motolodka.ru/boats/repair/sar_rep.htm),
  especially actual helm photo 15 and open bow locker photo 11; selected
  originals and text are archived under `reference/sources/interior-restoration/`.
- [Sarepta 691 owner thread](https://forum.motorka.org/threads/28515/):
  description of the originally isolated bow locker and a subsequent cut-out.
- Existing 92-photo physical-kit gallery, especially images 31, 49 and 56..67.
  Useful visual cross-check, not a factory dimension source. Kit X lattices
  and print supports are not adopted as real structure.
- Latest user feedback screenshots and earlier real-boat side photographs.

## Findings and treatment

| Feature | Evidence | Revision / remaining uncertainty |
| --- | --- | --- |
| Helm front | Actual photo shows a short upper instrument panel with lower leg area | Replace the uninterrupted full-height front wall with a stepped boundary. Panel height 200 and forward reach 300 are user/photo-based estimates, not verified factory measurements. |
| Bow locker | Handbook explicitly specifies a watertight partition and deck-hatch access; owner describes an added opening as a defect | Preserve separation with a horizontal ceiling over the footwell and a lower forward wall. Connect the lower locker internally to its hatch, not to the cockpit. |
| Leg niche | User requests usable forward space beneath the instrument panel; actual helm photo is consistent, without a complete section | Horizontal underside at Z=550; lower partition at X=1100 instead of X=1400. Physical toe clearances are limited by the real rising bow shell. |
| Side landing strips | Passport plan and arrangement show broad planishirs and separate sliding-cabin guides | Widen the upper cockpit ledges inward by 80 each side. The nominal 1280 interior envelope remains a source dimension; upper opening becomes 1120. Do not call 1120 a measured factory opening. Frames retain their existing geometry. |
| Boxed upper sides | Factory article describes protected flotation blocks in side/deck niches; owner identifies upper boxed sides | Add inner returns beneath the landings. Foam and perforated cover patterns are not guessed. |
| Four small lockers | Factory article and handbook explicitly mention four niches in planishirs and dashboard | Add two backed dashboard pockets and one backed side pocket per side; location, opening size and depth are estimated and adjusted for printing. |
| Deck beads | Passport appendix 2 and kit close-up show straight short parallel beads | Straight X direction at Y=+/-475, total length 560 against hatch length 500; height reduced from 15 to 10; width 24. All dimensional values remain reconstructed. |
| Motor-well drains | 1974 article explicitly describes scuppers | Add two through-transom drains at Y=+/-430 near estimated well-floor level. Diameter 30, with 0.8 model-mm minimum. Count and placement are not verified factory callouts. |
| Longitudinal seats/lockers | Passport and primary article show convertible front seats, side benches and aft bench above fuel storage | Keep these as future separate parts so the exposed frame study remains reviewable; do not confuse the aft fuel space with the raised open motor well. |
| Bow anchor compartment | Factory arrangement describes separate anchor stowage protecting baggage | No unverified access hatch or divider position added. Requires a clearer interior photo/drawing. |
| Cabin tracks | Assembly drawing labels separate sliding guides and construction nodes | Provide broad landing surfaces now; final rail/locating geometry must be coordinated with the later separate cabin. |
| Floor panels | Primary arrangement describes seats and floor; actual owner photos show finished floor mats, absent from bare kit | Retain visible ribs in this hull study; removable floor panels need separate dimensions rather than an invented solid fill. |
| Hull self-bailer | Primary article describes a controlled transom valve | Not represented by an unvalved hole; valve dimensions/location remain unmeasured. |
| Transom panel/rake | Prior source audit and restoration distinguish structural panel, board, well floor and knees | Retain the current estimated arrangement; owner long-shaft conversion is not copied as factory geometry. |

## Geometry and print allowances

Main deck Z=750; nominal upper instrument face ends at Z=550, including
its horizontal footwell ceiling at that underside level. The stepped partition
has model wall thickness 1.2, independent of full-size plating. The lower
wall is X=1100 and dashboard face X=1400.

Side landings cover frame tips (inner opening half-width 560, existing
frame cut-out half-width 620); the frame definition itself is unchanged.
Returns have positive overlaps with roof material. Small storage recesses
retain at least 0.55 model-mm backing, do not open through the outside skin,
and remain below the roof junction. Motor-well drain bores overlap the raised
floor slightly to avoid a tangent-only Boolean join. Scupper sizing is a print
allowance, not a hydrodynamic design.

STL has no material colour. The parametric model and mesh-view wrappers use
neutral grey; renders and OpenSCAD launch use the Tomorrow colour scheme
to avoid Cornfield yellow.

No complete interior production drawing or measured footwell section was
found. The new details improve the reconstruction, not its claim to exactness.
