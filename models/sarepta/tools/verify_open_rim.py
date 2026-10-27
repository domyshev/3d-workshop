#!/usr/bin/env python3
"""Check open-rim contacts and sampled preservation of the old lower exterior."""
import argparse,json,sys
from pathlib import Path
import numpy as np
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles
from verify_horizontal_joint import face_data,point_distance

class Rays:
    def __init__(self,path):
        ts=np.asarray(list(triangles(path)));self.a=ts[:,0];self.b=ts[:,1]-self.a;self.c=ts[:,2]-self.a
        self.den=self.b[:,0]*self.c[:,1]-self.b[:,1]*self.c[:,0];self.valid=np.abs(self.den)>1e-12
    def surfaces(self,x,y):
        dx=x-self.a[:,0];dy=y-self.a[:,1]
        u=np.divide(dx*self.c[:,1]-dy*self.c[:,0],self.den,out=np.zeros(len(self.den)),where=self.valid)
        v=np.divide(self.b[:,0]*dy-self.b[:,1]*dx,self.den,out=np.zeros(len(self.den)),where=self.valid)
        mask=self.valid&(u>=0)&(v>=0)&(u+v<=1)
        zs=np.sort((self.a[:,2]+u*self.b[:,2]+v*self.c[:,2])[mask])
        return zs[np.r_[True,np.diff(zs)>1e-5]] if len(zs) else zs

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('parent',type=Path);ap.add_argument('lower',type=Path);ap.add_argument('upper',type=Path);a=ap.parse_args()
    la,lc,le,lt=face_data(a.lower,25,False);ua,uc,ue,ut=face_data(a.upper,25,True)
    def covered(p):
        if min(point_distance(p,e) for e in ue)<0.06:return True
        n=0
        for q,r in ue:
            if (q[1]>p[1])!=(r[1]>p[1]):n+=q[0]+(p[1]-q[1])*(r[0]-q[0])/(r[1]-q[1])>p[0]
        return n%2==1
    points=[]
    for t in lt:
        points.extend(v[:2] for v in t);points.append(tuple(sum(v[i] for v in t)/3 for i in range(2)))
    unsupported=sum(not covered(p) for p in points)
    old,new=Rays(a.parent),Rays(a.lower);count=0;maximum=0.;failures=[]
    for x in range(8,59,2):
        for y in range(-24,25,2):
            ox,oy=x+0.000017,y+0.000013;before=old.surfaces(ox,oy)
            if not len(before):continue
            after=new.surfaces(ox,oy);count+=1
            if not len(after):failures.append([x,y,'missing exterior']);continue
            delta=abs(float(before[0]-after[0]));maximum=max(maximum,delta)
            if delta>0.0001:failures.append([x,y,'exterior changed',delta])
            p=float(before[0]+0.2)
            if np.count_nonzero(before<p)%2==1 and np.count_nonzero(after<p)%2!=1:failures.append([x,y,'skin removed'])
    passed=unsupported==0 and not failures
    print(json.dumps({'horizontal_join_z_mm':25,'lower_glue_area_mm2':la,'upper_underside_area_mm2':ua,'lower_glue_samples':len(points),'unsupported_lower_glue_samples':unsupported,'contact_boundary_tolerance_mm':0.06,'floor_xy_samples':count,'maximum_sampled_lowest_surface_change_mm':maximum,'floor_failures':failures,'checks_pass':passed,'limits':'Sampled skin and rim-contact checks; not a global minimum-wall, self-intersection or physical-print certification.'},indent=2))
    return 0 if passed else 1
if __name__=='__main__':raise SystemExit(main())
