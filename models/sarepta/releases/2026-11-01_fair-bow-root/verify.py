"""Finite material and fit probes on the actual exported detachable-rim meshes."""
import json,math,sys
from pathlib import Path
r=Path(__file__).resolve().parent
sys.path.insert(0,str(r.parents[1]/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
parts=['lower','upper','pin','rim_bow','rim_port','rim_starboard','rim_pin']
files={p:r/f'2026-11-01_sarepta_170mm_fair_root_{p}.stl' for p in parts}
mesh={p:list(triangles(f)) for p,f in files.items()}
def hits(part,x,z):
 out=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in mesh[part]:
  if x<min(ax,bx,cx) or x>max(ax,bx,cx):continue
  dx,dz,ex,ez=bx-ax,bz-az,cx-ax,cz-az;det=dx*ez-ex*dz
  if abs(det)<1e-12:continue
  u=((x-ax)*ez-ex*(z-az))/det;v=(dx*(z-az)-(x-ax)*dz)/det
  if u>=-1e-9 and v>=-1e-9 and u+v<=1+1e-9:out.append(ay+u*(by-ay)+v*(cy-ay))
 uniq=[]
 for v in sorted(out):
  if not uniq or abs(v-uniq[-1])>1e-5:uniq.append(v)
 return uniq
count=0;fail=[]
def material(part,x,y,z,want,label):
 global count
 count+=1
 result=bool(sum(v<y for v in hits(part,x+1.3e-6,z+3.1e-6))%2)
 if result!=want:fail.append([label,part,[x,y,z],want])
axes=json.loads((r/'locator-axes.scad').read_text().split('=',1)[1].strip().rstrip(';'))
insertions=[];gaps=[];body_walls=[];skirt_walls=[]
for x,y,z,outside in axes:
 for side in [-1,1]:
  rim='rim_bow' if x<58 else ('rim_starboard' if side>0 else 'rim_port')
  material('lower',x,side*(y-.45),z,False,'socket centre clear')
  material('lower',x,side*(y-1.01),z,True,'blind socket end wall')
  material(rim,x,side*(outside-.2),z,True,'solid outer skirt behind blind pocket')
  material(rim,x,side*(y+.45),z,False,'hidden rim socket centre clear')
  for a in [i*math.pi/4 for i in range(8)]:
   material('lower',x+.47*math.cos(a),side*(y-.45),z+.47*math.sin(a),False,'1 mm hull socket radius')
   material('lower',x+.55*math.cos(a),side*(y-.45),z+.55*math.sin(a),True,'material around socket')
   material(rim,x+.47*math.cos(a),side*(y+.45),z+.47*math.sin(a),False,'1 mm hidden rim socket radius')
  body_insertion=.675;skirt_insertion=.675
  insertions.append([body_insertion,skirt_insertion])
  # Both tip ends have axial clearance before each blind pocket bottom.
  material('lower',x,side*(y-.705),z,False,'pin inner tip remains in blind body socket')
  material(rim,x,side*(y+.795),z,False,'pin outer tip remains in blind skirt socket')
  material(rim,x,side*(y+1.0),z,True,'solid skirt socket end wall')
  body_hits=[v for v in hits('lower',x+1.3e-6,z+3.1e-6) if v>0]
  rim_hits=[v for v in hits(rim,x+1.3e-6,z+3.1e-6) if v>0] if side>0 else [-v for v in hits(rim,x+1.3e-6,z+3.1e-6) if v<0][::-1]
  body_walls.append(body_hits[-1]-body_hits[-2]);skirt_walls.append(rim_hits[-1]-rim_hits[-2])
  # Measure the actual body-to-rim separation away from each circular bore.
  h=hits('lower',x+1.1,z);k=hits(rim,x+1.1,z)
  if side>0:gaps.append(min(v for v in k if v>0)-max(h))
  else:gaps.append(min(h)-max(v for v in k if v<0))
# All sampled material removed by the old bow cutter is restored.
closure=json.loads((r/'bow-closure-probes.json').read_text())['points_mm']
assert len(closure)>=20
for x,y,z in closure:material('lower',x,y,z,True,'former triangular bow opening closed')
# The old separate ledge was exposed here; the new taper leaves open interior.
former=list(triangles(r.parent/'2026-10-31_blind-rim-closed-bow/2026-10-31_sarepta_170mm_blind_rim_lower.stl'))
mesh['former']=former
for x in [45,53,57.8]:
 z=670*170/4600-120*x/4600-.8
 for side in [-1,1]:
  material('former',x,side*24,z,True,'reference formerly exposed rectangular ledge')
  material('lower',x,side*24,z,False,'separate lower ledge removed')
# On either side of the former end the shell has the same sampled cross section.
for x in [57.8,58.2,59.2]:
 z=670*170/4600-120*x/4600-.8
 for side in [-1,1]:
  material('lower',x,side*26.4,z,False,'no projecting rectangular end')
  material('lower',x,side*27.0,z,True,'continuous original plating at old end')
# The untouched upper and its original four glue locators remain byte-identical.
parent=r.parent/'2026-10-31_clean-bow-floor'
for p in ['upper','pin']:
 if files[p].read_bytes()!=(parent/f'2026-10-31_sarepta_170mm_clean_bow_{p}.stl').read_bytes():fail.append(['unchanged parent component differs',p])
for part in ['rim_bow','rim_port','rim_starboard','rim_pin']:
 old=r.parent/f'2026-10-31_blind-rim-closed-bow/2026-10-31_sarepta_170mm_blind_rim_{part}.stl'
 if files[part].read_bytes()!=old.read_bytes():fail.append(['unchanged skirt component differs',part])
metrics={p:inspect(f) for p,f in files.items()}
reg=json.loads((r/'regression.json').read_text())
report=dict(mesh=metrics,material_probes=count,failures=fail,bow_closure_probes=len(closure),locator_count=14,locator_diameter_mm=.8,pin_length_mm=1.5,skirt_blind_socket_depth_mm=.8,bore_diameter_mm=1.0,blind_socket_depth_mm=.95,measured_lateral_gaps_mm=gaps,nominal_pin_insertions_mm=insertions,body_socket_end_walls_mm=body_walls,skirt_socket_end_walls_mm=skirt_walls,regression_pass=reg['checks_pass'],limits='Finite samples and topology checks; physical print, fit, flexural strength and watertightness are untested.')
assert max(abs(a-b) for a,b in zip(metrics['rim_pin']['size_mm'],[.8,.8,1.5]))<1e-5
report['checks_pass']=min(body_walls)>.2 and min(skirt_walls)>.7 and not fail and min(gaps)>.13 and max(gaps)<.2 and reg['checks_pass'] and all(m['basic_mesh_checks_pass'] for m in metrics.values())
(r/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='mesh'},indent=2))
assert report['checks_pass']
