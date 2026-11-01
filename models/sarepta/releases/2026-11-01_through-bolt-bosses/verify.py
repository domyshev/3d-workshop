"""Check actual split meshes, glue-face equality, fixed hardware and unchanged exterior."""
from pathlib import Path
import sys,json,math
r=Path(__file__).resolve().parent
sys.path.insert(0,str(r.parents[1]/'skills/boat-hull-reconstruction/scripts'))
from inspect_stl import triangles,inspect
axes=json.loads((r/'joint-axes.json').read_text());profile=json.loads((r/'section-profile.json').read_text())['profile_yz_mm']
parent=r.parent/'2026-11-01_front-skirt-sockets'
base={p:list(triangles(parent/f'2026-11-01_sarepta_170mm_front_skirt_{p}.stl')) for p in ['lower','upper']}
fail=[];count=0;all_reports={}
def unique(values):
 out=[]
 for v in sorted(values):
  if not out or abs(v-out[-1])>1e-5:out.append(v)
 return out

def xhits(ts,y,z):
 out=[]
 for (ax,ay,az),(bx,by,bz),(cx,cy,cz) in ts:
  dy,dz,ey,ez=by-ay,bz-az,cy-ay,cz-az;det=dy*ez-ey*dz
  if abs(det)<1e-12:continue
  a=((y-ay)*ez-ey*(z-az))/det;b=(dy*(z-az)-(y-ay)*dz)/det
  if a>=-1e-9 and b>=-1e-9 and a+b<=1+1e-9:out.append(ax+a*(bx-ax)+b*(cx-ax))
 return unique(out)
def subset_yz(ts,y,z,radius=3.4):return [t for t in ts if min(v[1] for v in t)<=y+radius and max(v[1] for v in t)>=y-radius and min(v[2] for v in t)<=z+radius and max(v[2] for v in t)>=z-radius]
def yzray(ts,x,q,along_y=True):
 out=[]
 for t in ts:
  a,b,c=t
  if not min(v[0] for v in t)<=x<=max(v[0] for v in t):continue
  k=2 if along_y else 1;v=1 if along_y else 2
  dx,dq,ex,eq=b[0]-a[0],b[k]-a[k],c[0]-a[0],c[k]-a[k];det=dx*eq-ex*dq
  if abs(det)<1e-12:continue
  u=((x-a[0])*eq-ex*(q-a[k]))/det;w=(dx*(q-a[k])-(x-a[0])*dq)/det
  if u>=-1e-9 and w>=-1e-9 and u+w<=1+1e-9:out.append(a[v]+u*(b[v]-a[v])+w*(c[v]-a[v]))
 return unique(out)
def cap_area(ts,cut):
 total=0;faces=0
 for t in ts:
  if all(abs(v[0]-cut)<1e-5 for v in t):
   a,b,c=t;total+=abs((b[1]-a[1])*(c[2]-a[2])-(b[2]-a[2])*(c[1]-a[1]))/2;faces+=1
 return total,faces
