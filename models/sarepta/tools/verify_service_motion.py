#!/usr/bin/env python3
"""Check sampled removable-panel/retainer movement against the four actual meshes."""
import sys,json,argparse
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
from verify_open_rim import Rays
ap=argparse.ArgumentParser();ap.add_argument('directory',type=Path);ap.add_argument('--report',type=Path);args=ap.parse_args();p=args.directory;prefix='2026-10-28_sarepta_170mm_service_'
lower,upper,dash,stop=[Rays(p/(prefix+n+'.stl')) for n in ['lower','upper','dashboard','retainer']]
def material(zs,z):return sum(v<z for v in zs)%2==1
points=[]
for x in [52.2,53,54,55,56,57,57.7,58.1,58.4,58.8,59.0]:
 for y in [-20.3,-19.6,-18,-15,-11.1,-7,-5.5,.001,5.5,7,11.1,15,18,19.6,20.3]:
  zs=dash.surfaces(x,y)
  for z in [20.5,21,21.4,22,23,24.5,25.5,26.5,27.5,28.6]:
   if material(zs,z):points.append([x,y,z])
fail=[];count=0
for dx in [0,.25,.5,1,2,4,6,8,10]:
 cache={}
 for x,y,z in points:
  key=x+dx,y
  if key not in cache:cache[key]=[lower.surfaces(*key),upper.surfaces(*key)]
  count+=1
  if any(material(zs,z) for zs in cache[key]):fail.append([dx,x,y,z])
print('dashboard tests',count,'failures',len(fail),fail[:10])
# The retainer must lift through the opening before the dashboard can slide.
stop_points=[]
for x in [59.5,60,60.5,61.3]:
 for y in [-20.3,-19.2,-18,0.001,18,19.2,20.3]:
  zs=stop.surfaces(x,y)
  for z in [18,19,20,20.5,21.5]:
   if material(zs,z):stop_points.append([x,y,z])
stop_fail=[];stop_count=0
for dz in [0,.5,1,2,2.6,4,8,12]:
 for x,y,z in stop_points:
  stop_count+=1
  if any(material(obj.surfaces(x,y),z+dz) for obj in [lower,upper,dash]):stop_fail.append([dz,x,y,z])
print('retainer tests',stop_count,'failures',len(stop_fail),stop_fail[:10])
report=dict(dashboard_interior_points=len(points),dashboard_translation_steps_mm=[0,.25,.5,1,2,4,6,8,10],dashboard_collision_samples=count,dashboard_collisions=fail,retainer_collision_samples=stop_count,retainer_collisions=stop_fail,checks_pass=not fail and not stop_fail,limits='Sampled interior points on actual exported meshes, not a continuous collision proof or physical fit certification.')
if args.report:args.report.write_text(json.dumps(report,indent=2)+'\n')
assert report['checks_pass']
