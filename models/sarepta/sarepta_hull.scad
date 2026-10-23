// Sarepta hull study, 170 mm overall. Units in the station table are full-size mm.
// See README.md for source provenance and reconstruction limitations.
length_mm = 170;
wall_mm = 1.2;
transom_mm = 2.0;
deck_mm = 1.2;
rim_fullsize_mm = 50;
upper_bow_height_fullsize_mm = 80;
upper_aft_height_fullsize_mm = 200;
upper_bow_inset_fullsize_mm = 40;
upper_aft_inset_fullsize_mm = 50;
foredeck_relief_fullsize_mm = 12.5;
foredeck_rib_fullsize_mm = 15;
hatch_length_fullsize_mm = 500;
hatch_width_fullsize_mm = 450;
hatch_center_fullsize_mm = 950;
hatch_radius_fullsize_mm = 55;
part = "hull"; // [hull, outer, inner, sections]
station_steps = 12;
// Published dimensions use distinct sources; see DIMENSION_RESEARCH.md.
side_height_fullsize_mm = 750;
transom_seat_fullsize_mm = 375;
transom_notch_depth_fullsize_mm = 50; // Photo estimate, not a factory callout.
transom_notch_width_fullsize_mm = 360; // Photo estimate.
cockpit_start_fullsize_mm = 1400; // Reconstructed placement.
cockpit_length_fullsize_mm = 2600;
cockpit_width_fullsize_mm = 1280;
well_start_fullsize_mm = cockpit_start_fullsize_mm+cockpit_length_fullsize_mm;
well_half_width_fullsize_mm = 560; // Reconstructed.
framing = true;
side_corrugations = true;
// Photo-derived placement, not published factory dimensions.
side_ridge_start_fullsize_mm = 1600;
side_ridge_heights_fullsize_mm = [280,425];
chine_flange = true;
function seam_z(x) = side_height_fullsize_mm-upper_height(x);
function well_floor_z(x) = 230-15*(x-well_start_fullsize_mm)/(4600-well_start_fullsize_mm);


scale_factor = length_mm / 4600;
// x runs from bow to stern; y is transverse; z is above the keel baseline.
// Rows: x, then [y,z] for keel, three bottom samples, tunnel crown,
// outer chine, sheer, and deck centre. Stations 1..5 follow the 1974 body plan.
// Longitudinal positions, stem closure and sheer fairing are reconstructed.
// Legacy section samples are retained as research context, not final offsets.
// The final guide grid below uses an inclined seam and a Z=750 upper deck.
stations = [
 [0, [[0,750],[96,750],[192,750],[288,750],[384,750],[625,750],[702,750],[0,750]]],
 [460, [[0,220],[96,325],[192,433],[288,560],[384,687],[625,506],[702,735],[0,790]]],
 [920, [[0,33],[108,92],[216,169],[324,271],[432,383],[640,270],[790,750],[0,802]]],
 [1380,[[0,0],[110,35],[219,76],[329,135],[438,211],[640,136],[800,750],[0,794]]],
 [1840,[[0,0],[110,28],[219,61],[329,99],[438,142],[640,105],[800,750],[0,780]]],
 [2300,[[0,0],[110,27],[219,53],[329,80],[438,105],[650,100],[800,750],[0,770]]],
 [3067,[[0,0],[110,16.4],[219,32.7],[329,49.2],[438,65.5],[650,97.2],[800,750],[0,765]]],
 [4200,[[0,0],[110,16.4],[219,32.7],[329,49.2],[438,65.5],[650,97.2],[800,750],[0,765]]],
 [4600,[[0,0],[110,16.4],[219,32.7],[329,49.2],[438,65.5],[650,97.2],[790,750],[0,765]]]
];

function d(i,j,k) = (stations[i+1][1][j][k]-stations[i][1][j][k]) /
                         (stations[i+1][0]-stations[i][0]);
