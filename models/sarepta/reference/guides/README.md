# Hull-modelling guides and what actually helped

## Used: McNeel boat hull tutorial

[Official guide](https://docs.mcneel.com/rhino/6/usersguide/en-us/html/ch-16_boathull.htm)
by Robert McNeel & Associates. Preserved [offline HTML](rhino-boat-hull/offline.html),
[readable text](rhino-boat-hull/text.txt), original HTML and illustration assets.

The useful method was to simplify guides, inspect curvature in plan and profile,
then construct surfaces from those guides. This helped replace local bow patches
with three independently controlled smooth profiles. We adapted the method to
OpenSCAD; the tutorial does not specify Sarepta hull geometry or certify our fit.

## Reviewed, not adopted: naval-architect role

[External role](https://github.com/wonsukchoi/domain-experts/blob/main/roles/marine-engineer-naval-architect/SKILL.md)
by Wonsuk Choi and Domain Experts contributors; [preserved text](naval-architect-role/original.txt)
and [MIT notice](naval-architect-license/original.txt). It focuses on stability,
freeboard, displacement and powering. It was not installed and did not provide
the successful surface-fairing workflow. Do not automatically invoke it for a
printable scale-model edit.

## Original project method

The [project-local skill](../../skills/boat-hull-reconstruction/SKILL.md) combines
the useful curve-first principle with lessons demonstrated by our iterations:
separate triple-bow guides, curvature-sign checks, a continuous deck above the
tunnels, normal offsets for the rim, protected internal cavities, dimensional
datums, and direct mesh previews. These implementation details are our adaptation,
not quotations or prescribed steps from McNeel.
