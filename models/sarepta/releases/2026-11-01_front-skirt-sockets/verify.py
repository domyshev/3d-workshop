"""Inspect both actual front pocket meshes in each shared pin coordinate frame."""
from pathlib import Path
import json,math,sys
r=Path(__file__).resolve().parent
sys.path.insert(0,str(r.parents[1]/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
config=json.loads((r/'front-axes.json').read_text());axes=config['axes']
files={k:r/f'2026-11-01_sarepta_170mm_front_skirt_{k}.stl' for k in ['lower','rim_bow']}
meshes={k:list(triangles(p)) for k,p in files.items()};projected={}
def frame(part,i):
 key=(part,i)
 if key not in projected:
  x,y,z,nx,ny,nz=axes[i];ts=[]
  for t in meshes[part]:
   vs=[[-ny*(v[0]-x)+nx*(v[1]-y),v[2]-z,nx*(v[0]-x)+ny*(v[1]-y)] for v in t]
   if min(v[0] for v in vs)<=1 and max(v[0] for v in vs)>=-1 and min(v[1] for v in vs)<=1 and max(v[1] for v in vs)>=-1:ts.append(vs)
  projected[key]=ts
 return projected[key]
def ray(part,i,u=0,v=0):
 hits=[]
 for (au,av,ad),(bu,bv,bd),(cu,cv,cd) in frame(part,i):
  du,dv,eu,ev=bu-au,bv-av,cu-au,cv-av;det=du*ev-eu*dv
  if abs(det)<1e-12:continue
  a=((u-au)*ev-eu*(v-av))/det;b=(du*(v-av)-(u-au)*dv)/det
  if a>=-1e-9 and b>=-1e-9 and a+b<=1+1e-9:hits.append(ad+a*(bd-ad)+b*(cd-ad))
 out=[]
 for d in sorted(hits):
  if not out or abs(d-out[-1])>1e-5:out.append(d)
 return out
count=0;fail=[]
def check(part,i,d,want,label,u=0,v=0):
 global count
 count+=1;got=bool(sum(h<d for h in ray(part,i,u+1.3e-6,v+2.7e-6))%2)
 if got!=want:fail.append([label,part,i,[u,v,d],want])
measurements=[]
for i,p in enumerate(axes):
 for d in [-.7,-.4,-.04]:
  check('lower',i,d,False,'front hull pocket centre clear')
  for j in range(16):
   a=2*math.pi*j/16;check('lower',i,d,False,'1 mm hull bore clear',.47*math.cos(a),.47*math.sin(a))
 for d in [.045,.13,.4,.79]:
  check('rim_bow',i,d,False,'matching hidden front skirt pocket clear')
  for j in range(16):
   a=2*math.pi*j/16;check('rim_bow',i,d,False,'1 mm skirt bore clear',.47*math.cos(a),.47*math.sin(a))
 for j in range(16):
  a=2*math.pi*j/16;u=.53*math.cos(a);v=.53*math.sin(a)
  check('lower',i,-.4,True,'material around body aperture',u,v)
  check('rim_bow',i,.4,True,'material around skirt aperture',u,v)
  u=.45*math.cos(a);v=.45*math.sin(a)
  check('lower',i,-1.03,True,'blind hull end wall covers complete bore',u,v)
  check('rim_bow',i,.98,True,'blind skirt end wall covers complete bore',u,v)
 body=ray('lower',i);skirt=ray('rim_bow',i)
 closest=max(d for d in body if d<0);skirtfloor=min(d for d in skirt if d>0)
 body_inside=max(d for d in body if d<closest-1e-5);skirt_outside=min(d for d in skirt if d>skirtfloor+1e-5)
 measurements.append(dict(axis=p,body_blind_floor_d_mm=closest,skirt_blind_floor_d_mm=skirtfloor,body_end_wall_mm=closest-body_inside,skirt_end_wall_mm=skirt_outside-skirtfloor,pin_inner_tip_d_mm=-.705,pin_outer_tip_d_mm=.795))
 if not abs(closest+.98)<1e-4 or not abs(skirtfloor-.92)<1e-4:fail.append(['misaligned blind pocket end',i,closest,skirtfloor])
# Other components, including the hatch-hinge sockets and headless pin, are unchanged.
unchanged=[]
for part in ['upper','pin','rim_port','rim_starboard','rim_pin']:
 a=r/f'2026-11-01_sarepta_170mm_front_skirt_{part}.stl';b=r.parent/f'2026-11-01_hatch-hinge-sockets/2026-11-01_sarepta_170mm_hinge_{part}.stl'
 if a.read_bytes()!=b.read_bytes():fail.append(['unchanged component differs',part])
 unchanged.append(part)
# The repaired bow cap must remain closed away from the four intended pockets.
closure=json.loads((r.parent/'2026-11-01_fair-bow-root/bow-closure-probes.json').read_text())['points_mm']
for x,y,z in closure:
 count+=1;ys=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in meshes['lower']:
  if not min(ax,bx,cx)<=x<=max(ax,bx,cx):continue
  dx,dz,ex,ez=bx-ax,bz-az,cx-ax,cz-az;det=dx*ez-ex*dz
  if abs(det)<1e-12:continue
  u=((x-ax)*ez-ex*(z-az))/det;v=(dx*(z-az)-(x-ax)*dz)/det
  if u>=-1e-9 and v>=-1e-9 and u+v<=1+1e-9:ys.append(ay+u*(by-ay)+v*(cy-ay))
 uniq=[]
 for yy in sorted(ys):
  if not uniq or abs(yy-uniq[-1])>1e-5:uniq.append(yy)
 if not sum(yy<y for yy in uniq)%2:fail.append(['previous bow closure lost',[x,y,z]])
# All original paired side bores and closure geometry remain outside the new cut envelopes.
metrics={part:inspect(p) for part,p in files.items()}
passed=not fail and all(m['basic_mesh_checks_pass'] for m in metrics.values()) and min(m['body_end_wall_mm'] for m in measurements)>.3 and min(m['skirt_end_wall_mm'] for m in measurements)>.7
report=dict(checks_pass=passed,front_pin_count=4,total_skirt_pin_count=18,bow_closure_probes=len(closure),material_probes=count,failures=fail,front_pocket_measurements=measurements,byte_identical_components=unchanged,mesh=metrics,limits='Finite material and topology checks; physical pin/assembly fit and print strength are untested.')
(r/'verification.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({k:v for k,v in report.items() if k!='mesh'},indent=2));assert passed