function tangent(i,j,k) =
 i==0 ? d(0,j,k) : i==len(stations)-1 ? d(i-1,j,k) :
 let(a=d(i-1,j,k), b=d(i,j,k)) a*b<=0 ? 0 :
 sign(a)*min(abs((a+b)/2),2*abs(a),2*abs(b));
function blend(i,t,j,k) = let(h=stations[i+1][0]-stations[i][0])
 (2*t*t*t-3*t*t+1)*stations[i][1][j][k] +
 (t*t*t-2*t*t+t)*h*tangent(i,j,k) +
 (-2*t*t*t+3*t*t)*stations[i+1][1][j][k] +
 (t*t*t-t*t)*h*tangent(i+1,j,k);
function half_section(i,t) = [for(j=[0:7])
 [blend(i,t,j,0)*scale_factor,blend(i,t,j,1)*scale_factor]];
function outer_ring(p) = concat(
 [for(j=[6:-1:1]) [-p[j][0],p[j][1]]],
 [for(j=[0:7]) p[j]]);
function cross2(a,b) = a[0]*b[1]-a[1]*b[0];
function normal(v) = [-v[1],v[0]]/norm(v);
// Mitered inward offset of the open bottom/side polyline in the YZ plane.
function inset(p,j,w) =
 j==0 ? p[j]+w*normal(p[1]-p[0]) :
 j==len(p)-1 ? p[j]+w*normal(p[j]-p[j-1]) :
 let(a=p[j]-p[j-1],b=p[j+1]-p[j],na=normal(a),nb=normal(b),
     den=cross2(a,b))
 abs(den)<0.000001 ? p[j]+w*na :
 p[j]+w*na+a*(cross2(w*(nb-na),b)/den);
function inner_ring(p) = let(bottom=concat(
 [for(j=[6:-1:1]) [-p[j][0],p[j][1]]],
 [for(j=[0:6]) p[j]]), q=[for(j=[0:len(bottom)-1]) inset(bottom,j,wall_mm)])
 concat(q,[[q[len(q)-1][0],60],[q[0][0],60]]);

// Convex quintic Bezier guide curves: centre stem, tunnel crown, outboard stem.
// All three have horizontal first and second derivatives at the aft endpoint.
// Full-size reconstruction coordinates, fitted approximately to the body plan.
function shifted_controls(p,start) = [for(q=p)
    [p[5][0]-(p[5][0]-q[0])*(p[5][0]-start)/(p[5][0]-p[0][0]),q[1]]];
// A 50 mm perpendicular setback also continues along the two straight bow edges.
bow_inset_x=rim_fullsize_mm*sqrt(1+0.44*0.44);
guide_controls = [
    shifted_controls([[0,seam_z(bow_inset_x)],[0,445],[298.958581,241.850206],
        [818.67287,0],[930.073765,0],[1380,0]],bow_inset_x),
    [[464.0,seam_z(464)],[464.0,seam_z(464)-5.165452],[1073.113065,200.924939],
        [1373.660044,65.5],[2754.543723,65.5],[3067.0,65.5]],
    shifted_controls([[295,seam_z(0.44*625+bow_inset_x)],[295,550],[886.016721,290.176633],
        [1217.401932,97.2],[1485.812619,97.2],[2300,97.2]],0.44*625+bow_inset_x)
];
function bezier5(p,t) = pow(1-t,5)*p[0]+5*pow(1-t,4)*t*p[1]+
    10*pow(1-t,3)*t*t*p[2]+10*pow(1-t,2)*pow(t,3)*p[3]+
    5*(1-t)*pow(t,4)*p[4]+pow(t,5)*p[5];
function curve_parameter(p,x,lo=0,hi=1,n=0) = x<=p[0][0] ? 0 : x>=p[5][0] ? 1 :
    n==34 ? (lo+hi)/2 :
    let(t=(lo+hi)/2) bezier5(p,t)[0]<x ? curve_parameter(p,x,t,hi,n+1) :
    curve_parameter(p,x,lo,t,n+1);
