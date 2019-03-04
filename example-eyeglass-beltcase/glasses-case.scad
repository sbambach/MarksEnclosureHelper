include <../hingebox_code.scad> // uses github.com/h2odragon/MarksEnclosureHelper

hingedbox( box_def );

box_def = [58, 38, 150]; 
wall_thick = 1.5;  
top_rat = 0.04;  
lip_rat= 0.01;  
corner_radius = 16;
corner_fn= 64;

hinge_zrat = 0.9;
hinge_points = [ 0.35, 0.65 ];
hinge_len = 23; 
hinge_xrat = 0.3;
hinge_od=10;
hinge_id=4.0;
hinge_ztnotch = 4.4;
hinge_standoff = 0.2;
hinge_midpoint=0.12;
hinge_basepoint_bottom = 100;
hinge_basepoint_top = 0;

catch_points=[0.5];
catch_wide=0.57;
catch_wide_bottom = 0.9;
catch_thick = 3.0;
catch_inner_thick = wall_thick;
catch_tooth_zrat = 1.02;
catch_tooth_xrat = 0.4;
catch_offset = 0.8;
catch_hole_xtra = 0.8;
catch_foot_xrat = 1;

nametext= "Esme";

module decorate_front( d ) { 
    yd = d.y*0.7; yofs=0;
    xd = d.x-(corner_radius*2);
    //translate( [(d.x/2) - (xd/2), yofs+ ((d.y/2) - (yd/2)), -0.1] )
    translate( [(d.x/2) - (xd/2), yofs+ ((d.y/2) - (yd/2)), -0.1] )
    translate([0,yd,0]) rotate([0,0,-90])
    resize( [yd, xd, wall_thick] ) {
        linear_extrude( height=1) { text( nametext, font="Sans"); } 
    }
}

clip_thick = 5;
clip_high = 60;
clip_loop = false;

module decorate_back(d) {
    bd = [box_def.x -(corner_radius*2), clip_high , hinge_od];
    ypoint = hinge_basepoint_bottom + (clip_thick/2);
    xf = wall_thick; 
    translate( [ ((d.x/2) - (bd.x/2) ) +xf , ypoint -bd.y,0] )
      wartclip( bd, clip_thick );
    if (clip_loop) { // add another, flipped over
      translate( [ ((d.x/2) - (bd.x/2) ) +xf , ypoint -bd.y,0] )
        translate([bd.x,bd.y,0])  rotate([0,0,180]) 
        wartclip( bd, clip_thick );
    } // loop

}

