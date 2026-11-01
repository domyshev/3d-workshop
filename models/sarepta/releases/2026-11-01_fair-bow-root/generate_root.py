"""Sweep one fair inner transition and fade its projection into the original wall."""
from pathlib import Path
import math,json,bisect
r=Path(__file__).resolve().parent
data=json.loads((r.parent/'2026-10-31_level-stern-ribs/belt-guides.json').read_text());rings=data['rings'];levels=data['levels'];n=len(rings[0])
join=rings[levels.index(25)]
def smooth(t):
 t=max(0,min(1,t));return t*t*t*(10-15*t+6*t*t)
def offset(ring,d):
 out=[]
 for i,p in enumerate(ring):
  a=ring[i-1];b=ring[(i+1)%n];u=[p[0]-a[0],p[1]-a[1]];v=[b[0]-p[0],b[1]-p[1]]
  lu=math.hypot(*u);lv=math.hypot(*v);na=[u[1]/lu,-u[0]/lu];nb=[v[1]/lv,-v[0]/lv];den=1+sum(na[k]*nb[k] for k in range(2))
  out.append([p[k]+d*(na[k]+nb[k])/den for k in range(2)])
 return out
landing=offset(join,3.98);loops=[];outer=[];inner=[];samples=[]
for k in range(41):
 u=k/40;row=[];zs=[]
 for i,q in enumerate(join):
  bottom=670*170/4600-120*q[0]/4600-1.18;top=max(23.39,bottom+.1);z=bottom+(top-bottom)*u;zs.append(z)
  j=min(len(levels)-2,max(0,bisect.bisect_right(levels,z)-1));t=(z-levels[j])/(levels[j+1]-levels[j])
  row.append([rings[j][i][a]*(1-t)+rings[j+1][i][a]*t for a in range(2)])
 os=offset(row,.12);ws=offset(row,1.0)
 for i,q in enumerate(row):
  fade=1-smooth((q[0]-18)/40);v=smooth(u)*fade
  outer.append([*os[i],zs[i]]);inner.append([ws[i][a]*(1-v)+landing[i][a]*v for a in range(2)]+[zs[i]])
 samples.append({'u':u,'blend':smooth(u)})
points=outer+inner;m=41;shift=m*n;faces=[]
for k in range(m-1):
 for i in range(n):
  j=(i+1)%n;a=k*n+i;b=k*n+j;c=(k+1)*n+j;d=(k+1)*n+i
  faces.extend([[a,b,c],[a,c,d],[shift+a,shift+c,shift+b],[shift+a,shift+d,shift+c]])
for k in [0,m-1]:
 for i in range(n):
  j=(i+1)%n;a=k*n+i;b=k*n+j;c=shift+b;d=shift+a
  faces.extend([[a,d,c],[a,c,b]] if k==0 else [[a,b,c],[a,c,d]])
volume=sum(sum(points[a][k]*(points[b][(k+1)%3]*points[c][(k+2)%3]-points[b][(k+2)%3]*points[c][(k+1)%3]) for k in range(3))/6 for a,b,c in faces)
if volume>0:faces=[f[::-1] for f in faces]
(r/'fair-root.scad').write_text('// A single continuous swept transition; all dimensions are model mm.\nmodule fair_root_blank(){polyhedron(points='+json.dumps(points,separators=(',',':'))+',faces='+json.dumps(faces,separators=(',',':'))+',convexity=40);}\n')
(r/'root-guides.json').write_text(json.dumps({'landing_z_mm':23.35,'top_overlap_mm':.04,'fade_start_x_mm':18,'fade_end_x_mm':58,'profile':'quintic smoothstep in height and along X','samples':samples},indent=2)+'\n')
print('Generated',len(points),'points,',len(faces),'triangles')
