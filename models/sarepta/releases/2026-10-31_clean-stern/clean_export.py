#!/usr/bin/env python3
"""Remove zero-area export facets and split exact collinear T junctions.

No vertices are moved, no open holes are filled, no components are removed.
A split replaces one triangle by two with the exact same planar surface.
"""
import sys,json,struct,collections
from pathlib import Path
project=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(project/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
src,dst,log=map(Path,sys.argv[1:])
def cross(a,b):return (a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0])
def sub(a,b):return tuple(a[i]-b[i] for i in range(3))
def volume(ts):return sum(sum(t[0][i]*cross(t[1],t[2])[i] for i in range(3))/6 for t in ts)
raw=list(triangles(src));ts=[t for t in raw if any(cross(sub(t[1],t[0]),sub(t[2],t[0])))];before=volume(ts);splits=0
for iteration in range(100):
 edges=collections.defaultdict(list)
 for idx,t in enumerate(ts):
  for j in range(3):edges[tuple(sorted((t[j],t[(j+1)%3])))].append((idx,j))
 boundary={e:v for e,v in edges.items() if len(v)==1}
 if not boundary:break
 vertices=set(v for e in boundary for v in e);replacement=None
 for (a,b),[(idx,j)] in boundary.items():
  ab=sub(b,a);axis=max(range(3),key=lambda k:abs(ab[k]))
  for c in vertices:
   if c==a or c==b:continue
   ac=sub(c,a);t=ac[axis]/ab[axis]
   if 0<t<1 and not any(cross(ab,ac)):
    original=ts[idx];u,v,w=original[j],original[(j+1)%3],original[(j+2)%3]
    replacement=(idx,(u,c,w),(c,v,w));break
  if replacement:break
 if not replacement:break
 idx,t1,t2=replacement;ts[idx]=t1;ts.append(t2);splits+=1
out=bytearray(b'Sarepta exact surface-preserving export refinement'.ljust(80,b' '));out.extend(struct.pack('<I',len(ts)))
for t in ts:out.extend(struct.pack('<12fH',0,0,0,*(v for p in t for v in p),0))
dst.write_bytes(out);check=inspect(dst);after=volume(ts)
assert check['basic_mesh_checks_pass'],check
assert abs(after-before)<1e-7,(before,after)
log.write_text(json.dumps(dict(zero_area_facets_removed=len(raw)-(len(ts)-splits),exact_collinear_triangle_splits=splits,vertices_moved=0,holes_filled=0,components_removed=0,volume_change_mm3=after-before,basic_mesh_checks_pass=True),indent=2)+'\n')
print(log.read_text())
