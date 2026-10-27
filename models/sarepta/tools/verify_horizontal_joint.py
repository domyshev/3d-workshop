#!/usr/bin/env python3
"""Compare the actual horizontal mating faces of two exported hull meshes."""
import argparse, collections, json, math, sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles

def face_data(path,z,upper):
    faces=list(triangles(path));eps=1e-5;edges=collections.Counter();area=0.;count=0;planar=[]
    assert all(v[2]>=z-eps if upper else v[2]<=z+eps for t in faces for v in t), 'Part crosses the interface plane'
    for t in faces:
        if not all(abs(v[2]-z)<eps for v in t):continue
        a,b,c=t;cross=(b[0]-a[0])*(c[1]-a[1])-(b[1]-a[1])*(c[0]-a[0])
        assert cross<0 if upper else cross>0, 'Wrong mating-face orientation'
        area+=abs(cross)/2;count+=1;planar.append(t)
        for p,q in zip(t,t[1:]+t[:1]):edges[tuple(sorted((p[:2],q[:2])))]+=1
    assert count>0
    assert all(n in (1,2) for n in edges.values())
    boundary=[e for e,n in edges.items() if n==1]
    return area,count,boundary,planar

def point_distance(p,e):
    a,b=e;v=(b[0]-a[0],b[1]-a[1]);l=v[0]*v[0]+v[1]*v[1]
    t=max(0,min(1,((p[0]-a[0])*v[0]+(p[1]-a[1])*v[1])/l)) if l else 0
    return math.hypot(p[0]-a[0]-t*v[0],p[1]-a[1]-t*v[1])

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('lower',type=Path);ap.add_argument('upper',type=Path);ap.add_argument('--z',type=float,default=25);a=ap.parse_args()
    la,lc,le,lt=face_data(a.lower,a.z,False);ua,uc,ue,ut=face_data(a.upper,a.z,True)
    distances=[]
    for source,target in [(le,ue),(ue,le)]:
        for edge in source:
            # Include segment midpoints to detect missing/notched boundaries.
            for p in [edge[0],edge[1],tuple((edge[0][i]+edge[1][i])/2 for i in range(2))]:
                distances.append(min(point_distance(p,q) for q in target))
    def supported(p):
        if min(point_distance(p,e) for e in le)<0.00005:return True
        crossings=0
        for q,r in le:
            if (q[1]>p[1])!=(r[1]>p[1]):
                x=q[0]+(p[1]-q[1])*(r[0]-q[0])/(r[1]-q[1])
                crossings+=x>p[0]
        return crossings%2==1
    samples=[]
    for t in ut:
        samples.extend(v[:2] for v in t)
        samples.append(tuple(sum(v[i] for v in t)/3 for i in range(2)))
        samples.extend(tuple((p[i]+q[i])/2 for i in range(2)) for p,q in zip(t,t[1:]+t[:1]))
    unsupported=sum(not supported(p) for p in samples)
    maximum=max(distances)
    # Lower landing deliberately extends a nominal 0.04 mm beyond the upper
    # band; require support, rather than equal area of that exposed narrow ledge.
    passed=la>=ua and maximum<0.1 and unsupported==0
    report={'join_z_mm':a.z,'lower_mating_area_mm2':la,'upper_mating_area_mm2':ua,'area_difference_mm2':abs(la-ua),'maximum_sampled_boundary_disagreement_mm':maximum,'lower_mating_triangles':lc,'upper_mating_triangles':uc,'upper_face_samples':len(samples),'unsupported_upper_face_samples':unsupported,'nominal_upper_band_inset_mm':0.04,'all_lower_vertices_at_or_below_plane':True,'all_upper_vertices_at_or_above_plane':True,'horizontal_interface_checks_pass':passed,'limits':'Sampled upper-face support, boundary clearance and plane bounds; not a physical flatness or printer calibration test.'}
    print(json.dumps(report,indent=2));return 0 if passed else 1
if __name__=='__main__':raise SystemExit(main())
