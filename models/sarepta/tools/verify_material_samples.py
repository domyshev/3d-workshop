#!/usr/bin/env python3
"""Repeat saved point/material checks against an actual STL (requires NumPy).

Usage: verify_material_samples.py model.stl interior-checks-80mm.json
These are point samples, not full connectivity or minimum-wall certification.
"""
import argparse,json,sys
from pathlib import Path
import numpy as np
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('stl',type=Path);ap.add_argument('checks',type=Path)
    args=ap.parse_args();saved=json.loads(args.checks.read_text())
    sf=saved['model_length_mm']/4600
    ts=np.asarray(list(triangles(args.stl)));a=ts[:,0];b=ts[:,1]-a;c=ts[:,2]-a
    den=b[:,0]*c[:,1]-b[:,1]*c[:,0];valid=np.abs(den)>1e-12
    failures=0
    for check in saved['checks']:
        x,y,z=np.asarray(check['point_fullsize_mm'])*sf
        # Avoid an accidental ray through shared mesh edges or vertices.
        x+=0.000017;y+=0.000013;dx=x-a[:,0];dy=y-a[:,1]
        u=np.divide(dx*c[:,1]-dy*c[:,0],den,out=np.zeros(len(den)),where=valid)
        v=np.divide(b[:,0]*dy-b[:,1]*dx,den,out=np.zeros(len(den)),where=valid)
        mask=valid&(u>=0)&(v>=0)&(u+v<=1)
        zs=np.sort((a[:,2]+u*b[:,2]+v*c[:,2])[mask])
        if len(zs):zs=zs[np.r_[True,np.diff(zs)>1e-5]]
        material=int(np.count_nonzero(zs<z))%2==1
        passed=material==check['expected_material'];failures+=not passed
        print(('PASS ' if passed else 'FAIL ')+check['feature'])
    return 1 if failures else 0
if __name__=='__main__':raise SystemExit(main())
