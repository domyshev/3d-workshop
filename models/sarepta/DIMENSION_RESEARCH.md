# Sarepta dimensional evidence audit — 2026-10-23

## Result and scope

Recovered and visually inspected a factory passport scan: twelve numbered pages,
five drawing appendices and a cover. Also inspected the 1974 construction-node
and exploded-section drawings, the 1980 factory modification article, handbook
material, repair/model references, and an original 1978 comparative cockpit table.
A complete dimensioned production drawing set or table of hull offsets was not
located. This is a bounded search result, not proof that such drawings do not exist.
The research checkpoint preceded geometry changes. The later 2026-10-23
revision applies selected dimensions; see TRANSOM_AND_FRAMING.md and
PENDING_CORRECTIONS.md for current implementation and remaining estimates.

## Primary-source register

1. Factory passport: [landing page](https://motorka.org/m_lodki/sarepta/2182-doc-sarepta.html),
   [retrieved archival RAR](https://web.archive.org/web/20130809013240id_/http://files.motorka.org/boats/doc_sarepta.rar).
   Local copies: `reference/factory-passport/`. The original file host failed DNS;
   the archived copy was actually downloaded, extracted and inspected. The
   document's issue date and applicable production variant are not established.
2. [Katery i Yakhty No. 48, 1974](https://www.barque.ru/projects/1974/powerboat_trimaran_sarepta).
   [Body plan](https://www.barque.ru/image/12239/3),
   [construction nodes](https://www.barque.ru/image/12239/4),
   [exploded sections](https://www.barque.ru/image/12239/12).
3. [Factory modifications, No. 87, 1980](https://www.barque.ru/advice/1980/modifications_motor_boat_sarepta).
4. Basnin and Volkov, Krym-3 article, No. 76, 1978:
   [transcription with comparative table](https://fishing.kiev.ua/lodki/mlod/krim3.htm).
5. [Novak handbook excerpt](https://motorka.org/m_lodki/579-sarepta.html).

## Explicit published measurements

All dimensions below are full-size millimetres unless stated otherwise. These
values are explicitly printed, not extracted by scaling photographs. They must
remain tied to their particular source and version.

| Part or property | Value | Evidence / qualification |
| --- | --- | --- |
| Overall length | 4600 / 4650; passport appears 4640 | 1974 article / handbook / degraded passport page 2; resolve variant before changing the model |
| Overall beam | 1600 in article and handbook | Passport beam digits are degraded; an apparent 1650 reading needs another clean copy; do not silently replace with either 1650 or 1850 |
| Chine beam at transom | 1300 | Passport p. 2 |
| Side height | 750 | Passport p. 2 and 1974 article; vertical datum/upper edge must be mapped correctly to the model |
| Overall height | 1450 | Passport p. 2; equipped overall height, not bare-hull height |
| Motor transom height | 375 | Passport p. 2; handbook excerpt instead says 400 |
| Transom deadrise | 8.5 degrees | Passport p. 2; handbook excerpt says 8 degrees |
| Chine beam at one-third length forward of transom | 1300 | 1974 article; distinct location from passport transom beam entry |
| Deadrise at that one-third-length section | 8.5 degrees | 1974 article |
| Lower-side flare | About 10 degrees | Approximate wording in 1974 article, not the reverse upper-belt angle |
| Chine spray flange | 30 wide | 1974 article; this is the bottom/side flange, not the upper protective rim |
| Cockpit | 2600 x 1280; area 3.33 square metres | Comparative table in the 1978 Krym-3 article; does not specify complete boundary coordinates |
| Closed locker volume | 0.47 cubic metres | Same comparative table; not enough to determine locker shape |
| Protective gunwale profile | 2 x 20 x 25 | 1974 construction-node caption, bulb-angle profile; profile leg sizes do not directly establish visible rim overhang |
| Keel T-section | 2 x 70.5 x 28 | Same construction-node caption |
| Stiffening T-section | 2 x 50 x 20 | Same construction-node caption |
| Local floor cut-outs | R30 | Nodes 2 and 3 in construction drawing; not a bow/tunnel radius |
| Bottom plate | 2 thick | Passport p. 3 |
| Side and deck plate | 1.5 thick | Passport p. 3 |
| Cabin plate | 1 thick | Passport p. 3; later changed, see below |
| Internal framing plate | 2 thick | Passport p. 3 |
| Glazing | 5 thick | 1974 article |

The 1980 factory article explicitly documents production changes: forward bottom
plate 2 to 2.5 mm, stringers from 25 x 25 bulb angle to 25 x 30 Z profile,
transom knees 2.5 mm, roof from 1 to 1.5 mm, and cabin sides to 2 mm. Early and
late construction details should not be mixed into a claimed single exact variant.

## Still missing for an exact hull and deck

| Required part | What is available | What remains missing |
| --- | --- | --- |
| Three bow stems and two tunnels | Low-resolution body plan and photos | Full ordinate table, longitudinal station coordinates, stem/ridge curves |
| Hull stations | Passport top view labels frames; 1974 drawing shows some sections | Dimensioned frame spacing and complete station shapes |
| Foredeck perimeter | Orthographic-looking passport plan and kit photos | Dimensioned contour, radii and relationship to hull seam |
| Reverse upper belt | Transverse sections and photos | Heights at specified stations, setback and angle |
| Protective rim | Published profile size | Installed projection, orientation and all joint details |
| Nose hatch | Plan and perspective drawing | Opening and lid dimensions, radii, longitudinal position, hinge/seat detail |
| Central embossed pad | Visible in passport plan | Exact height and outline dimensions |
| Paired embossed ribs | Visible in passport plan | Cross section, height, width and start/end coordinates |
| Motor well | General arrangement and construction descriptions | Floor height, depth, widths, partition locations and transom rake |
| Cabin and glazing | Arrangement and connection sections | Overall cabin dimensions, opening contours, rail travel and coordinates |
| Seats, lockers, floor panels | Arrangement and folding diagrams | Detailed part dimensions and exact fixing coordinates |

Scaling a drawing or a model-kit photo can improve visual agreement but is not
equivalent to a published dimension, a factory offset table or a physical survey.

## Audit implications at the pre-correction archive checkpoint

- The 4600 mm reference length and 1600 mm beam follow the 1974 article, not the
  newly recovered passport variant. Do not claim these reconcile all sources.
- The pre-correction motor transom represented 400 mm; passport p. 2 gives 375 mm.
- The 50 mm rim, 500 x 450 mm hatch, 80..200 mm upper-belt heights, 70..100 mm
  upper setbacks and 12.5/15 mm embossed heights remain reconstruction choices.
- The pre-correction source treated Z=750 as the lower seam and adds the upper belt.
  This must be audited against the published 750 mm *side height* and its datum;
  it is not evidence for a 950 mm factory bare hull. The maximum model heights
  reported in earlier verification are mesh bounds, not verified prototype sizes.
- Assumed 460 mm station spacing in the earliest reconstruction was never
  established by dimensioned factory evidence. Passport frame identifiers must
  not be used as proof of that spacing.

## Archive lead for the missing production drawings

[Rosarkhiv catalogue: Volgograd Shipyard](https://guides.rusarchives.ru/node/24307):
State Archive of Volgograd Region, fond R-4011, inventories 1..6, 1170 storage
units, covering 1942..1979. The summary lists factory production and administrative
records, but does not specifically promise Sarepta drawings or a hull-offset table.
This is a concrete catalogue lead requiring an inventory enquiry, not a discovered
online drawing set. No messages or requests were sent to the archive or owners.

Useful requested document types for a future authorised enquiry: complete
theoretical lines plan, table of offsets, frame-spacing diagram, general
arrangement with dimensions, hull/deck assembly drawings and shell developments,
transom/motor-well drawings, hatch and embossed-deck drawings, and cabin drawings.
The serial year or revision should be specified.