function smooth5(t) = let(u=max(0,min(1,t))) u*u*u*(10-15*u+6*u*u);
function guide_point(k,r) = let(p=guide_controls[k],start=p[0][0],end=p[5][0],
    x=r<end ? start+(end-start)*r/end : r,
    z=r<end ? bezier5(p,curve_parameter(p,x))[1] : p[5][1],
    y=k==0?0 : k==1?384+54*smooth5(r/1380) : 625+25*(1-pow(1-min(r/2300,1),3)))
    [x,y,z];
// One convex cubic shoulder replaces the S-shaped plan-view sheer.
// The deck edge is the master curve; the hull sheer is its normal inward offset.
shoulder_controls=[[286,650],[352,800],[670,800],[1380,800]];
function cubic(p,t) = pow(1-t,3)*p[0]+3*pow(1-t,2)*t*p[1]+
    3*(1-t)*t*t*p[2]+pow(t,3)*p[3];
function cubic_tangent(p,t) = 3*(pow(1-t,2)*(p[1]-p[0])+
    2*(1-t)*t*(p[2]-p[1])+t*t*(p[3]-p[2]));
function shoulder_inner(t) = let(p=cubic(shoulder_controls,t),
    v=cubic_tangent(shoulder_controls,t))
    p+rim_fullsize_mm*[v[1],-v[0]]/norm(v);
function sheer_point(r) = let(p=r<1380 ? shoulder_inner(r/1380) :
    [r, r<4200 ? 800-rim_fullsize_mm :
    800-rim_fullsize_mm-10*smooth5((r-4200)/400)]) [p[0],p[1],seam_z(p[0])];
function half_surface(r,k,g) = let(c=g[0],t=g[1],b=g[2],s=g[3])
    k<=16 ? let(u=k/16,v=u*(1-0.14*(1-smooth5(r/2300))*(1-u)),p=c+(t-c)*v)
        [p[0],c[1]+(t[1]-c[1])*u,p[2]] :
    k<=20 ? t+(b-t)*(k-16)/4 : b+(s-b)*(k-20)/4;
function fair_bottom(r,j,g) = let(k=abs(j-24),p=half_surface(r,k,g))
    [p[0]*scale_factor,(j<24?-p[1]:p[1])*scale_factor,p[2]*scale_factor];

// Share the final exterior grid with the cavity so plan edits cannot expose it.
fair_rows=concat([for(i=[0:180]) 3067*i/180],
    [for(i=[1:36]) 3067+(4600-3067)*i/36]);
fair_guides=[for(r=fair_rows) [guide_point(0,r),guide_point(1,r),guide_point(2,r),sheer_point(r)]];
fair_points=[for(i=[0:len(fair_rows)-1],j=[0:48])
    fair_bottom(fair_rows[i],j,fair_guides[i])];

rings = concat([for(i=[0:len(stations)-2]) let(steps=i==0?48:station_steps)
    for(s=[0:steps-1])
 [ (stations[i][0]+(stations[i+1][0]-stations[i][0])*s/steps)*scale_factor,
   half_section(i,s/steps)]],
 [[length_mm,[for(p=stations[len(stations)-1][1]) p*scale_factor]]]);

// The bottom surface retains its three bow edges. A separate planar sheet
// closes their upper gaps and creates the continuous deck outline.
function top_index(i,j,m,n) = (i==0 || j==0 || j==n-1) ? i*n+j :
    m*n+(i-1)*(n-2)+j-1;
