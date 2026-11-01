"""Check actual split meshes, glue-face equality, fixed hardware and unchanged exterior."""
from pathlib import Path
import sys,json,math
r=Path(__file__).resolve().parent
sys.path.insert(0,str(r.parents[1]/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
axes=json.loads((r/'joint-axes.json').read_text());profile=json.loads((r/'section-profile.json').read_text())['profile_yz_mm']
parent=r.parent/'2026-11-01_front-skirt-sockets'
base={p:list(triangles(parent/f'2026-11-01_sarepta_170mm_front_skirt_{p}.stl')) for p in ['lower','upper']}
fail=[];count=0;all_reports={}
def unique(values):
 out=[]
 for v in sorted(values):
  if not out or abs(v-out[-1])>1e-5:out.append(v)
 return out

def xhits(ts,y,z):
 out=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in ts:
  dy,dz,ey,ez=by-ay,bz-az,cy-ay,cz-az;det=dy*ez-ey*dz
  if abs(det)<1e-12:continue
  a=((y-ay)*ez-ey*(z-az))/det;b=(dy*(z-az)-(y-ay)*dz)/det
  if a>=-1e-9 and b>=-1e-9 and a+b<=1+1e-9:out.append(ax+a*(bx-ax)+b*(cx-ax))
 return unique(out)
def subset_yz(ts,y,z,radius=3.4):return [t for t in ts if min(v[1] for v in t)<=y+radius and max(v[1] for v in t)>=y-radius and min(v[2] for v in t)<=z+radius and max(v[2] for v in t)>=z-radius]
def yzray(ts,x,q,along_y=True):
 out=[]
 for t in ts:
  a,b,c=t
  if not min(v[0] for v in t)<=x<=max(v[0] for v in t):continue
  k=2 if along_y else 1;v=1 if along_y else 2
  dx,dq,ex,eq=b[0]-a[0],b[k]-a[k],c[0]-a[0],c[k]-a[k];det=dx*eq-ex*dq
  if abs(det)<1e-12:continue
  u=((x-a[0])*eq-ex*(q-a[k]))/det;w=(dx*(q-a[k])-(x-a[0])*dq)/det
  if u>=-1e-9 and w>=-1e-9 and u+w<=1+1e-9:out.append(a[v]+u*(b[v]-a[v])+w*(c[v]-a[v]))
 return unique(out)
def cap_area(ts,cut):
 total=0;faces=0
 for t in ts:
  if all(abs(v[0]-cut)<1e-5 for v in t):
   a,b,c=t;total+=abs((b[1]-a[1])*(c[2]-a[2])-(b[2]-a[2])*(c[1]-a[1]))/2;faces+=1
 return total,faces
