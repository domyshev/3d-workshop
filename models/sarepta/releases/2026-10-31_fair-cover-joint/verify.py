"""Check actual archived meshes: join continuity, side slope and wall samples."""
import sys, math, json
from pathlib import Path
p=Path(__file__).resolve().parent
project=p.parents[1]
sys.path.insert(0,str(project/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
files={part:p/f'2026-10-31_sarepta_170mm_fair_{part}.stl' for part in ['lower','upper']}
old=project/'releases/2026-10-31_lightweight-open-deck/2026-10-31_sarepta_170mm_light_lower.stl'
meshes={k:list(triangles(v)) for k,v in {**files,'old':old}.items()}
def subset(ts,x):return [t for t in ts if min(q[0] for q in t)<=x<=max(q[0] for q in t)]
def ray(ts,x,z):
 ys=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in ts:
  dx,dz,ex,ez=bx-ax,bz-az,cx-ax,cz-az;det=dx*ez-ex*dz
  if abs(det)<1e-12:continue
  u=((x-ax)*ez-ex*(z-az))/det;v=(dx*(z-az)-(x-ax)*dz)/det
  if u>=-1e-9 and v>=-1e-9 and u+v<=1+1e-9:ys.append(ay+u*(by-ay)+v*(cy-ay))
 ys=sorted(ys);out=[]
 for y in ys:
  if not out or abs(y-out[-1])>1e-5:out.append(y)
 return out
fail=[];joins=[];angles=[];walls=[];exterior=[]
for i in range(119):
 x=8.013+i*1.36
 s={k:subset(ts,x) for k,ts in meshes.items()}
 lower0=ray(s['lower'],x,24.989)[-1];lower1=ray(s['lower'],x,24.999)[-1]
 slope=(lower1-lower0)/.010
 upper0=ray(s['upper'],x,25.001)[-1];upper1=ray(s['upper'],x,25.401)[-1]
 joins.append(abs((upper0-(upper1-upper0)/.4*.001)-(lower1+slope*.001)))
 angles.append(abs(math.degrees(math.atan((upper1-upper0)/.4)-math.atan(slope))))
 for z in [25.21,26.31,27.71,28.81]:
  vals=[y for y in ray(s['upper'],x,z) if y>0]
  if not vals:fail.append(['missing side',x,z,vals]);continue
  # The outermost interval measures the wall before any internal voids.
  width=vals[-1]-(vals[-2] if len(vals)>1 else 0)
  walls.append(width)
  if width<.78:fail.append(['thin side',x,z,width])
 for z in [5.013,10.013,15.013,20.013,24.913]:
  a=ray(s['lower'],x,z);b=ray(s['old'],x,z)
  if a and b:
   exterior.extend([abs(a[0]-b[0]),abs(a[-1]-b[-1])])
for x,c in [(33,23.6),(160,24.4)]:
 s=subset(meshes['upper'],x)
 for z in [25.11,25.55,26.09]:
  vals=[y for y in ray(s,x,z) if y>0];w=vals[-1]-vals[-2]
  if w<.78:fail.append(['thin guide outer wall',x,z,w])
print('Worst angle:', sorted(zip(angles,[8.013+i*1.36 for i in range(119)]),reverse=True)[:8])
report={'mesh':{k:inspect(v) for k,v in files.items()},'join_samples':len(joins),'max_join_offset_mm':max(joins),'max_transverse_tangent_error_deg':max(angles),'side_wall_samples':len(walls),'minimum_sampled_horizontal_wall_mm':min(walls),'lower_exterior_comparisons':len(exterior),'max_lower_exterior_change_mm':max(exterior),'failures':fail,'limits':'Sampled geometry checks, not a global minimum-wall or physical-fit certification. Previous intentional protective rim remains on the lower hull.'}
report['checks_pass']=not fail and max(joins)<.01 and max(angles)<.2 and max(exterior)<.0001 and all(r['basic_mesh_checks_pass'] for r in report['mesh'].values())
(p/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='mesh'},indent=2))
assert report['checks_pass']