module loft(inner=false) {
    rr = inner ? [for(r=rings) if(r[0]>=length_mm*0.15) [r[0],inner_ring(r[1])]] :
                 [for(r=rings) [r[0],outer_ring(r[1])]];
    m=len(rr);
    if(inner) {
        cavity=[for(i=[0:len(fair_rows)-1]) if(fair_rows[i]>=690)
            let(b=[for(j=[0:48]) fair_points[i*49+j]],
                yz=[for(p=b) [p[1],p[2]]],
                q=[for(j=[0:48]) inset(yz,j,wall_mm)])
            concat([for(j=[0:48]) [b[j][0],q[j][0],q[j][1]]],
                   [[b[48][0],q[48][0],60],[b[0][0],q[0][0],60]])];
        n=len(cavity[0]);m=len(cavity);
        pp=[for(row=cavity,p=row) p];
        ff=concat([[for(j=[n-1:-1:0]) j]],
            [for(i=[0:m-2],j=[0:n-1]) each
             [[i*n+j,i*n+(j+1)%n,(i+1)*n+(j+1)%n],
              [i*n+j,(i+1)*n+(j+1)%n,(i+1)*n+j]]],
            [[for(j=[0:n-1]) (m-1)*n+j]]);
        polyhedron(points=pp,faces=[for(f=ff) [for(j=[len(f)-1:-1:0]) f[j]]],convexity=12);
    } else {
        n=49;
        outer_rows=fair_rows;
        m=len(outer_rows);
        bottom=fair_points;
        top=[for(i=[1:m-1],j=[1:n-2]) let(p=bottom[i*n+j])
            [p[0],p[1],seam_z(p[0]/scale_factor)*scale_factor]];
        ff=concat(
            [for(i=[0:m-2],j=[0:n-2]) each
                [[i*n+j,i*n+j+1,(i+1)*n+j+1],
                 [i*n+j,(i+1)*n+j+1,(i+1)*n+j]]],
            [for(i=[0:m-2],j=[0:n-2]) let(
                a=top_index(i,j,m,n),b=top_index(i,j+1,m,n),
                c=top_index(i+1,j,m,n),d=top_index(i+1,j+1,m,n)) each
                [[a,c,d],[a,d,b]]],
            [concat([for(j=[0:n-1]) (m-1)*n+j],
                    [for(j=[n-2:-1:1]) top_index(m-1,j,m,n)])]);
        polyhedron(points=concat(bottom,top),
            faces=[for(f=ff) [for(j=[len(f)-1:-1:0]) f[j]]],convexity=12);
    }
}

// Photo-matched plan rake: approximately 24 degrees per front edge, giving
// a 132-degree included angle. The tunnels remain below this planar sheet.
function deck_outline() = let(half=concat(
    [[0,0],[79.2,180],[162.8,370],[233.2,530],[286,650]],
    [for(i=[1:80]) cubic(shoulder_controls,i/80)],
    [[4200,800]],
    [for(i=[1:20]) [4200+400*i/20,800-10*smooth5(i/20)]]))
    concat([for(p=half) p*scale_factor],
        [for(i=[len(half)-1:-1:1]) [half[i][0]*scale_factor,-half[i][1]*scale_factor]]);
// The seam is an inclined plane; the upper deck datum remains Z=750 full-size.
module on_seam(dz=0) {
    slope=-(upper_aft_height_fullsize_mm-upper_bow_height_fullsize_mm)/4600;
    multmatrix([[1,0,0,0],[0,1,0,0],
        [slope,0,1,seam_z(0)*scale_factor+dz],[0,0,0,1]]) children();
}
module foredeck_sheet() {
    on_seam(-deck_mm) linear_extrude(height=deck_mm) polygon(deck_outline());
}
// Clockwise plan polygon: a negative left-normal offset moves inwards.
function plan_inset(p,j,w) = let(q=concat([p[len(p)-1]],p,[p[0]]))
    let(v=inset(q,j+1,-w))
    abs(p[j][0]-length_mm)<1e-6 ? [length_mm,v[1]] : v;
function upper_height(x) = upper_bow_height_fullsize_mm+
    (upper_aft_height_fullsize_mm-upper_bow_height_fullsize_mm)*x/4600;
