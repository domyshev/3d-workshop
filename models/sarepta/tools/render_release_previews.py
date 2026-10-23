#!/usr/bin/env python3
"""Render common upper, bottom and plan views from actual archived STL files."""
import argparse,concurrent.futures,json,subprocess
from pathlib import Path
CAMERAS={'above':'-56,-90,85,40,0,6','bottom':'-85,-75,-70,40,0,6','plan':'40,0,150,40,0,0'}
def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--openscad',default='openscad');ap.add_argument('--x86',action='store_true');ap.add_argument('--release',action='append',help='Render only these milestone IDs');a=ap.parse_args()
    root=Path(__file__).resolve().parent.parent;records=json.loads((root/'releases/manifest.json').read_text())
    if a.release:records=[r for r in records if r['id'] in a.release]
    def render(task):
        r,view=task;folder=root/'releases'/r['id'];out=folder/(view+'.png')
        cmd=(['arch','-x86_64'] if a.x86 else [])+[a.openscad,'-o',str(out),'--imgsize=1200,850','--camera='+CAMERAS[view],'--projection=ortho','--colorscheme=Tomorrow','--render=true',str(folder/'view.scad')]
        done=subprocess.run(cmd,capture_output=True,text=True)
        if done.returncode:raise RuntimeError(r['id']+' '+view+'\n'+done.stderr)
        print(r['id'],view,flush=True)
    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as ex:list(ex.map(render,[(r,v) for r in records for v in CAMERAS]))
if __name__=='__main__':main()
