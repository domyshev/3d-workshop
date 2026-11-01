"""Finite material and fit probes on the actual exported detachable-rim meshes."""
import json,math,sys
from pathlib import Path
r=Path(__file__).resolve().parent
sys.path.insert(0,str(r.parents[1]/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
parts=['lower','upper','pin','rim_bow','rim_port','rim_starboard','rim_pin']
files={p:r/f'2026-10-31_sarepta_170mm_detachable_{p}.stl' for p in parts}
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
insertions=[];gaps=[]
for x,y,z,outside in axes:
 for side in [-1,1]:
  rim='rim_bow' if x<58 else ('rim_starboard' if side>0 else 'rim_port')
  material('lower',x,side*(y-.45),z,False,'socket centre clear')
  material('lower',x,side*(y-1.01),z,True,'blind socket end wall')
  material(rim,x,side*(outside-.2),z,False,'rim through-bore clear')
  for a in [i*math.pi/4 for i in range(8)]:
   material('lower',x+.47*math.cos(a),side*(y-.45),z+.47*math.sin(a),False,'1 mm hull socket radius')
   material('lower',x+.55*math.cos(a),side*(y-.45),z+.55*math.sin(a),True,'material around socket')
   material(rim,x+.47*math.cos(a),side*(outside-.2),z+.47*math.sin(a),False,'1 mm rim bore radius')
  insertion=(y-.03)-(outside-2.58);insertions.append(insertion)
  if not .5<insertion<.95:fail.append(['pin insertion outside blind pocket',x,insertion])
  # Measure the actual body-to-rim separation away from each circular bore.
  h=hits('lower',x+1.1,z);k=hits(rim,x+1.1,z)
  if side>0:gaps.append(min(v for v in k if v>0)-max(h))
  else:gaps.append(min(h)-max(v for v in k if v<0))
# The old inward projection below the bow board is gone on both sides.
for x,y in [(7,1.35),(12,13.17),(20.9,20.7),(35,22.2)]:
 seam=670*170/4600-120*x/4600
 for side in [-1,1]:material('lower',x,side*y,seam-.45,False,'hanging inner bow return removed')
# The untouched upper and its original four glue locators remain byte-identical.
parent=r.parent/'2026-10-31_clean-bow-floor'
for p in ['upper','pin']:
 if files[p].read_bytes()!=(parent/f'2026-10-31_sarepta_170mm_clean_bow_{p}.stl').read_bytes():fail.append(['unchanged parent component differs',p])
metrics={p:inspect(f) for p,f in files.items()}
reg=json.loads((r/'regression.json').read_text())
report=dict(mesh=metrics,material_probes=count,failures=fail,locator_count=14,locator_diameter_mm=.8,bore_diameter_mm=1.0,blind_socket_depth_mm=.95,measured_lateral_gaps_mm=gaps,pin_insertions_mm=insertions,regression_pass=reg['checks_pass'],limits='Finite samples and topology checks; physical print, fit, flexural strength and watertightness are untested.')
report['checks_pass']=not fail and min(gaps)>.13 and max(gaps)<.2 and reg['checks_pass'] and all(m['basic_mesh_checks_pass'] for m in metrics.values())
(r/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='mesh'},indent=2))
assert report['checks_pass']
