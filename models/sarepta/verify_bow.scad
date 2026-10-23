// Regression checks: convex bow profiles, smooth aft joins, and planar foredeck.
include <sarepta_hull.scad>
function bez4(p,t) = pow(1-t,4)*p[0]+4*pow(1-t,3)*t*p[1]+
    6*pow(1-t,2)*t*t*p[2]+4*(1-t)*pow(t,3)*p[3]+pow(t,4)*p[4];
function bez3(p,t) = pow(1-t,3)*p[0]+3*pow(1-t,2)*t*p[1]+
    3*(1-t)*t*t*p[2]+pow(t,3)*p[3];
for(k=[0:2]) {
    p=guide_controls[k];
    dp=[for(i=[0:4]) 5*(p[i+1]-p[i])];
    ddp=[for(i=[0:3]) 4*(dp[i+1]-dp[i])];
    assert(abs(dp[4][1])<1e-9 && abs(ddp[3][1])<1e-9,
        "Guide does not join the aft flat with zero curvature");
    for(i=[0:1000]) let(t=i/1000,v=bez4(dp,t),a=bez3(ddp,t)) {
        assert(v[0]>=-1e-8 && v[1]<=1e-8,"Non-monotone bow guide");
        assert(cross2(v,a)>=-1e-6,"Reverse curvature creates a dent");
    }
    echo(guide=k,convex=true,aft_join="zero slope and curvature");
}
for(i=[0:100],j=[0:48]) let(r=3067*i/100,
    g=[guide_point(0,r),guide_point(1,r),guide_point(2,r),sheer_point(r)],
    p=fair_bottom(r,j,g))
    assert(p[2]<=seam_z(p[0]/scale_factor)*scale_factor+1e-7,"Hull protrudes through the seam plane");

// Near-orthographic photo estimate is approximately 132 degrees, not a factory dimension.
outline=deck_outline();
plan_angle=180-2*atan(outline[4][0]/outline[4][1]);
assert(abs(plan_angle-132)<1,"Bow plan rake no longer matches the photographic target");
echo(plan_included_angle_degrees=plan_angle);

// The visible shoulder must be convex in plan, without the previous S-shaped dent.
for(i=[1:999]) let(t=i/1000,h=0.001,
    a=shoulder_inner(t-h),b=shoulder_inner(t),c=shoulder_inner(t+h),
    outer=cubic(shoulder_controls,t)) {
    assert(cross2(b-a,c-b)<=1e-6,"Inward shoulder curvature in plan");
    assert(abs(norm(outer-b)-rim_fullsize_mm)<1e-7,"Uneven shoulder rim");
}
for(k=[0,2]) let(p=guide_controls[k][0],y=k==0?0:625)
    assert(abs((p[0]-0.44*y)/sqrt(1+0.44*0.44)-rim_fullsize_mm)<1e-7,
        "Uneven rim at stem tip");
echo(shoulder_plan="convex",rim_fullsize_mm=rim_fullsize_mm,
    rim_model_mm=rim_fullsize_mm*scale_factor,
    hatch_model_mm=[hatch_length_fullsize_mm,hatch_width_fullsize_mm]*scale_factor);

// Reverse-flared upper sides and the shallow raised foredeck must stay above the seam.
assert(upper_height(0)>0 && upper_height(4600)>upper_height(0),
    "Upper belt must rise towards the stern");
assert(upper_setback(0)>0 && upper_setback(4600)>0,
    "Upper sides must incline inwards");
assert(upper_height(0)*80/4600>deck_mm,"Upper bow cavity closes at the test scale");
assert(foredeck_relief_fullsize_mm>=10 && foredeck_relief_fullsize_mm<=15,
    "Foredeck relief exceeds the requested shallow stamping");
echo(upper_belt_fullsize_mm=[upper_height(0),upper_height(4600)],
    foredeck_relief_model_mm=foredeck_relief_fullsize_mm*scale_factor,
    rib_model_mm=foredeck_rib_fullsize_mm*scale_factor);

assert(abs(seam_z(0)+upper_height(0)-750)<1e-8);
assert(abs(seam_z(4600)+upper_height(4600)-750)<1e-8);
assert(transom_seat_fullsize_mm==375);
assert(cockpit_length_fullsize_mm==2600 && cockpit_width_fullsize_mm==1280);
assert(abs(atan(97.2/650)-8.5)<0.01);
assert(well_floor_z(4600)>100 && well_floor_z(4000)>well_floor_z(4600));
