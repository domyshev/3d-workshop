"""Rebuild the two coherent normal-offset cutter solids from archived belt rings."""
from pathlib import Path
import json,math
r=Path(__file__).resolve().parent
rings=json.loads((r.parent/'2026-10-31_level-stern-ribs/belt-guides.json').read_text())['rings']
n=len(rings[0])
for name,offset in [('clearance',.12),('interface',-.03)]:
 points=[]
 for ring in rings:
  for i,p in enumerate(ring):
   a=ring[i-1];b=ring[(i+1)%n];u=[p[0]-a[0],p[1]-a[1]];v=[b[0]-p[0],b[1]-p[1]]
   lu=math.hypot(*u);lv=math.hypot(*v);na=[u[1]/lu,-u[0]/lu];nb=[v[1]/lv,-v[0]/lv]
   den=1+sum(na[k]*nb[k] for k in range(2))
   delta=[-offset*(na[k]+nb[k])/den for k in range(2)]
   points.append([p[0]+delta[0],p[1]+delta[1],p[2]])
 faces=[]
 for j in range(len(rings)-1):
  for i in range(n):
   k=(i+1)%n;a=j*n+i;b=j*n+k;c=(j+1)*n+k;d=(j+1)*n+i
   faces.extend([[a,b,c],[a,c,d]])
 for j,reverse in [(0,True),(len(rings)-1,False)]:
  c=len(points);points.append([sum(q[k] for q in rings[j])/n for k in range(3)])
  for i in range(n):
   a=j*n+i;b=j*n+(i+1)%n;faces.append([c,b,a] if reverse else [c,a,b])
 volume=sum(sum(points[a][k]*(points[b][(k+1)%3]*points[c][(k+2)%3]-points[b][(k+2)%3]*points[c][(k+1)%3]) for k in range(3))/6 for a,b,c in faces)
 if volume>0:faces=[f[::-1] for f in faces]
 (r/f'{name}.scad').write_text(f'// Shared guide surface with a {offset:g} mm plan-normal offset.\nmodule {name}_blank(){{polyhedron(points='+json.dumps(points,separators=(',',':'))+',faces='+json.dumps(faces,separators=(',',':'))+',convexity=40);}\n')
