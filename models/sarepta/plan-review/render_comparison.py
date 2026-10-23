#!/usr/bin/env python3
"""Reproduce this revision's source-construction plan comparison (not STL views)."""
from pathlib import Path
import math
out=Path(__file__).resolve().parent
old=[[286,650],[352,800],[670,800],[1380,800]]
new=[[303.6,690],[600,735],[1100,800],[1550,800]]
def cubic(p,t):
    return [sum(math.comb(3,j)*(1-t)**(3-j)*t**j*p[j][k] for j in range(4)) for k in range(2)]
parts=['<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="980" viewBox="0 0 1200 980">','<rect width="1200" height="980" fill="white"/>','<style>text{font-family:Arial,sans-serif;fill:#333} .label{font-size:20px}.note{font-size:17px}</style>','<text x="40" y="38" font-size="25">Sarepta foredeck plan — parametric comparison</text>','<text x="40" y="67" class="note">Same scale; full-size mm. Construction curves before 50 mm corner rounding.</text>']
sf=.34
for cx,p,title,dash,hatch in [(300,old,'Previous',1400,950),(900,new,'Revised',1600,1200)]:
 def xy(x,y):return (cx+y*sf,825-x*sf)
 half=[[0,0]]+[cubic(p,i/100) for i in range(101)]+[[1800,800]]
 poly=half+[[x,-y] for x,y in reversed(half[1:])]
 coords=' '.join('%.2f,%.2f'%xy(x,y) for x,y in poly)
 parts.append(f'<text x="{cx}" y="115" text-anchor="middle" font-size="24">{title}</text>')
 parts.append(f'<polygon points="{coords}" fill="#eee" stroke="#555" stroke-width="2"/>')
 x0,y0=xy(dash,-560);parts.append(f'<rect x="{x0}" y="213" width="{1120*sf}" height="{y0-213}" fill="white" stroke="#888"/>')
 x0,y0=xy(hatch+250,-225);parts.append(f'<rect x="{x0}" y="{y0}" width="{450*sf}" height="{500*sf}" rx="{55*sf}" fill="white" stroke="#333" stroke-width="2"/>')
 for x,label in [(dash,f'Closed deck: {dash}'),(hatch,f'Hatch centre: {hatch}')]:
  px,py=xy(x,0);parts.append(f'<line x1="{cx-270}" y1="{py}" x2="{cx+270}" y2="{py}" stroke="#aaa" stroke-dasharray="5,5"/>')
  parts.append(f'<text x="{cx}" y="{py-8}" text-anchor="middle" class="note">{label}</text>')
 px,py=xy(p[-1][0],800);parts.append(f'<circle cx="{px}" cy="{py}" r="4" fill="#444"/>')
 parts.append(f'<text x="{cx}" y="875" text-anchor="middle" class="label">Shoulder begins: {p[-1][0]}</text>')
parts+=['<text x="40" y="935" class="note">Forward V angle retained: 132.5°. Lower stem guides and stern arrangement retained.</text>','</svg>'];(out/'comparison.svg').write_text('\n'.join(parts)+'\n')