function upper_setback(x) = upper_bow_inset_fullsize_mm+
    (upper_aft_inset_fullsize_mm-upper_bow_inset_fullsize_mm)*x/4600;
function upper_plan(inner=false) = let(p=deck_outline()) [for(j=[0:len(p)-1])
    let(w=rim_fullsize_mm*scale_factor+upper_setback(p[j][0]/scale_factor)*scale_factor+
        (inner?wall_mm:0)) plan_inset(p,j,w)];
function upper_roof_z(x) = side_height_fullsize_mm*scale_factor;

// Convex envelope between the inclined seam and the level inset gunwale. Native
// planar sections avoid nearly coincident triangulation along the curved seam.
module upper_volume(inner=false) {
    p=deck_outline();n=len(p);
    base=[for(j=[0:n-1]) plan_inset(p,j,rim_fullsize_mm*scale_factor+(inner?wall_mm:-0.08))];
    top=upper_plan(inner);
    hull() {
        on_seam(-(inner?deck_mm+0.1:deck_mm/2))
            linear_extrude(height=0.02) polygon(base);
        translate([0,0,upper_roof_z(0)-(inner?deck_mm:0)-0.02])
            linear_extrude(height=0.02) polygon(top);
    }
}
module upper_inner() {
    intersection() {
        upper_volume(true);
        translate([-1,-40,-1]) cube([length_mm-transom_mm+1,80,62]);
    }
}
module upper_shell() { difference() { upper_volume(); upper_inner(); } }

// Embossed foredeck details follow the level roof plane.
module on_foredeck() {
    translate([0,0,upper_roof_z(0)]) scale(scale_factor) children();
}
module foredeck_details() {
    on_foredeck() {
        translate([0,0,-0.5]) linear_extrude(height=foredeck_relief_fullsize_mm+0.5)
            offset(r=18,$fn=32) offset(delta=-18)
                polygon([[420,0],[565,285],[1370,285],[1370,-285],[565,-285]]);
        for(side=[-1,1],i=[0:23]) let(
            path=[[620,465],[810,505],[1080,525],[1320,525]],
            a=cubic(path,i/24),b=cubic(path,(i+1)/24))
            hull() for(q=[a,b]) translate([q[0],side*q[1],0])
                scale([19,19,foredeck_rib_fullsize_mm]) sphere(r=1,$fn=16);
    }
}
module lower_exterior() { union() { loft(); foredeck_sheet(); } }
module exterior() { union() { lower_exterior(); upper_shell(); foredeck_details(); } }

// Rounded rectangular opening through the raised detail and upper deck.
module hatch_opening() {
    r=hatch_radius_fullsize_mm*scale_factor;
    translate([hatch_center_fullsize_mm*scale_factor,0,
               upper_roof_z(0)-deck_mm-0.2])
        linear_extrude(height=60)
            offset(r=r,$fn=48)
                square([(hatch_length_fullsize_mm-2*hatch_radius_fullsize_mm)*scale_factor,
                        (hatch_width_fullsize_mm-2*hatch_radius_fullsize_mm)*scale_factor],center=true);
}

// The cavity follows the same guide grid as the exterior after each plan edit.
module safe_inner() { loft(true); }

