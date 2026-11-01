"""Generate one trimmed master-plan belt with planar V bow faces."""
from pathlib import Path
import math,json
sf=170/4600;roof=750*sf+2.4;seam=-120/4600;w0=50*sf-.08
cp=[[303.6*sf,690*sf],[600*sf,735*sf],[1100*sf,800*sf],[1550*sf,800*sf]]
def smooth(t):
 t=max(0,min(1,t));return t*t*t*(10-15*t+6*t*t)
def cubic(t):return [sum(math.comb(3,i)*(1-t)**(3-i)*t**i*cp[i][k] for i in range(4)) for k in range(2)]
def deriv(t):return [3*sum(math.comb(2,i)*(1-t)**(2-i)*t**i*(cp[i+1][k]-cp[i][k]) for i in range(3)) for k in range(2)]
def slope(x):return .22+.08*smooth((x-303.6*sf)/((1550-303.6)*sf))-.05*smooth((x-120)/50)
def offset_point(q,d,z):
 l=math.hypot(*d);n=[d[1]/l,-d[0]/l];s=slope(q[0]);w=max(.1,(w0+s*(z-670*sf-seam*q[0]+.6))/(1+s*seam*n[0]))
 return [q[i]+w*n[i] for i in range(2)]
def half_at(z):
 # Both straight bow faces keep one fixed normal; their common tip is explicit.
 mx=math.sqrt(1+.44*.44);w=max(.1,(w0+.22*(z-670*sf+.6))/(1+.22*seam*mx));tip=mx*w
 def gap(t):
  p=offset_point(cubic(t),deriv(t),z);return p[0]-.44*p[1]-tip
 lo=0.;hi=1.
 for _ in range(55):
  t=(lo+hi)/2
  if gap(t)<0:lo=t
  else:hi=t
 t0=(lo+hi)/2
 ps=[[tip,0]]+[offset_point(cubic(t0+(1-t0)*i/160),deriv(t0+(1-t0)*i/160),z) for i in range(161)]
 ps += [offset_point([(1550+(4200-1550)*i/120)*sf,800*sf],[1,0],z) for i in range(1,121)]
 for i in range(1,61):
  t=i/60;q=[(4200+400*t)*sf,(800-10*smooth(t))*sf];d=[400,-300*t*t*(1-t)*(1-t)]
  p=offset_point(q,d,z)
  if i==60:p[0]=170
  ps.append(p)
 assert all(b[0]>a[0] for a,b in zip(ps,ps[1:])),(z,'nonmonotone offset')
 return ps
zs=[-10,10,16]+[18+.4*i for i in range(31)]+[25,roof]
zs=sorted(set(zs));rings=[]
for z in zs:
 h=half_at(z);rings.append([[q[0],q[1],z] for q in h+[[p[0],-p[1]] for p in h[:0:-1]]])
n=len(rings[0]);points=[q for r in rings for q in r];faces=[]
for k in range(len(rings)-1):
 for i in range(n):
  j=(i+1)%n;a=k*n+i;b=k*n+j;c=(k+1)*n+j;d=(k+1)*n+i;faces.extend([[a,b,c],[a,c,d]])
for k,reverse in [(0,True),(len(rings)-1,False)]:
 center=len(points);points.append([sum(q[i] for q in rings[k])/n for i in range(3)])
 for i in range(n):
  a=k*n+i;b=k*n+(i+1)%n;faces.append([center,b,a] if reverse else [center,a,b])
volume=sum(sum(points[a][k]*(points[b][(k+1)%3]*points[c][(k+2)%3]-points[b][(k+2)%3]*points[c][(k+1)%3]) for k in range(3))/6 for a,b,c in faces)
if volume>0:faces=[f[::-1] for f in faces]
text='// Trimmed normal offsets of one master curve. Bow faces meet in one V.\n'
text+='join_profile='+json.dumps([p+[0] for p in half_at(25)],separators=(',',':'))+';\n'
text+='module belt_full_blank(){polyhedron(points='+json.dumps(points,separators=(',',':'))+',faces='+json.dumps(faces,separators=(',',':'))+',convexity=40);}\n'
text+='module belt_blank(){intersection(){belt_full_blank();multmatrix([[1,0,0,0],[0,1,0,0],[-120/4600,0,1,670*170/4600-.6],[0,0,0,1]]) translate([-20,-50,0]) cube([220,100,60]);}}\n'
Path(__file__).with_name('belt.scad').write_text(text)
Path(__file__).with_name('belt-guides.json').write_text(json.dumps(dict(rings=rings,half_count=len(h),levels=zs),separators=(',',':'))+'\n')
print('Trimmed belt rings:',len(rings),'vertices per ring:',n)
