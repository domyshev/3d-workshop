"""Check actual top-entry blind bores, their solid support and unchanged neighbours."""
from pathlib import Path
import json,math,sys
r=Path(__file__).resolve().parent
sys.path.insert(0,str(r.parents[1]/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
upper=r/'2026-11-01_sarepta_170mm_hinge_upper.stl';old=r.parent/'2026-11-01_fair-bow-root/2026-11-01_sarepta_170mm_fair_root_upper.stl'
meshes={'new':list(triangles(upper)),'old':list(triangles(old))};cache={}
def subset(part,x):
 key=(part,x)
 if key not in cache:cache[key]=[t for t in meshes[part] if min(v[0] for v in t)<=x<=max(v[0] for v in t)]
 return cache[key]
def unique(vs):
 out=[]
 for v in sorted(vs):
  if not out or abs(v-out[-1])>1e-5:out.append(v)
 return out

def zray(part,x,y):
 zs=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in subset(part,x):
  dx,dy,ex,ey=bx-ax,by-ay,cx-ax,cy-ay;det=dx*ey-ex*dy
  if abs(det)<1e-12:continue
  u=((x-ax)*ey-ex*(y-ay))/det;v=(dx*(y-ay)-(x-ax)*dy)/det
  if u>=-1e-9 and v>=-1e-9 and u+v<=1+1e-9:zs.append(az+u*(bz-az)+v*(cz-az))
 return unique(zs)
def yray(x,z):
 ys=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in subset('new',x):
  dx,dz,ex,ez=bx-ax,bz-az,cx-ax,cz-az;det=dx*ez-ex*dz
  if abs(det)<1e-12:continue
  u=((x-ax)*ez-ex*(z-az))/det;v=(dx*(z-az)-(x-ax)*dz)/det
  if u>=-1e-9 and v>=-1e-9 and u+v<=1+1e-9:ys.append(ay+u*(by-ay)+v*(cy-ay))
 return unique(ys)
fail=[];count=0
roof=750*170/4600+2.4;top=roof+12.5*170/4600;bottom=top-3.2;floor=bottom+.4
measurements=[]
def check(x,y,z,want,label):
 global count
 count+=1;hits=zray('new',x+1.3e-6,y+2.7e-6)
 got=bool(sum(v<z+3.1e-6 for v in hits)%2)
 if got!=want:fail.append([label,[x,y,z],want])
for y in [-5,5]:
 x=32.2
 for z in [floor+.05,28.2,29.5,top-.05]:
  check(x,y,z,False,'blind bore clear to the top')
  for i in range(12):
   a=2*math.pi*i/12;check(x+.95*math.cos(a),y+.95*math.sin(a),z,False,'2 mm bore radius')
 for z in [bottom+.05,floor-.05]:
  check(x,y,z,True,'solid blind bottom')
  for i in range(12):
   a=2*math.pi*i/12;check(x+.95*math.cos(a),y+.95*math.sin(a),z,True,'blind floor under entire bore')
 for i in range(24):
  a=2*math.pi*i/24
  for rad in [1.1,2.1]:check(x+rad*math.cos(a),y+rad*math.sin(a),28.5,True,'continuous solid reinforcement ring')
  check(x+2.3*math.cos(a),y+2.3*math.sin(a),28.5,False,'reinforcement stays local')
 check(x,y,bottom-.05,False,'blind boss underside not pierced')
 check(36,y,29.7,False,'hatch opening preserved')
 check(34.7,y,29.7,True,'roof bridge before hatch retained')
 zs=zray('new',x+1.3e-6,y+2.7e-6);side=zray('new',x+1.1,y)
 yy=yray(x,28.5);bore_low=max(v for v in yy if v<y);bore_high=min(v for v in yy if v>y)
 measurements.append({'axis_mm':[x,y],'floor_mm':zs[-1],'boss_bottom_mm':zs[0],'bottom_skin_mm':zs[-1]-zs[0],'depth_from_top_mm':side[-1]-zs[-1],'diameter_y_mm':bore_high-bore_low})
unchanged=[]
for x in [15.13,24.13,30.13,32.2,36.13,40.13,52.13,58.13,90.13,145.13,169.13]:
 for y in [-24.13,-18.13,-10.23,0.13,10.23,18.13,24.13]:
  a=zray('new',x,y);b=zray('old',x,y)
  if len(a)!=len(b):fail.append(['unchanged sample changed intersection count',x,y])
  elif a:unchanged.extend(abs(u-v) for u,v in zip(a,b))
unchanged_parts=[]
for part in ['lower','pin','rim_bow','rim_port','rim_starboard','rim_pin']:
 a=r/f'2026-11-01_sarepta_170mm_hinge_{part}.stl';b=r.parent/f'2026-11-01_fair-bow-root/2026-11-01_sarepta_170mm_fair_root_{part}.stl'
 if a.read_bytes()!=b.read_bytes():fail.append(['unchanged component differs',part])
 unchanged_parts.append(part)
metrics=inspect(upper)
passed=not fail and metrics['basic_mesh_checks_pass'] and max(unchanged)<.0001 and all(abs(v['bottom_skin_mm']-.4)<.0001 and abs(v['depth_from_top_mm']-2.8)<.0001 and abs(v['diameter_y_mm']-2)<.0001 for v in measurements)
report=dict(checks_pass=passed,material_probes=count,failures=fail,hinge_socket_measurements=measurements,unchanged_surface_samples=len(unchanged),max_unchanged_surface_difference_mm=max(unchanged),byte_identical_parts=unchanged_parts,upper_mesh=metrics,limits='Finite geometry and topology checks. No hinge assembly or physical print fit has been tested.')
(r/'verification.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({k:v for k,v in report.items() if k!='upper_mesh'},indent=2));assert passed
