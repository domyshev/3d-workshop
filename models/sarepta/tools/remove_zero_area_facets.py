#!/usr/bin/env python3
"""Drop only exactly zero-area binary-STL facets and require a valid result.

Float32 export can collapse tiny Manifold facets. No vertex movement, hole
patching, component removal or nonzero-area triangle deletion is allowed.
The resulting temporary mesh must be published through export_stl.
"""
import argparse,json,struct,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('source',type=Path);ap.add_argument('temporary_mesh',type=Path);ap.add_argument('--report',type=Path,required=True);a=ap.parse_args()
    kept=[];removed=0
    for t in triangles(a.source):
        p,q,r=t;u=[q[i]-p[i] for i in range(3)];v=[r[i]-p[i] for i in range(3)]
        cross=[u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]
        if not any(cross):removed+=1
        else:kept.append(t)
    data=bytearray(b'Sarepta exact zero-area float export cleanup'.ljust(80,b' '));data.extend(struct.pack('<I',len(kept)))
    for t in kept:data.extend(struct.pack('<12fH',0,0,0,*(v for p in t for v in p),0))
    a.temporary_mesh.write_bytes(data);report=inspect(a.temporary_mesh);assert report['basic_mesh_checks_pass'],report
    a.report.write_text(json.dumps({'exact_zero_area_facets_removed':removed,'nonzero_area_facets_removed':0,'vertices_moved':0,'holes_patched':0,'components_removed':0,'result_basic_mesh_checks_pass':True},indent=2)+'\n')
if __name__=='__main__':main()
