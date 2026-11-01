"""Inspect native lid splits and quantify the only intended material removal."""
from pathlib import Path
import math,json,sys,hashlib
r=Path(__file__).resolve().parent
# Reuse deterministic ray/mesh helpers, without re-running unchanged lower geometry.
p=r/'mesh_helpers.py';ns={'__file__':str(p)};exec(p.read_text().split('for length in [170,340]:')[0],ns)
triangles=ns['triangles'];inspect=ns['inspect'];xhits=ns['xhits'];subset=ns['subset_yz'];cap_area=ns['cap_area'];base=ns['base']['upper']
parent=r.parent/'2026-11-01_two-point-five-mm-bolt-joint';fail=[];count=0;results={}
original_volume=inspect(r.parent/'2026-11-01_front-skirt-sockets/2026-11-01_sarepta_170mm_front_skirt_upper.stl')['signed_volume_mm3']
for L in [170,340]:
 s=L/170;cut=L/2;meshes={p:list(triangles(r/f'2026-11-01_sarepta_{L}mm_lid_joint_{p}.stl')) for p in ['upper_bow','upper_stern']};reports={p:inspect(r/f'2026-11-01_sarepta_{L}mm_lid_joint_{p}.stl') for p in meshes}
 for p,d in reports.items():
  if not d['basic_mesh_checks_pass']:fail.append(['mesh',L,p])
 ca=[cap_area(meshes[p],cut)[0] for p in meshes]
 if abs(ca[0]-ca[1])>.0001:fail.append(['mating faces',L,ca])
 for side in [-1,1]:
  y=side*25*s;z=29.3*s
  for p,sign in [('upper_bow',-1),('upper_stern',1)]:
   sub=subset(meshes[p],y,z,2*s)
   for axial,rad,want,label in [(1,.45,False,'socket clear'),(1,.55,True,'original corner around bore'),(1.7,.45,True,'blind socket bottom')]:
    for j in range(32):
     a=2*math.pi*j/32;yy=y+rad*s*math.cos(a)+1e-6;zz=z+rad*s*math.sin(a)+2e-6;x=cut+sign*axial*s
     got=bool(sum(v<x for v in xhits(sub,yy,zz))%2);count+=1
     if got!=want:fail.append([label,L,p,side,j])
   h=xhits(sub,y+1e-6,z+2e-6);near=max(v for v in h if v<cut) if sign<0 else min(v for v in h if v>cut)
   if abs(abs(near-cut)-1.6*s)>.0001:fail.append(['socket depth',L,p,side,near])
 # Full upper volume equals the native lid minus exactly two polygonal blind-bore pairs.
 expected_removed=2*(64/2*(.5*s)**2*math.sin(2*math.pi/64))*(3.2*s)
 removed=original_volume*s**3-sum(d['signed_volume_mm3'] for d in reports.values())
 if abs(removed-expected_removed)>.003:fail.append(['unexpected material change',L,removed,expected_removed])
 # Explicitly reject the previous inward reinforcement on both rails.
 for side in [-1,1]:
  for yb,zb in [(22,27),(23,26),(22.5,28),(21.5,29)]:
   y=side*yb*s;z=zb*s
   for p,sign in [('upper_bow',-1),('upper_stern',1)]:
    h=xhits(subset(meshes[p],y,z,s),y,z);count+=1
    if sum(v<cut+sign*.5*s for v in h)%2:fail.append(['inward projection remains',L,p,yb,zb])
 for part in ['lower_bow','lower_stern']:
  a=r/f'2026-11-01_sarepta_{L}mm_lid_joint_{part}.stl';b=parent/f'2026-11-01_sarepta_{L}mm_2_5_bolt_joint_{part}.stl'
  if a.read_bytes()!=b.read_bytes():fail.append(['lower changed',L,part])
 pin=inspect(r/f'2026-11-01_sarepta_{L}mm_lid_joint_pin.stl')
 if not pin['basic_mesh_checks_pass'] or max(abs(v-w) for v,w in zip(pin['size_mm'],[.9*s,.9*s,3*s]))>1e-5:fail.append(['pin geometry',L])
 results[str(L)]={'lid_socket_diameter_mm':s,'lid_socket_depth_per_half_mm':1.6*s,'lid_pin_diameter_mm':.9*s,'lid_pin_length_mm':3*s,'mating_face_area_mm2':ca,'removed_volume_mm3':removed,'expected_bore_volume_mm3':expected_removed,'mesh':reports,'lower_byte_identical_to_parent':True,'pin':pin}
report={'checks_pass':not fail,'material_probes':count,'failures':fail,'sizes':results,'unchanged_lower_checks':str(parent/'verification.json'),'physical_fit_tested':False}
(r/'lid-verification.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'checks_pass':not fail,'material_probes':count,'failures':fail,'sizes':{k:{f:v[f] for f in ['lid_socket_diameter_mm','lid_socket_depth_per_half_mm','removed_volume_mm3','expected_bore_volume_mm3']} for k,v in results.items()}},indent=2));assert not fail
