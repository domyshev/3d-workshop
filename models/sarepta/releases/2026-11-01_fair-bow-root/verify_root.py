"""Check the actual old-end faces and the generator's taper endpoint conditions."""
from pathlib import Path
import sys,json,math
r=Path(__file__).resolve().parent
sys.path.insert(0,str(r.parents[1]/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles
files={'before':r.parent/'2026-10-31_blind-rim-closed-bow/2026-10-31_sarepta_170mm_blind_rim_lower.stl','after':r/'2026-11-01_sarepta_170mm_fair_root_lower.stl'}
results={}
for name,p in files.items():
 area=0;count=0
 for a,b,c in triangles(p):
  if not all(abs(v[0]-58)<1e-5 for v in [a,b,c]):continue
  if max(v[2] for v in [a,b,c])>=23.3:continue
  if min(abs(v[1]) for v in [a,b,c])>=26:continue
  u=[b[k]-a[k] for k in range(3)];v=[c[k]-a[k] for k in range(3)]
  cross=[u[(k+1)%3]*v[(k+2)%3]-u[(k+2)%3]*v[(k+1)%3] for k in range(3)]
  area+=math.sqrt(sum(q*q for q in cross))/2;count+=1
 results[name]={'exposed_x58_faces':count,'area_mm2':area}
assert results['before']['area_mm2']>.1,results
assert results['after']['exposed_x58_faces']==0,results
report={'old_end_face_comparison':results,'checks_pass':True,'limits':'Targeted end-face check on actual exported meshes; global surface fairness is assessed by rendered views and guide construction.'}
(r/'root-verification.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