for length in [170,340]:
 s=length/170;cut=length/2;files={p:r/f'2026-11-01_sarepta_{length}mm_bolt_joint_{p}.stl' for p in ['lower_bow','lower_stern','upper_bow','upper_stern']}
 meshes={p:list(triangles(f)) for p,f in files.items()};metrics={p:inspect(f) for p,f in files.items()}
 for p,m in metrics.items():
  if not m['basic_mesh_checks_pass']:fail.append(['mesh topology',length,p])
  limit=m['bounds_mm'][1][0] if p.endswith('bow') else m['bounds_mm'][0][0]
  if abs(limit-cut)>1e-5:fail.append(['nonplanar split bounds',length,p,limit])
  if m['size_mm'][0]>length/2+1e-5:fail.append(['part exceeds nominal half length',length,p])
 contacts={}
 for body in ['lower','upper']:
  a=cap_area(meshes[body+'_bow'],cut);b=cap_area(meshes[body+'_stern'],cut)
  if abs(a[0]-b[0])>.002:fail.append(['unequal mating face area',length,body,a,b])
  contacts[body]={'bow_area_mm2':a[0],'stern_area_mm2':b[0],'difference_mm2':abs(a[0]-b[0])}
 bore_records=[]
 for i,(y,z) in enumerate(axes[str(length)]['axes_yz_mm']):
  for p,sign in [('lower_bow',-1),('lower_stern',1)]:
   ts=meshes[p];sub=subset_yz(ts,y,z,5.2)
   for axial in [.1,1,2,3.95]:
    for rad,want,label in [(2.0,False,'through bore'),(2.5,True,'bore surround'),(4.7,True,'nut bearing area')]:
     for j in range(24):
      angle=2*math.pi*j/24;yy=y+rad*math.cos(angle)+1.3e-6;zz=z+rad*math.sin(angle)+2.7e-6
      h=xhits(sub,yy,zz);got=bool(sum(v<cut+sign*axial for v in h)%2);count+=1
      if got!=want:fail.append([label,length,p,i,axial,j])
   # No flange end wall blocks the nut/head envelope immediately behind it.
   for axial in [4.15,5,7.3,8.1]:
    for rad in [0,3.5,4.1]:
     for j in range(16):
      angle=2*math.pi*j/16;yy=y+rad*math.cos(angle)+1.3e-6;zz=z+rad*math.sin(angle)+2.7e-6
      h=xhits(sub,yy,zz);count+=1
      if sum(v<cut+sign*axial for v in h)%2:fail.append(['hardware space obstructed',length,p,i,axial,rad,j])
   ys=yzray(ts,cut+sign,z);zs=yzray(ts,cut+sign,y,False)
   dy=min(v for v in ys if v>y)-max(v for v in ys if v<y)
   dz=min(v for v in zs if v>z)-max(v for v in zs if v<z)
   if abs(dy-4.3)>1e-4 or abs(dz-4.3)>1e-4:fail.append(['bore diameter',length,p,i,dy,dz])
   bore_records.append({'part':p,'axis_yz_mm':[y,z],'through':True,'diameter_y_mm':dy,'diameter_z_mm':dz})
 # Exterior comparisons include points in and around the new reinforcing band.
 exterior=[];bottom=[]
 for body in ['lower','upper']:
  new=meshes[body+'_bow']+meshes[body+'_stern'];old=[tuple(tuple(c*s for c in v) for v in t) for t in base[body]]
  for xb in [10.13,30.13,60.13,80.99,81.30,81.61,84.8,85.2,110.13,145.13,169.13]:
   x=xb*s
   for zb in ([5.13,14.13,21.13,24.9] if body=='lower' else [25.13,28.13,30.0]):
    a=yzray(new,x,zb*s);b=yzray(old,x,zb*s)
    if a and b:exterior.extend([abs(a[0]-b[0]),abs(a[-1]-b[-1])])
   if body=='lower':
    for yb in [-18.13,-8.13,8.13,18.13]:
     a=yzray(new,x,yb*s,False);b=yzray(old,x,yb*s,False)
     if a and b:bottom.append(abs(a[0]-b[0]))
 if max(exterior)>.0001 or max(bottom)>.0001:fail.append(['exterior/bottom changed',length,max(exterior),max(bottom)])
 # No bridge may close the original open cockpit at the transverse station.
 for p in ['upper_bow','upper_stern']:
  sign=-1 if p.endswith('bow') else 1
  h=xhits(subset_yz(meshes[p],0,27*s),0,27*s)
  if sum(v<cut+sign for v in h)%2:fail.append(['cockpit closed',length,p])
 # Test the 6 mm inward land on floor and lower-side straight spans.
 for ybase in [-18,-9,9,18]:
  candidates=[]
  for a,b in zip(profile,profile[1:]+profile[:1]):
   if abs(b[0]-a[0])>1e-8 and min(a[0],b[0])<=ybase<=max(a[0],b[0]):
    m=(b[1]-a[1])/(b[0]-a[0]);candidates.append((a[1]+(ybase-a[0])*m,m))
  zz,m=min(candidates);yy=ybase*s;z=(zz*s)+5.7*math.sqrt(1+m*m)
  if any(math.hypot(yy-ay,z-az)<2.31 for ay,az in axes[str(length)]['axes_yz_mm']):continue
  for p,sign in [('lower_bow',-1),('lower_stern',1)]:
   hit=xhits(subset_yz(meshes[p],yy,z),yy,z);count+=1
   if not sum(v<cut+sign*.2 for v in hit)%2:fail.append(['6 mm inward land missing',length,p,yy,z])
 for zbase in [8,14,18]:
  z=zbase*s;candidates=[]
  for a,b in zip(profile,profile[1:]+profile[:1]):
   if abs(b[1]-a[1])>1e-8 and min(a[1],b[1])<=zbase<=max(a[1],b[1]):
    m=(b[0]-a[0])/(b[1]-a[1]);candidates.append((a[0]+(zbase-a[1])*m,m))
  yy,m=max(candidates);y=yy*s-5.7*math.sqrt(1+m*m)
  for side in [-1,1]:
   for p,sign in [('lower_bow',-1),('lower_stern',1)]:
    if any(math.hypot(side*y-ay,z-az)<2.31 for ay,az in axes[str(length)]['axes_yz_mm']):continue
    h=xhits(subset_yz(meshes[p],side*y,z),side*y,z);count+=1
    if not sum(v<cut+sign*.2 for v in h)%2:fail.append(['6 mm side land missing',length,p,side*y,z])
 # Remove the last transverse frame around the full original inner perimeter.
 frame_x=2200*170/4600;probe_x=80.99*s
 def global_material(ts,x,y,z):
  vals=yzray(ts,x,z)
  return bool(sum(v<y for v in vals)%2)
 old_lower=[tuple(tuple(c*s for c in v) for v in t) for t in base['lower']]
 frame_points=[(side*y*s,z*s) for side in [-1,1] for y,z in [(7,6),(18,6),(23.5,10),(23.5,14),(23.5,21.5),(25.8,22.4)]]
 for y,z in frame_points:
  count+=1
  if not global_material(old_lower,probe_x,y,z):fail.append(['reference frame material absent',length,y,z])
  if global_material(meshes['lower_bow'],probe_x,y,z):fail.append(['obsolete frame remains',length,y,z])
 # Original longitudinal stringer tops continue through the removed web.
 preserved_tops=[]
 for y in [-350*170/4600*s,0,350*170/4600*s]:
  before=yzray(old_lower,(frame_x-1)*s,y,False);after=yzray(meshes['lower_bow'],probe_x,y,False)
  if not before or not after or abs(max(before)-max(after))>1e-4:fail.append(['longitudinal stringer changed',length,y,before,after])
  else:preserved_tops.append(max(after))
 # Old upper socket positions are solid; no unused higher holes are left behind.
 old_axes=json.loads((r.parent/'2026-11-01_transverse-glue-joint/joint-axes.json').read_text())[str(length)]['axes_yz_mm']
 for y,z in old_axes[:2]:
  for p,sign in [('lower_bow',-1),('lower_stern',1)]:
   count+=1
   if not global_material(meshes[p],cut+sign,y,z):fail.append(['unused old upper hole remains',length,p,y,z])
 clearance=23.35*s-(axes[str(length)]['axes_yz_mm'][0][1]+2.3)
 if clearance<3:fail.append(['side bores overlap cover landing',length,clearance])
 all_reports[str(length)]={'removed_frame_x_mm':frame_x*s,'preserved_stringer_top_samples_mm':preserved_tops,'side_bore_clearance_below_cover_landing_mm':clearance,'cut_x_mm':cut,'glue_land_width_mm':6,'axial_land_depth_per_half_mm':4,'local_boss_width_mm':12,'bolt_axis_inset_mm':7,'mating_faces':contacts,'bores':bore_records,'max_exterior_change_mm':max(exterior),'max_bottom_change_mm':max(bottom),'mesh':metrics}
report={'checks_pass':not fail,'material_probes':count,'failures':fail,'sizes':all_reports,'skirt_note':'All three original skirt meshes are reused with uniform model scaling and no new transverse cut. Existing matching skirt/cover pins scale together with the original geometry. Only the new joint hardware remains fixed millimetres.','limits':'Finite material, geometry and topology checks; physical printing, glue strength and pin fit are untested.'}
(r/'verification.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'checks_pass':not fail,'material_probes':count,'failures':fail,'contact_areas':{k:v['mating_faces'] for k,v in all_reports.items()}},indent=2));assert not fail
