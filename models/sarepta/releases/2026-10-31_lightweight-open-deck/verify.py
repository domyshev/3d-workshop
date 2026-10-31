import sys,json,math
from pathlib import Path
import numpy as np
project=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(project/'tools'))
from verify_open_rim import Rays
sys.path.insert(0,str(project/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import inspect
p=Path(__file__).resolve().parent
r={n:Rays(p/f'2026-10-31_sarepta_170mm_light_{n}.stl') for n in ['lower','upper','dashboard']}
fail=[];count=0

def test(n,x,y,z,expected,label):
 global count
 count+=1
 actual=bool(np.count_nonzero(r[n].surfaces(x+0.000007,y+0.000013)<z)%2)
 if actual!=expected:fail.append(dict(part=n,xyz=[x,y,z],label=label,expected=expected))
for x,y in [(33,-24.4),(33,24.4),(160,-25.1),(160,25.1)]:
 for n,z in [('lower',24.45),('upper',25.55)]:
  test(n,x,y,z,False,'shared glue-guide bore')
  for a in range(0,360,30):
   test(n,x+1.05*math.cos(math.radians(a)),y+1.05*math.sin(math.radians(a)),z,True,'bore surrounding wall')
 test('lower',x,y,23.7,True,'blind lower bottom')
 test('upper',x,y,26.3,True,'blind upper bottom')
for x,y in [(34.7,y) for y in [-6,-3,0,3,6]]+[(54,y) for y in [-6,-3,0,3,6]]+[(x,y) for x in [38,42,46,50] for y in [-8.8,8.8]]:
 test('upper',x,y,29.6,True,'continuous hatch surround')
for y in [-18,-12,-6,0,6,12,18]:
 test('upper',58.8,y,29.6,True,'continuous cockpit edge')
 test('upper',56,y,27,False,'open underside of roof')
 test('lower',51,y,10,False,'deleted sealed bow partition')
 test('lower',60.5,y,20.8,False,'deleted retainer bar seats')
 test('upper',56.9,y,28.8,True,'hidden integral panel lap')
 test('dashboard',58.5,y,28.8,True,'raised instrument panel')
# Points in the actual panel must not collide with either assembled shell.
for x in [57.3,57.6,58.1,58.8,59.05]:
 for y in [-20.3,-15,-7,0.01,7,15,20.3]:
  for z in [22.8,24,25,26,28.2,28.8,28.95]:
   if np.count_nonzero(r['dashboard'].surfaces(x,y)<z)%2:
    for n in ['lower','upper']:test(n,x,y,z,False,'panel collision clearance')
for y,t in [(0,(375*170/4600+750*170/4600+2.4)/2),(12,(425*170/4600+750*170/4600+2.4)/2)]:
 test('lower',169,y,t-.1,True,'raised rear transom')
 test('lower',169,y,t+.1,False,'transom top and central notch')
# Preserve the exterior bottom away from the deliberately changed rear top.
old=Rays(project/'releases/2026-10-28_serviceable-dashboard/2026-10-28_sarepta_170mm_service_lower.stl')
bottom_fail=[];bottom_count=0
for x in range(4,167,3):
 for y in range(-22,23,4):
  a=old.surfaces(x+.000017,y+.000013);b=r['lower'].surfaces(x+.000017,y+.000013)
  if len(a):
   bottom_count+=1
   if not len(b) or abs(float(a[0]-b[0]))>.0001:bottom_fail.append([x,y])
metrics={n:inspect(p/f'2026-10-31_sarepta_170mm_light_{n}.stl') for n in ['lower','upper','dashboard','pin']}
report=dict(material_and_fit_checks=count,failures=fail,bottom_samples=bottom_count,bottom_failures=bottom_fail,mesh=metrics,checks_pass=not fail and not bottom_fail and all(v['basic_mesh_checks_pass'] for v in metrics.values()),limits='Sampled static geometry and original bottom checks. No physical assembly, minimum-wall, buoyancy or watertightness certification.')
(p/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='mesh'},indent=2))

assert report["checks_pass"], "Geometry checks failed"
