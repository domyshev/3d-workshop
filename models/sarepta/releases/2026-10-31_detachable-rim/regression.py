"""Check actual archived meshes: join continuity, side slope and wall samples."""
import sys, math, json
from pathlib import Path
p=Path(__file__).resolve().parent
project=p.parents[1]
sys.path.insert(0,str(project/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
files={part:p/f'2026-10-31_sarepta_170mm_detachable_{part}.stl' for part in ['lower','upper']}
old=project/'releases/2026-10-31_clean-stern/2026-10-31_sarepta_170mm_stern_lower.stl'
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

# Clear the old side shelf and the remaining excess beside the bow cavity.
for x,z in [(27.9,17),(29.1,17),(31.9,17),(33,17),(33,20.7),(50.7,12),(51.3,17),(54,20.7),(58.5,20.7),(58.5,22)]:
 for side in [-1,1]:check('lower',x,side*22.1,z,False,'legacy bow internals removed')
for side in [-1,1]:check('lower',33,side*24.4,17,True,'original side plating retained')
# Small remnants of the former forward wall must not rise above the floor.
for y,z in [(0,1.26),(6,3.65),(12,6.845),(18,8.68)]:
 for side in [-1,1]:check('lower',50.7,side*y,z,False,'forward wall foot removed')
check('lower',51.3,6,3.62,False,'forward wall foot removed')
check('lower',54.2,0,2.1,True,'original forward centre stringer retained')
# Wall and cover use the same 1.3 mm divider location and contact plane.
well=4000*170/4600
for y in [-18,-12,-6,0,6,12,18]:
 for z in [20.9,23,24.9]:check('lower',well+.6,y,z,True,'aligned lower divider')
 for z in [25.01,26,28.8]:check('upper',well+.6,y,z,True,'full-depth cover divider')
 for x in [well-.3,well+1.5]:
  check('lower',x,y,24.8,False,'no displaced divider bar')
  check('upper',x,y,25.1,False,'no displaced cover bridge')
# No raised floor remains between the ribs.
for x in [151.13,156.37,159.41,165.17]:
 for y in [-18,-6,6,18]:
  for z in [5.5,6.5,7.5]:check('lower',x,y,z,False,'no raised stern floor')
for y in [-22,22]:
 check('lower',169.1,y,24.8,True,'rear corner fully supports cover')
 check('upper',169.1,y,25.1,True,'rear cover corner')
# Level stern ribs meet the last transverse floor without a forward overhang.
sf=170/4600
rib_top=220*sf
rib_axes=[-350*sf,0,350*sf]
for y in rib_axes:
 for x in [162.5,164.1,165.7,167.8,167.98]:
  check('lower',x,y,rib_top-.08,True,'stern rib reaches common level')
  check('lower',x,y,rib_top+.08,False,'stern rib has no sloping high crest')
 for x in [160.8,161.2,161.5]:
  for z in [5.1,7.9]:check('lower',x,y,z,False,'stern rib does not project ahead of last floor')
 for offset,want in [(-.25,True),(.25,True),(-.45,False),(.45,False)]:
  check('lower',165.1,y+offset,7.9,want,'stern rib width and axis')
for y in [-18,0,18]:
 check('lower',162.1,y,rib_top-.08,True,'last transverse floor retained')
 check('lower',162.1,y,rib_top+.08,False,'common horizontal floor crest')
# Two outlets are directly above the outer ribs with 0.8 mm below their rims.
cz=rib_top+.8+30*sf
for y in [rib_axes[0],rib_axes[2]]:
 for i in range(16):
  a=i*math.pi/8
  check('lower',169.1,y+.95*math.cos(a),cz+.95*math.sin(a),False,'raised aligned drain clear')
  check('lower',169.1,y+1.24*math.cos(a),cz+1.24*math.sin(a),True,'raised aligned drain wall')
 check('lower',169.1,y,rib_top+.75,True,'0.8 mm gap below drain')
 check('lower',169.1,y,rib_top+.85,False,'drain begins above clearance')
for y in [-430*sf,430*sf]:
 for z in [4.55,8.945]:check('lower',169.1,y,z,True,'previous outlet filled')
# The side shell must remain continuous along its entire length.
widths=[];join=[];angles=[];smoothness=[]
for i in range(119):
 x=8.013+1.36*i
 for z in [25.21,26.31,27.71,28.81]:
  v=[a for a in yhits('upper',x,z) if a>0]
  if not v:fail.append(['missing outer cover side',x,z])
  elif len(v)>1:widths.append(v[-1]-v[-2])
 a=yhits('lower',x,24.999)[-1];b=yhits('upper',x,25.001)[-1]
 join.append(abs(a-b))
 lo=(a-yhits('lower',x,24.949)[-1])/.05
 up=(yhits('upper',x,25.051)[-1]-b)/.05
 angles.append(abs(math.degrees(math.atan(lo)-math.atan(up))))
 if x>60 and x<169:
  a=yhits('upper',x-.25,28.5)[-1];b=yhits('upper',x,28.5)[-1];c=yhits('upper',x+.25,28.5)[-1]
  smoothness.append(abs((c-b)-(b-a)))
# Compare the unchanged bottom surface, rather than demanding the old belt shape.
def zray(ts,x,y):
 zs=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in ts:
  dx,dy,ex,ey=bx-ax,by-ay,cx-ax,cy-ay;det=dx*ey-ex*dy
  if abs(det)<1e-12:continue
  u=((x-ax)*ey-ex*(y-ay))/det;v=(dx*(y-ay)-(x-ax)*dy)/det
  if u>=0 and v>=0 and u+v<=1:zs.append(az+u*(bz-az)+v*(cz-az))
 return sorted(zs)
measured_tops=[]
for y in rib_axes:
 for x in [162.5,164.1,165.7,167.8]:
  measured_tops.append(max(zray(subset(meshes['lower'],x),x,y)))
measured_drain_bottoms=[]
for y in [rib_axes[0],rib_axes[2]]:
 levels=zray(subset(meshes['lower'],169.1),169.1,y)
 measured_drain_bottoms.append(min(v for v in levels if v>rib_top))
bottom=[]
for i in range(54):
 x=4.017+3*i
 for y in [-20.013,-12.013,-4.013,4.013,12.013,20.013]:
  a=zray(cache.setdefault(('lower',x),subset(meshes['lower'],x)),x,y)
  b=zray(cache.setdefault(('old',x),subset(meshes['old'],x)),x,y)
  if a and b and b[0] < 670*sf-120*x/4600-1.23:bottom.append(abs(a[0]-b[0]))
# Every bow ring is a simple monotone half-outline; both front faces are planar.
guides=json.loads((p.parent/'2026-10-31_level-stern-ribs/belt-guides.json').read_text());n=guides['half_count'];planarity=[]
for ring,z in zip(guides['rings'],guides['levels']):
 if z<24.8:continue
 tip=ring[0][0]
 planarity.append(abs(ring[1][0]-.44*ring[1][1]-tip))
 assert all(b[0]>a[0] for a,b in zip(ring[:n],ring[1:n]))
# External bow sides must not change when clearing the internal remnants.
before=list(triangles(project/'releases/2026-10-31_continuous-belt/2026-10-31_sarepta_170mm_continuous_lower.stl'))
exterior=[]
for i in range(35):
 x=8.017+1.5*i
 aa=subset(meshes['lower'],x);bb=subset(before,x)
 for z in [6.013,12.013,17.013,20.713,23.713,24.513]:
  a=ray(aa,x,z);b=ray(bb,x,z)
  if a and b and z < 670*sf-120*x/4600-1.23:exterior.extend([abs(a[0]-b[0]),abs(a[-1]-b[-1])])
baseline=list(triangles(project/'releases/2026-10-31_level-stern-ribs/2026-10-31_sarepta_170mm_level_stern_lower.stl'))
stringer_differences=[]
buried_stringer_samples=0
for x in [54.2,58.2,60.9,90.2,110.2]:
 for y in [-350*sf,0,350*sf]:
  aa=zray(subset(meshes['lower'],x),x,y);bb=zray(subset(baseline,x),x,y)
  expected=1.2+max(.65,28*sf)+abs(y)*math.tan(math.radians(8.5))
  if aa and bb and abs(max(bb)-expected)<.001:
   stringer_differences.append(abs(max(aa)-max(bb)))
  else:
   # Here the original stringer is below the sloping floor, not an exposed rib.
   # The old floor surface is deliberately being cleaned, so its height may move.
   buried_stringer_samples+=1
metrics={k:inspect(v) for k,v in files.items()}
report={'exposed_stringer_height_differences_mm':stringer_differences,'buried_stringer_samples_excluded_from_top_comparison':buried_stringer_samples,'stern_rib_top_mm':rib_top,'stern_rib_start_mm':162.3,'measured_rib_tops_mm':measured_tops,'measured_drain_bottoms_mm':measured_drain_bottoms,'drain_lower_clearance_mm':[v-rib_top for v in measured_drain_bottoms],'drain_axes_y_mm':[rib_axes[0],rib_axes[2]],'mesh':metrics,'external_bow_samples':len(exterior),'max_external_bow_change_mm':max(exterior),'material_checks':count,'failures':fail,'side_wall_probes':119*4,'minimum_sampled_horizontal_wall_mm':min(widths),'join_samples':len(join),'max_join_difference_over_0_002mm_height_mm':max(join),'max_tangent_angle_difference_deg':max(angles),'max_longitudinal_second_difference_over_0_25mm_mm':max(smoothness),'bottom_samples':len(bottom),'max_bottom_change_mm':max(bottom),'bow_plane_error_mm':max(planarity),'limits':'Finite sampled geometry checks and rendered critical views. Physical print and fit are untested. The protective skirt is intentionally removed; comparisons exclude its seam band.'}
report['checks_pass']=max(stringer_differences)<.0001 and max(abs(v-rib_top) for v in measured_tops)<.0001 and max(abs(v-rib_top-.8) for v in measured_drain_bottoms)<.0001 and max(exterior)<.0001 and not fail and min(widths)>.75 and max(join)<.002 and max(angles)<.3 and max(smoothness)<.02 and max(bottom)<.0001 and max(planarity)<1e-8 and all(v['basic_mesh_checks_pass'] for v in metrics.values())
(p/'regression.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='mesh'},indent=2))
assert report['checks_pass']