// Cavities are bounded independently of the upper sides. A complete forward
// partition isolates the hatch-accessed bow locker from the cockpit.
module interior_space() {
    difference() {
        intersection() {
            union() {
                intersection() { safe_inner(); translate([0,0,-deck_mm+0.05]) lower_exterior(); }
                upper_inner();
            }
            translate([690*scale_factor,-40,-1])
                cube([(well_start_fullsize_mm-690)*scale_factor,80,62]);
        }
        translate([cockpit_start_fullsize_mm*scale_factor-wall_mm,-40,-1])
            cube([wall_mm,80,62]);
    }
}
module motorwell_cut() {
    // Raised, gently draining floor: height and slope are explicitly estimated.
    slope=-15/(4600-well_start_fullsize_mm);
    multmatrix([[1,0,0,0],[0,1,0,0],
        [slope,0,1,(230-slope*well_start_fullsize_mm)*scale_factor],[0,0,0,1]])
        translate([well_start_fullsize_mm*scale_factor+wall_mm,
            -well_half_width_fullsize_mm*scale_factor,0])
            cube([length_mm-well_start_fullsize_mm*scale_factor-wall_mm-transom_mm,
                2*well_half_width_fullsize_mm*scale_factor,60]);
}
module transom_top_cut() {
    // 375 mm is the central motor seat, not the higher notch shoulders.
    for(v=[[well_half_width_fullsize_mm,transom_seat_fullsize_mm+transom_notch_depth_fullsize_mm],
           [transom_notch_width_fullsize_mm/2,transom_seat_fullsize_mm]])
        translate([length_mm-transom_mm-0.01,-v[0]*scale_factor,v[1]*scale_factor])
            cube([transom_mm+0.1,2*v[0]*scale_factor,60]);
}
module body_blank() { union() { lower_exterior(); upper_volume(); foredeck_details(); } }
module framing_members() {
    // Early T-profile interpretation. Frame locations are reconstructed, not
    // inferred from the later production variant's raised Pi-section floors.
    floor_top=220*scale_factor;
    web=max(0.65,2*scale_factor);
    depth=max(0.65,28*scale_factor);
    intersection() {
        // Clip slightly into the plating for a positive-volume joint.
        translate([0.07,0,0.035]) body_blank();
        union() {
            // Five transverse floors with open centres above the floor webs;
            // side webs continue up the inside of the lower sides.
            for(x=[1700,2200,2700,3200,3700])
                translate([x*scale_factor-web/2,0,0]) difference() {
                    translate([0,-800*scale_factor,0])
                        cube([web,1600*scale_factor,seam_z(x)*scale_factor]);
                    translate([-0.1,-620*scale_factor,floor_top])
                        cube([web+0.2,1240*scale_factor,60]);
                }
            // Longitudinal bottom stiffeners, connected through the floors.
            for(y=[-350,0,350])
                translate([1450*scale_factor,y*scale_factor-web/2,0])
                    cube([(well_start_fullsize_mm-1450)*scale_factor,web,
                        wall_mm+depth+abs(y)*tan(8.5)*scale_factor]);
            // Three transom knees connect the rear panel to the well structure.
            for(y=[-350,0,350])
                translate([length_mm-transom_mm-200*scale_factor,y*scale_factor-web/2,0])
                    rotate([90,0,0]) linear_extrude(height=web)
                        polygon([[0,0],[200*scale_factor,0],
                            [200*scale_factor,375*scale_factor],[0,215*scale_factor]]);
        }
    }
}
module chine_spray_flange() {
    // One continuous swept strip avoids overlapping coplanar segment caps.
    thick=max(0.35,2*scale_factor);
    rr=[for(i=[6:len(fair_rows)-1]) fair_rows[i]];
    m=len(rr);
    for(side=[-1,1]) let(pp=[for(r=rr) let(
        p=guide_point(2,r)*scale_factor,w=30*scale_factor*smooth5(r/700))
        each [[p[0],side*(p[1]-0.10),p[2]-thick/2],
              [p[0],side*(p[1]+w),p[2]-thick/2],
              [p[0],side*(p[1]+w),p[2]+thick/2],
              [p[0],side*(p[1]-0.10),p[2]+thick/2]]],
        ff=concat([[3,2,1,0]],
            [for(i=[0:m-2],j=[0:3]) each
                [[i*4+j,i*4+(j+1)%4,(i+1)*4+(j+1)%4],
                 [i*4+j,(i+1)*4+(j+1)%4,(i+1)*4+j]]],
            [[for(j=[0:3]) (m-1)*4+j]]))
        polyhedron(points=pp,
            faces=side==1 ? [for(f=ff) [for(j=[len(f)-1:-1:0]) f[j]]] : ff,
            convexity=12);
}
// Intersect the ruled side surface with a horizontal plane. Using a fixed
// fraction between chine and seam incorrectly bent the ridges up at the bow.
function side_at_height(r,z) = let(b=guide_point(2,r),s=sheer_point(r),
    u=(z-b[2])/(s[2]-b[2])) b+(s-b)*u;
