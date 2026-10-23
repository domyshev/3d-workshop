#!/usr/bin/env python3
"""Inspect a binary or ASCII STL in model units; no third-party dependencies."""
import argparse,collections,json,math,re,struct
from pathlib import Path

def triangles(path):
    data=Path(path).read_bytes()
    if len(data)>=84 and 84+50*struct.unpack_from('<I',data,80)[0]==len(data):
        for i in range(struct.unpack_from('<I',data,80)[0]):
            values=struct.unpack_from('<12fH',data,84+50*i)
            yield tuple(tuple(values[3+3*j:6+3*j]) for j in range(3))
    else:
        points=[tuple(map(float,m)) for m in re.findall(rb'\bvertex\s+([-+\deE.]+)\s+([-+\deE.]+)\s+([-+\deE.]+)',data)]
        if not points or len(points)%3:raise ValueError('Unrecognised or incomplete STL')
        yield from (tuple(points[i:i+3]) for i in range(0,len(points),3))

def inspect(path):
    points={};faces=[]
    for tri in triangles(path):
        face=[]
        for q in tri:
            if not all(math.isfinite(x) for x in q):raise ValueError('Non-finite vertex')
            if q not in points:points[q]=len(points)
            face.append(points[q])
        faces.append(face)
    vertices=list(points);edges=collections.Counter();volume=0.;zero=0;minimum=math.inf
    parents=list(range(len(vertices)))
    def find(a):
        while parents[a]!=a:parents[a]=parents[parents[a]];a=parents[a]
        return a
    def cross(a,b):return (a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0])
    for face in faces:
        a,b,c=[vertices[i] for i in face]
        v=cross(tuple(b[i]-a[i] for i in range(3)),tuple(c[i]-a[i] for i in range(3)))
        double_area=math.sqrt(sum(x*x for x in v));minimum=min(minimum,double_area)
        if double_area==0:zero+=1
        cr=cross(b,c);volume+=sum(a[i]*cr[i] for i in range(3))/6
        for x,y in zip(face,face[1:]+face[:1]):
            edges[x,y]+=1;parents[find(x)]=find(y)
    undirected={tuple(sorted(e)) for e in edges}
    edge_errors=sum(1 for a,b in undirected if a==b or edges[a,b]!=1 or edges[b,a]!=1)
    # Paired edges alone miss two sheets touching at a single vertex.
    links=collections.defaultdict(list)
    for a,b,c in faces:
        links[a].append((b,c));links[b].append((c,a));links[c].append((a,b))
    vertex_errors=0
    for pairs in links.values():
        adj=collections.defaultdict(set)
        for a,b in pairs:adj[a].add(b);adj[b].add(a)
        start=next(iter(adj));seen=set();stack=[start]
        while stack:
            node=stack.pop()
            if node in seen:continue
            seen.add(node);stack.extend(adj[node]-seen)
        if len(seen)!=len(adj) or any(len(v)!=2 for v in adj.values()):vertex_errors+=1
    bounds=[[min(q[i] for q in vertices) for i in range(3)],[max(q[i] for q in vertices) for i in range(3)]]
    result={'file':Path(path).name,'vertices':len(vertices),'triangles':len(faces),
            'bounds_mm':bounds,'size_mm':[bounds[1][i]-bounds[0][i] for i in range(3)],
            'components':len({find(i) for i in range(len(vertices))}),
            'euler_characteristic':len(vertices)-len(undirected)+len(faces),
            'edge_pairing_errors':edge_errors,'vertex_link_errors':vertex_errors,'zero_area_triangles':zero,
            'minimum_double_triangle_area_mm2':minimum,'signed_volume_mm3':volume,
            'limits':'No self-intersection, minimum-wall, fairness, factory-dimension or physical-print certification.'}
    result['basic_mesh_checks_pass']=edge_errors==0 and vertex_errors==0 and zero==0 and volume>0 and result['components']==1
    return result

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('stl',type=Path)
    parser.add_argument('--check',action='store_true',help='Fail on basic mesh problems')
    args=parser.parse_args();report=inspect(args.stl);print(json.dumps(report,indent=2))
    return 1 if args.check and not report['basic_mesh_checks_pass'] else 0
if __name__=='__main__':raise SystemExit(main())
