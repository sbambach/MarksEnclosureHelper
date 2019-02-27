include <../hingebox_code.scad> // uses github.com/h2odragon/MarksEnclosureHelper

hingedbox( box_def );

box_def = [60, 60, 30]; 
wall_thick = 1.2;  
top_rat = 0.15;  
lip_rat= 0.05;  
corner_radius=6;

hinge_points = [0.5,];
hinge_len = 36; 
hinge_xrat = 0.4;
hinge_zrat = 0.5;
hinge_ztnotch = 4.4;

catch_points = [0.5];
catch_thick = 2;
catch_tooth_zrat = 0.8;
catch_wide= 0.4;
catch_wide_bottom = 0.7;

// length of dovetail shape
dtlen = 16;
// clearance for the dovetail notch
dt_CLEAR = 1.5;
// dovetail profile: height, top width, bottom width, taper, taper_point
dtspec = [ 4, 14, 6, 3, dtlen*0.85 ];
// extra thickness around block 
bthick = 6;
// block that recives dovetail 
dtblock = [dtlen, dtspec[1]+(bthick*2)+(dt_CLEAR), (dtspec[0])];

module decorate_top( d ) { center_scale( d, 0.6) { surface("screw-icon.png"); } }
// comment out above, uncomment the following two lines if you want the image on the outside
//module cutout_top( d ) { center_scale( d, 0.6) { surface("screw-icon.png"); } }
//module decorate_top( d ) { center_scale( d, 0.8) { cube(1,1,1); } } // add extra material

module insert_bottom( d ) { diecut(d){ 
    dividers(d, [], [0.6], d.z*0.7);
}}

module decorate_left( d ) { mydttng(d); }
module decorate_right( d ) { mydtnotch(d); }

module mydttng(d) {  
    cp = (box_def.y/2) - (dtspec[1]/2);
    translate( [cp,0,0] )
    //translate( [dtspec[1],0,0]) rotate([0,0,90])  // taper up
    translate( [0,dtlen,0]) rotate([0,0,270]) // taper down
    dovetail_rail( dtlen, dtspec ); 
}

module mydtnotch(d) {
    cp = (box_def.y/2) - (dtblock[1]/2);
    translate( [cp,0,0] )
    translate( [dtblock[1],0,0]) rotate([0,0,90])
     dovetail_block( dtblock, dtspec, dt_CLEAR );
}