function side_height_parameter(x,z,lo=800,hi=4600,n=0) =
    n==34 ? (lo+hi)/2 : let(r=(lo+hi)/2)
    side_at_height(r,z)[0]<x ? side_height_parameter(x,z,r,hi,n+1) :
        side_height_parameter(x,z,lo,r,n+1);
function side_ridge_center(x,z) = let(r=side_height_parameter(x,z),
    p=side_at_height(r,z)) [x,p[1],z];
module pressed_side_ridges() {
    // Horizontal centrelines with flat forward ends and flush transom ends.
    // Only Y follows the side plating; Z is constant over the entire length.
    m=65;n=12;
    depth=max(0.16,10*scale_factor);
    half_height=max(0.3,16*scale_factor);
    for(side=[-1,1],z=side_ridge_heights_fullsize_mm) let(
        pp=[for(i=[0:m-1]) let(
            x=side_ridge_start_fullsize_mm+
                (4600-side_ridge_start_fullsize_mm)*i/(m-1),
            p=side_ridge_center(x,z)*scale_factor)
            for(j=[0:n-1]) [p[0],side*(p[1]+depth*cos(360*j/n)),
                p[2]+half_height*sin(360*j/n)]],
        ff=concat([[for(j=[n-1:-1:0]) j]],
            [for(i=[0:m-2],j=[0:n-1]) each
                [[i*n+j,i*n+(j+1)%n,(i+1)*n+(j+1)%n],
                 [i*n+j,(i+1)*n+(j+1)%n,(i+1)*n+j]]],
            [[for(j=[0:n-1]) (m-1)*n+j]]))
        polyhedron(points=pp,
            faces=side==1 ? [for(f=ff) [for(j=[len(f)-1:-1:0]) f[j]]] : ff,
            convexity=12);
}
module boat_hull() {
    difference() {
        union() {
            difference() {
                body_blank();
                interior_space();
                // Open cockpit of published size; longitudinal placement is estimated.
                on_seam(-deck_mm-0.2)
                    translate([cockpit_start_fullsize_mm*scale_factor,
                        -cockpit_width_fullsize_mm*scale_factor/2,0])
                        cube([cockpit_length_fullsize_mm*scale_factor,
                            cockpit_width_fullsize_mm*scale_factor,60]);
            }
            if(framing) framing_members();
            if(side_corrugations) pressed_side_ridges();
            if(chine_flange) intersection() {
                chine_spray_flange();
                translate([0,-40,0]) cube([length_mm,80,60]);
            }
        }
        hatch_opening();
        motorwell_cut();
        transom_top_cut();
    }
}

assert(length_mm>=80 && length_mm<=180,"Expected an 80..180 mm model.");
assert(wall_mm>=0.8 && wall_mm<=2,"Wall thickness outside the studied range.");
if(part=="hull") color([0.72,0.77,0.79]) boat_hull();
else if(part=="outer") exterior();
else if(part=="inner") safe_inner();
else if(part=="sections")
    // Intersect the current final solid; the old station table is not an
    // independently dimensioned factory offset table.
    for(x=[900,1400,2300,3067,4200,4595])
        intersection() {
            boat_hull();
            translate([x*scale_factor,-40,-1]) cube([0.2,80,62]);
        }
else assert(false,"Unknown part selector.");
