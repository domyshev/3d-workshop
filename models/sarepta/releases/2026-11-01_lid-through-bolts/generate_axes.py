"""Record the two inspection configurations using the native section guide."""
from pathlib import Path
import json,math,re
r=Path(__file__).resolve().parent;d=json.loads((r/'section-profile.json').read_text());poly=d['profile_yz_mm'];bottom_half=d['bottom_chine'][0]
def floor(y):
 return min((a[1]+(y-a[0])*(b[1]-a[1])/(b[0]-a[0]),(b[1]-a[1])/(b[0]-a[0])) for a,b in zip(poly,poly[1:]+poly[:1]) if abs(b[0]-a[0])>1e-8 and min(a[0],b[0])<=y<=max(a[0],b[0]))
def side(z):
 return max((a[0]+(z-a[1])*(b[0]-a[0])/(b[1]-a[1]),(b[0]-a[0])/(b[1]-a[1])) for a,b in zip(poly,poly[1:]+poly[:1]) if abs(b[1]-a[1])>1e-8 and min(a[1],b[1])<=z<=max(a[1],b[1]))
out={}
for length in [170,340]:
 scale=length/170;z=25*scale-2.5-(25*scale)/5;y,m=side(z/scale);fz,fm=floor(bottom_half/3)
 sy=y*scale-7*math.sqrt(1+m*m);by=bottom_half/3*scale;bz=fz*scale+7*math.sqrt(1+fm*fm)
 out[str(length)]={'cut_x_mm':length/2,'axes_yz_mm':[[-sy,z],[sy,z],[-by,bz],[by,bz]],'side_drop_from_previous_mm':25*scale/5}
(r/'joint-axes.json').write_text(json.dumps(out,indent=2)+'\n')
p=r/'inspection-view.scad';s=p.read_text();line='function inspection_axes() = display_length_mm==170 ? '+json.dumps(out['170']['axes_yz_mm'])+' : '+json.dumps(out['340']['axes_yz_mm'])+';'
s=re.sub(r'function inspection_axes\(\) = .*?;',lambda _:line,s);p.write_text(s)
print(json.dumps(out,indent=2))
