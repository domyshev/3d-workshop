"""Check actual archived meshes: join continuity, side slope and wall samples."""
import sys, math, json
from pathlib import Path
p=Path(__file__).resolve().parent
project=p.parents[1]
sys.path.insert(0,str(project/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
files={part:p/f'2026-10-31_sarepta_170mm_stern_{part}.stl' for part in ['lower','upper']}
old=project/'releases/2026-10-31_fair-cover-joint/2026-10-31_sarepta_170mm_fair_lower.stl'
meshes={k:list(triangles(v)) for k,v in {**files,'old':old}.items()}
def subset(ts,x):return [t for t in ts if min(q[0] for q in t)<=x<=max(q[0] for q in t)]
def ray(ts,x,z):
 ys=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in ts:
  dx,dz,ex,ez=bx-ax,bz-az,cx-ax,cz-az;det=dx*ez-ex*dz
  if abs(det)<1e-12:continue
  u=((x-ax)*ez-ex*(z-az))/det;v=(dx*(z-az)-(x-ax)*dz)/det
  if u>=-1e-9 and v>=-1e-9 and u+v<=1+1e-9:ys.append(ay+u*(by-ay)+v*(cy-ay))
 ys=sorted(ys);out=[]
 for y in ys:
  if not out or abs(y-out[-1])>1e-5:out.append(y)
 return out

fail=[];count=0
cache={}
def yhits(part,x,z):
    key=(part,x)
    if key not in cache:cache[key]=subset(meshes[part],x)
    return ray(cache[key],x,z)
def inside(part,x,y,z):return bool(sum(v<y for v in yhits(part,x,z))%2)
def check(part,x,y,z,want,label):
    global count
    count+=1
    got=inside(part,x+0.0000013,y+0.0000027,z+0.0000031)
    if got!=want:fail.append([label,part,[x,y,z],want])
# Pin shanks and both blind sockets must agree, with a continuous seating ring.
for x,y in [(33,-23.6),(33,23.6),(160,-24.4),(160,24.4)]:
    for part,z in [('lower',24.55),('upper',25.55)]:
        check(part,x,y,z,False,'guide centre clear')
        for i in range(16):
            a=i*math.pi/8
            check(part,x+.90*math.cos(a),y+.90*math.sin(a),z,False,'2 mm guide bore clear')
            check(part,x+1.12*math.cos(a),y+1.12*math.sin(a),z,True,'guide surrounding wall')
    check('lower',x,y,23.7,True,'lower blind bottom')
    check('upper',x,y,26.3,True,'upper blind bottom')
# Normal-distance samples distinguish a constant-width rim from the old steps.
import re
profile=json.loads(re.search(r'join_profile = (.*?);', (p/'continuation.scad').read_text()).group(1))
def profile_at(x):
    for a,b in zip(profile,profile[1:]):
        if a[0]<=x<=b[0]:
            t=(x-a[0])/(b[0]-a[0]);return a[1]+t*(b[1]-a[1]),(b[1]-a[1])/(b[0]-a[0])
    raise ValueError(x)
for x in [17.3,20.3,24.3,28.3,38.3,42.3,46.3,50.3]+[60.3+i*3 for i in range(29)]+[151.3,153.3,155.3,157.3,163.3,165.3,166.3]:
    y,m=profile_at(x);norm=math.hypot(m,1)
    for side in [-1,1]:
        for d,want in [(1.0,True),(2.6,True),(3.8,True),(4.2,False)]:
            check('lower',x+d*m/norm,side*(y-d/norm),24.999,want,'uniform 4 mm rim')
# The old continuous inner box sides must be absent between the new ribs.
for x in [151.13,156.37,159.41,165.17]:
    for y in [20.9,21.4,21.9,22.5,23.1]:
        for z in [12.13,16.13,20.13,22.91]:
            for side in [-1,1]:check('lower',x,side*y,z,False,'no duplicate well sidewall')
for x in [154,162]:
    for y in [-24.2,24.2]:
        for z in [12.13,16.13,20.13,23.13]:check('lower',x,y,z,True,'discrete stern side rib')
sf=170/4600;roof=750*sf+2.4
seat=375*sf+(roof-375*sf)/4;shoulder=425*sf+(roof-425*sf)/4
for y,top in [(0,seat),(10,shoulder),(-10,shoulder),(18,shoulder),(-18,shoulder)]:
    for x in [168.2,169.2,169.99]:
        for z in [12.13,13.8587,15.7065,top-.15]:check('lower',x,y,z,True,'continuous transom plate')
        check('lower',x,y,top+.15,False,'halved transom rise')
radius=30*sf
floor=(230-15*(4600-2/sf-4000)/600)*sf
cz=floor+radius-.15
for y in [-430*sf,430*sf]:
    for i in range(16):
        a=i*math.pi/8
        check('lower',169.1,y+.95*math.cos(a),cz+.95*math.sin(a),False,'enlarged drain clear')
        check('lower',169.1,y+1.23*math.cos(a),cz+1.23*math.sin(a),True,'drain surrounding material')
# Preserve the corrected upper-to-lower tangent and the existing exterior sides.
join_errors=[];angle_errors=[];exterior=[]
for i in range(119):
    x=8.013+i*1.36
    lo0=yhits('lower',x,24.989)[-1];lo1=yhits('lower',x,24.999)[-1]
    up0=yhits('upper',x,25.001)[-1];up1=yhits('upper',x,25.401)[-1]
    a=(lo1-lo0)/.010;b=(up1-up0)/.4
    join_errors.append(abs(up0-b*.001-lo1-a*.001))
    angle_errors.append(abs(math.degrees(math.atan(b)-math.atan(a))))
    for z in [5.013,10.013,15.013,20.013,23.413,24.913]:
        aa=yhits('lower',x,z);bb=yhits('old',x,z)
        if aa and bb:exterior.extend([abs(aa[0]-bb[0]),abs(aa[-1]-bb[-1])])
report={'mesh':{k:inspect(v) for k,v in files.items()},'material_checks':count,'failures':fail,'bore_diameter_mm':2.0,'pin_diameter_mm':1.6,'rim_normal_width_mm':4,'new_transom_centre_mm':seat,'new_transom_shoulder_mm':shoulder,'drain_diameter_mm':2*radius,'join_samples':len(join_errors),'max_joint_error_mm':max(join_errors),'max_joint_angle_error_deg':max(angle_errors),'exterior_samples':len(exterior),'max_exterior_side_change_mm':max(exterior),'limits':'Sampled digital checks. Physical print, fit and drainage are untested. New rim and stern are intentional owner-directed changes.'}
report['checks_pass']=not fail and max(join_errors)<.01 and max(angle_errors)<.2 and max(exterior)<.0001 and all(v['basic_mesh_checks_pass'] for v in report['mesh'].values())
(p/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='mesh'},indent=2))
assert report['checks_pass']
