# Current Sarepta fasteners

Current construction: `2026-11-01_four-mm-lid-guides`. Dimensions below are nominal millimetres. **Whole boat 340 mm means nominal 170 mm bow and stern halves.** Do not confuse the two transverse lid guide pins with the four lid-to-hull positioning locators or with skirt studs.

| Connection | Quantity | Fastener for whole length 340 mm | Mating holes / purpose |
|---|---:|---|---|
| Lower-hull transverse seam | 4 bolts + 4 nuts | Purchased M4 bolts with matching M4 nuts | Diameter 4.3 mm, through both 2.5 mm flanges (5 mm combined). No separate smooth hull guide pins. |
| Lid transverse seam | 2 | Printed smooth headless pins, diameter 3.8 x length 4 mm | Diameter 4 mm, blind depth 2.2 mm in each half. Alignment during gluing; no lid nut or bolt head. |
| Skirt to hull | 18 | Smooth headless studs, diameter 1.6 x length 3 mm | Existing matching blind skirt/hull sockets; uniformly scaled original geometry. |
| Complete lid to hull | 4 | Vertical positioning locators, diameter 3.2 x length 4 mm | Existing lid/hull positioning holes; not the new transverse seam. |

Print **two** copies of `2026-11-01_sarepta_340mm_lid_guide_pin_d3_8_l4.stl` for the new lid seam. These files describe smooth printed pins, not threaded bolts. The simplified M4 fasteners in the assembly scene are purchased-hardware envelopes and must not be printed. Their preview represents an M4 x 12 socket-head screw and a standard hex nut; final bolt length depends on washers and actual assembly. Historical `joint_pin_1_8mm` and `joint_pin_4mm` files belong to superseded hull-joint iterations.

## Alternative whole length 170 mm (nominal 85 mm halves)

| Connection | Quantity | Fastener / hole sizes |
|---|---:|---|
| Lower-hull transverse seam | 4 bolts + 4 nuts | Still M4 bolts, 4.3 mm through holes and two 2.5 mm flanges. These settings remain fixed millimetres. |
| Lid transverse seam | 2 | Smooth pins diameter 1.9 x length 2 mm; paired sockets diameter 2 mm x depth 1.1 mm per half. |
| Skirt to hull | 18 | Smooth studs diameter 0.8 x length 1.5 mm. |
| Complete lid to hull | 4 | Vertical positioning locators diameter 1.6 x length 2 mm. |

The lid guides, skirt studs and complete-lid locators scale with the original model; the M4 body joint does not. Regenerate from the source length parameter when changing overall size. Uniformly scaling a finished STL also scales any fixed hole or flange dimensions. Nominal clearance is not a physical fit test. Pin fit, bolt tightening, tool access and joint strength require physical validation.
