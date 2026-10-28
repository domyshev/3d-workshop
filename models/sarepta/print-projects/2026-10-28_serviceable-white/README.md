# Sarepta corrected white filament project — 2026-10-28

The prior project incorrectly used grey Generic PLA. This correction restores
the owner's first white filament from `stl_exports/2026-08-10_super_cube_good.3mf`:
Polymaker PolyTerra PLA @BBL A1M, white #FFFFFF. Complete resolved filament
settings are saved inside `Metadata/project_settings.config`; a user-defined
preset on this Mac is not needed to reproduce its material parameters.

The known white template uses 220 C nozzle, 65 C textured bed, flow ratio 0.98,
22 mm3/s maximum volumetric speed and 1.31 g/cm3 density. These are preserved
settings, not a newly tuned filament profile. Re-slicing updates the actual
G-code and both plate thumbnails. No manual recolouring of the old G-code.

Process and geometry remain unchanged: 0.16 mm, three walls, 15% Grid, eight
objects on two plates, supports on hull/cover only. All eight mesh XML contents
and instance transforms are byte-for-byte identical to the prior project.
Both plates include every object and fit the bed. Estimates are 3 h 53 min 5 s
and 53.77 g for the hull, 53 min 4 s and 19.93 g for the cover/small parts;
total 4 h 46 min 9 s and 73.70 g. The mass increase is primarily the saved
PolyTerra density; no infill increase was made. Physical fit remains untested.

The corrected file supersedes the grey project at the existing download URL.
The original archived project is retained for history. Open this complete 3MF
as a project rather than importing only its geometry. Physical printer/AMS
spool selection is still performed in the print dialog on the user's Mac.
