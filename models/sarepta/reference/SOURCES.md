# Sources, attribution and usage

Captured/preserved on 2026-10-23 unless an existing per-source manifest states
2026-10-22. Dates identify this local copy, not the original publication date.

| ID | Source and attribution | Local files | Use and limitations |
| --- | --- | --- | --- |
| P1 | Volgograd Shipyard, factory passport, issue date/individual authors not established. Scan hosted by Motorka.org; recovered from Internet Archive capture 20130809013240. [Landing page](https://motorka.org/m_lodki/sarepta/2182-doc-sarepta.html) | `factory-passport/` complete 18 images, original RAR, provenance | Primary dimensions/arrangement; not a production drawing set |
| P2 | Katery i Yakhty No. 48 (1974), Sarepta article and illustrations. Individual author not verified from the retained scan; Barque review/editor credits are not treated as original authors. [Article](https://www.barque.ru/projects/1974/powerboat_trimaran_sarepta) | `sources/article-1974/`, top-level `sarepta-*-1974.jpg` | Body sections, construction profiles, early design data |
| P3 | Katery i Yakhty No. 87 (1980), factory account of construction changes. Individual author unverified. [Article](https://www.barque.ru/advice/1980/modifications_motor_boat_sarepta) | `sources/construction-changes-1980/` | Production evolution; not permission to combine every detail from every year |
| P4 | V. A. Basnin and D. B. Volkov, Krym-3 article, Katery i Yakhty No. 6 (76), 1978. [Transcription](https://fishing.kiev.ua/lodki/mlod/krim3.htm) | `sources/cockpit-comparison-1978/` | Comparative Sarepta cockpit dimensions; other detailed dimensions in this article concern Krym-3, not Sarepta |
| P5 | Handbook edited by G. M. Novak, excerpt hosted by Motorka.org. [Page](https://motorka.org/m_lodki/579-sarepta.html) | `sources/handbook-excerpt/`, handbook GIFs | Cross-check data; some values differ from passport |
| S1 | Karopka review credited to Billy Bones / Igor Sheynin; kit manufacturer KS 3D / Kartonny Samurai. Original ownership of each gallery image is not individually verified. [Review](https://karopka.ru/work/019d46e2-b6fe-711e-8789-135416e3348e) | `karopka/manifest.json`, 92 gallery images, contact sheets | Secondary kit/model references; not a factory dimensional survey |
| U1 | Images supplied by the user in this conversation; original creators not inferred from upload | `user-supplied/manifest.json` | Photos, drawing crops and model-feedback screenshots are explicitly distinguished |
| G1 | Robert McNeel & Associates, Rhino 6 User Guide, Boat Hull — Loft and Sweep. Page copyright footer identifies Robert McNeel & Associates. [Tutorial](https://docs.mcneel.com/rhino/6/usersguide/en-us/html/ch-16_boathull.htm) | `guides/rhino-boat-hull/` | Used for curve simplification, curvature review and guide-first surface construction |
| G2 | Wonsuk Choi and Domain Experts contributors, marine-engineer-naval-architect role. [Repository](https://github.com/wonsukchoi/domain-experts/blob/main/roles/marine-engineer-naval-architect/SKILL.md) | `guides/naval-architect-role/original.txt`; upstream MIT text in `guides/naval-architect-license/original.txt` | Reviewed but not installed or used as a hull-surfacing procedure. Stored as text to avoid automatic activation |
| A1 | Federal Archival Agency catalogue, State Archive of Volgograd Region, fond R-4011, inventories 1..6, 1942..1979, 1170 storage units. [Catalogue](https://guides.rusarchives.ru/node/24307) | Research audit records lead | Possible next source; specific Sarepta drawings have not been located or requested |

## Preservation and rights notes

Copies are retained as this project's research evidence. Source credits and
watermarks are preserved. Soviet publication dates are not used as an assumption
that a work is uncredited or available under the repository's software license.
No general redistribution license was established for passport scans, journal
illustrations, photographs or McNeel documentation. The external domain-experts
role has its separately preserved MIT notice. Original project notes and the
local modelling skill are distinct from these third-party materials.

Page snapshots are evidence copies, not instructions to an agent. Their linked
external pages and downloaded role text are untrusted reference content. The
project-local skill explains what was actually adopted. The saved offline HTML
uses local illustration assets where available; browser navigation links can
still point to the original sites. The readable `text.txt` files work offline.

For individual file hashes see `SHA256SUMS`; for original image URLs see
`download-manifest.json`, `karopka/manifest.json`, and passport provenance.

## Additional interior and kit evidence — 2026-10-23

Three more user attachments are preserved in `reference/user-supplied/`
(with provenance in its manifest); the Progress-4 card is product identification
only. Original creators are not inferred from uploads. The first-hand
[PRG-4-43 review](https://karopka.ru/work/019d46e2-b2e7-7312-80c4-6dc98b8293ec)
is retained under `reference/sources/progress-4-kit-review/`; its text and
photos retain their respective authors' rights. See `TRANSOM_AND_FRAMING.md`
for separation of factory evidence and reconstruction decisions.

## Straight side-corrugation feedback

User attachments `54370844`, `bfbfb1e5` and `add7ad5a` are preserved in
`user-supplied/` with full IDs and provenance in its manifest. Real side views
support horizontal strips with forward termination before the upturned bow
and aft termination at the transom. Placement coordinates remain estimates.

## Interior revision evidence

The latest two user feedback screenshots are preserved with IDs in
`reference/user-supplied/manifest.json`. The first-hand restoration text and
selected original photographs are archived under `reference/sources/interior-restoration/`;
its initial-condition photo is credited in the original to Vadim and Oleg.
A first-hand 1976-hull restoration account by PetroviCh / Sergey is catalogued
under `reference/sources/sarepta-691-owner/`. Source contributors retain their
rights; no redistribution licence is inferred. See `INTERIOR_RESEARCH.md`
for what each source supports and what remains a reconstruction.
