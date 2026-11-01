"""Verify actual lid through holes, mating faces, unchanged hull and printable meshes."""
from pathlib import Path
import json,math
r=Path(__file__).resolve().parent
ns={'__file__':str(r/'mesh_helpers.py')}
exec((r/'mesh_helpers.py').read_text(),ns)
triangles,inspect,xhits,subset,cap_area=(ns[k] for k in ['triangles','inspect','xhits','subset_yz','cap_area'])
guide=json.loads((r/'roof-section.json').read_text());ay,az=guide['axis_yz_base_mm'];parent=r.parent/'2026-11-01_two-point-five-mm-bolt-joint'
fail=[];results={};count=0
for length in [170,340]:
 scale=length/170;cut=length/2;meshes={};metrics={}
 for part in ['upper_bow','upper_stern']:
  f=r/f'2026-11-01_sarepta_{length}mm_lid_through_{part}.stl';meshes[part]=list(triangles(f));metrics[part]=inspect(f)
  if not metrics[part]['basic_mesh_checks_pass']:fail.append(['topology',length,part])
 areas=[cap_area(meshes[p],cut)[0] for p in ['upper_bow','upper_stern']]
 if abs(areas[0]-areas[1])>.001:fail.append(['mating face mismatch',length,areas])
 for part,sign in [('upper_bow',-1),('upper_stern',1)]:
  for side in [-1,1]:
   y=side*ay*scale;z=az*scale;ts=meshes[part];sub=subset(ts,y,z,3)
   for axial in [.2,1,2.45]:
    for radius,want in [(2.0,False),(2.2,True)]:
     for j in range(32):
      angle=2*math.pi*j/32;yy=y+radius*math.cos(angle)+1e-6;zz=z+radius*math.sin(angle)+2e-6;x=cut+sign*axial
      got=bool(sum(v<x for v in xhits(sub,yy,zz))%2);count+=1
      if got!=want:fail.append(['bore material',length,part,side,axial,radius,j])
   yy=ns['yzray'](ts,cut+sign,z);zz=ns['yzray'](ts,cut+sign,y,False)
   dy=min(v for v in yy if v>y)-max(v for v in yy if v<y);dz=min(v for v in zz if v>z)-max(v for v in zz if v<z)
   if max(abs(dy-4.3),abs(dz-4.3))>.0001:fail.append(['diameter',length,part,side,dy,dz])
 for part in ['lower_bow','lower_stern']:
  if (r/f'2026-11-01_sarepta_{length}mm_lid_through_{part}.stl').read_bytes()!=(parent/f'2026-11-01_sarepta_{length}mm_2_5_bolt_joint_{part}.stl').read_bytes():fail.append(['lower changed',length,part])
 results[str(length)]={'lid_hole_diameter_mm':4.3,'tab_depth_per_half_mm':2.5,'mating_face_areas_mm2':areas,'meshes':metrics}
report={'checks_pass':not fail,'material_probes':count,'failures':fail,'sizes':results,'physical_fit_tested':False}
(r/'lid-through-verification.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'checks_pass':not fail,'material_probes':count,'failures':fail},indent=2));assert not fail
