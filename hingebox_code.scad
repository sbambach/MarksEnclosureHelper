/* ======================================
    Mark's Enclosure Helper
    https://github.com/h2odragon/MarksEnclosureHelper
    
  the values in this file are reasonable defaults, or blank, for a 
  vanilla enclosure experience. include this file in your OpenSCAD
  script and configure your box there. See included examples.

  We hope you find this code useful; and beg you please to 

                   GIVE US SOME MONEY (pretty please)
                   
                   via paypal:
   https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=J3AY8SM43A2DA&source=url
  
   And we thank you for your support.
   
   Copyright (c) 2019 Mark and Marie Lamb. Distributed under GPLv3, see LICENSE for terms.
   
========================================== */

MEH_VERSION = "20190304";


// ============================== VARIABLES ====================  

// ========== BOX  ========== 

// width (x), depth (y), height (z)
box_def = [60, 30, 30]; 

// wall thickness (all around)
wall_thick = 2;  

// how much height (z) is top (rest is bottom)
top_rat = 0.15;  

// height (z) of lid lip overlap chamfer (0 to disable). 
//  (should be less than top_rat)
lip_rat= 0;  

// box corner radius
corner_radius = 8;  

// box corner $fn
corner_fn = 16;     

//nut inset dia and nut inset thick (depth)  
// used in hinge and screw tower, disable by setting hnut_t = 0
hnut_d = 6; hnut_t = 0; 

// space between hinge parts, top/bottom screw towers
CLEAR=0.6;  

// ========== HINGES ========== 

// height of hinge axis; % of total height (aka dz or box_def[2] )
hinge_zrat = 0.70; 

// points along width (x)  to place hinges, leave empty for none
hinge_points = [ ];  
  
// length of single hinge; splits top/bottom by hinge_xrat
// anything under 10 is probably too delicate to use
hinge_len = 16; 

// how much hinge_len is bottom tower. (>1 taken as a concrete unit)
//   ( the hinge top splits the rest in half, on the outside of the lower hinge)
hinge_xrat = 0.33; 

// if you want to separate the hinge towers from the box body
hinge_standoff = 0; 

// where the hinge leg bends (z), % of hinge height
hinge_midpoint = 0.5; 

// where the hinge leg ends. <1 * lz, >1 taken absolute.
hinge_basepoint_bottom = 0;
hinge_basepoint_top = 0;

// diameter of hinge root cylinder
hinge_root_d = false; // hinge_id;

// the diameter of the outer hinge cylinder
hinge_od = 8; 

// hinge_id of 3.8 to 4.0 works for m3 screw and 4in ziptie
hinge_id = 4.0;  

// size of hole to put through hinge_midpoint; 0 to disble
hinge_mid_hole = 0;


// outer $fn for hinge, and inner $fn for hinge pin hole
// keep outer high; hinges rub the other half of the box without standoff
hinge_ofn = 36;
hinge_ifn = 8;

// Zip tie notches
// if nonzero, take a cubical notch this size from the top hinge outside faces
hinge_ztnotch = 0;

// ========== CATCH CLAPS ========== 

// where to put catch clasps
catch_points = [];

// width of catch clasp (<1 * box_def.x, >1 actual units)
catch_wide = 0.40;

// width of catch clasp bottom (<1 * catch_wide, >1 actual units)
catch_wide_bottom = 0.8;

// width of tooth /  cutout in catch (* catch_wide_bottom)
catch_tooth_xrat = 0.7;

// where on the bottom height the tooth rides
catch_tooth_zrat = 0.9;

// thickness of thicker catch bars; and tooth
catch_thick = false; //wall_thick * 2;

// thickness of catch inner fill
catch_inner_thick = false; //wall_thick;

// $fn for catch corner sphere shapes
catch_fn = 32;

// extra height to take from cutout
catch_hole_xtra = false; //CLEAR;

// space between tooth and catch when closed
catch_offset = false; //CLEAR/2;

// thickness of catch foot piece
catch_foot_thick = false;//catch_thick *2;

// width of foot bar grip piece (* catch_wide_bottom)
catch_foot_xrat = 1.0;

// ========== MAGWARTS ========== 

magwart_points = [];

// as with hinge_zrat; the point at which the magwarts meet in the assembled box
magwart_zrat = 0.5;

// rotation angle for magnet slot. 0 = straight "down", -45 to +45 are likely useful angles.
magwart_slotra = 0;

// how far apart the magnets ride when closed. can be <0 to have the magnets peek out the flats
magwart_offset=false; // 0-CLEAR;

// diameter and height of magnet void (should be 0.3 to 0.6 or so larger than your magnets)
magnet_d =6.3; magnet_h =2.3;

// width of stress relief slot in magwart, 0 to disable
magnet_slot_d = 0.5;

// calculated later, default 
// [round( (magnet_d*1.0)+(wall_thick*2) ), 
//   round( (magnet_d*1.0)+(wall_thick*2) ), 
//   round( magnet_h+(wall_thick*2))]
magwart_box = false;


// ========== SCREW TOWERS ========== 

// points to place screw towers
screw_points = [];

// boolean, do screwtower in the top or bottom half of the box
screwtower_top = true;
screwtower_bottom = true;

// diameters of screw tower
screw_od = 8; screw_id = 3.3;

// factor to multiply screw_od by to brace to wall.
screw_bspread = 1.3;

// how deep the screw hole is (0 for none)
screw_deep = 16;

// $fn for screw tower outside and inside
screw_ofn = 16; screw_ifn = 8;

// reduce the size of the bottom of the screw hole a bit
screw_id_bottom = false; //(screw_id*0.80);

// (bool) have the screw hole go completely through the tower and bottom surface
screw_punchbottom = false;

// height of slot in screw tower (0 to disable feature)
screw_slot_h = 0;

// diameter of slot in screw tower
screw_slot_d = 0;

// extra factor to add to separate slots further or make them closer
// (positive values drive the slots further from each other,
// negative values bring them closer together
screw_slot_xdepth = 0;//(0-CLEAR);

// ========== LAYOUT ========== 

// show ghosts, top/bottom and magnets
VIS=true;  

// extra space between top and bottom for printing
PART_SPACE= 4; 

// ======================================= USER REDEFINES 

// decorate functions are translated and rotated to the appropriate face, and given a 3vec definition of the face's size with a Z of wall_thick. see examples for ways to make use of this.
// inside
module decorate_top( d ) {}
module decorate_bottom( d ) {}

// bottom
module decorate_left( d ) {}
module decorate_right( d ) {}
module decorate_front( d ) {}
module decorate_back( d ) {}

module decorate_top_left( d ) {}
module decorate_top_right( d ) {}
module decorate_top_front( d ) {}
module decorate_top_back( d ) {}

module cutout_top( d ) {}
module cutout_bottom( d ) {}

module cutout_left( d ) {}
module cutout_right( d ) {}
module cutout_front( d ) {}
module cutout_back( d ) {}

module cutout_top_left( d ) {}
module cutout_top_right( d ) {}
module cutout_top_front( d ) {}
module cutout_top_back( d ) {}

module insert_top( d ) {}
module insert_bottom( d) {}

module magwart_shape(d) { qwart(d); }
module catch_tooth_shape( cd, ch, cfn ) { capsule_qtr( cd, ch, cfn ); }


// ======================================== CODE  
// ========================= utilities 

/* =========================
    cyl_grid( d, scl, sz, iv, xfn ) - create a grid of holes, center/scaled to box <d>

    d - [x,y,z] box definition
    scl - factor to scale by; how much space in <d> to fill 
    sz - size (diameter) of cylinder
    iv - space between cylinders
    xfn - cylinder $fn
   ========================= */
module cyl_grid( d, scl, sz, iv, xfn=$fn ) {
    // grid of regular cylinders constrained within scaled space
    sd=d*scl; 
    xdivs=sd.x/(iv);
    ydivs=sd.y/(iv);
    xrt = (d.x*(1.0-scl)/2);
    yrt = (d.y*(1.0-scl)/2);
    for (ix=[0:xdivs]) {
        xpt = ix * iv;
        for (iy=[0:ydivs]) {
            ypt = iy * iv;
            translate( [xrt+xpt,yrt+ypt,0-CS] ) cylinder( d=sz, h=d.z+CS2, $fn=xfn);
        }
    }
}

/* =========================
    routines to to make grids on 1 or both dimensions, 
      constrained to center/scaled portion of box <d>

    slots(d, scl, hsz, t ) 
    yslots(d, scl, hsz, t )
    grid(d, scl, hsz, t )

        d, scl - as above
        hsz - size of hole (gap between walls)
        t - thickness of wall (default wall_thick)

    see dividers() for the sorata the same thing with specified spacings.
   ========================= */
module slots (d, scl, hsz, t=wall_thick ) {
    // vent slots constrained within scaled space
    sd = d*scl;
    iv = hsz;
    xcx = sd.x / iv; 
    xrt = (d.x*(1.0-scl)/2); yrt = (d.y*(1.0-scl)/2);
    for (ix=[0:xcx]) {
        xpt = ix * iv;
        translate( [xrt+xpt,yrt,0]) cube( [t, sd.y, d.z] );
    }
}
module yslots (d, scl, hsz, t=wall_thick ) {
    // vent slots constrained within scaled space
    sd = d*scl;
    iv = hsz;
    xcx = sd.x / iv; ycx = sd.y / iv;
    xrt = (d.x*(1.0-scl)/2); yrt = (d.y*(1.0-scl)/2);
    for (iy=[1:ycx-1]) {
        ypt = iy * iv;
        translate( [xrt,yrt+ypt,0] ) cube( [sd.x, t, d.z] );
    }
}
module grid( d, scl, hsz, t=wall_thick ) {
    th=t/2;
    sd = d*scl;
    iv = hsz;
    xcx = sd.x / iv;  ycx = sd.y / iv;
    xrt = (d.x*(1.0-scl)/2);  yrt = (d.y*(1.0-scl)/2);
    for (ix=[0:xcx]) {
        xpt = ix * iv;
        translate( [xrt+xpt,yrt,0]) cube( [t, sd.y, d.z] );
    }
    for (iy=[0:ycx]) {
        ypt = iy * iv;
        translate( [xrt,yrt+ypt,0-CS] ) cube( [sd.x, t, d.z] );
    }
}

/* =========================
    dividers( d, xdiv, ydiv, h, t ) - create divider walls as defined by xdiv and ydiv lists

    d - 3vec [x,y,z] box definition
    xdiv - list of points along d.x (expressed as fractions thereof) to make dividers <h> high and <t> thick
    ydiv - same for d.y  (either list may be empty.)
    h - height of wall
    t - thickness of wall (defaults to wall_thick)

    example to make 3 dividers: 
        dividers( d, [0.25, 0.75], [0.5], d.z, wall_thick );
   ========================= */
module dividers( d, xdiv, ydiv, h, t=wall_thick ) {
    th=t/2;
    for (i=xdiv) { 
        ip=((i<1)?(d.x*i):i) ;
        translate([(ip-th),0,0]) cube( [t, d.y, h] );
    }
    for (i=ydiv) { 
        ip=((i<1)?(d.y*i):i) ;
        translate([0,(ip-th),0]) cube( [d.x, t, h] );
    }
}

/* =========================
    diecut(d, x) - trims child objects to the base_box shape described by <d>

    d - [x,y,z] box definition
   ========================= */
module diecut( d ){
    // cut children to d sized base_box shell 
    intersection(){
        translate([0,0,0]) base_box( [d.x, d.y, d.z] );
        gang(){ children( [0:1:$children-1] ); };
    }
}

/* =========================
    center_scale( d, scl ) - X/Y centers and scales children in box <d>. NOTE uses resize() so may be slow.

    d - [x,y,z] box definition
    scl - factor by which to multiply d for scaling.

    note Z dimension is NOT scaled
   ========================= */
module center_scale( d, scl ) {
    // centers and scales (x/y) children in the box defined by d 
    translate( [(d.x*((1.0-scl)/2)), (d.y*((1.0-scl)/2)), 0] )
    resize([d.x*scl,d.y*scl, d.z])  children([0:1:$children-1]);
}


/* =====================
    tlen - block length
    dtspec - 5vec [ height, top_width, bottom_width, tpr, tbk] profile of dovetail
    tpr - (=0) taper subtracted from one end. make negative to reverse
    tbk - (=0) point along length to begin tapering off
   ===================== */
module dovetail_rail( tlen, dtspec ) {
    bl=tlen;
    bh = dtspec[0];
    chw_t = dtspec[1];
    chw_b = dtspec[2];
    tpr = (len(dtspec)>3) ? dtspec[3] : 0;
    tbk = (len(dtspec)>4) ? dtspec[4] : 0;
    ih=0.01;  /// all but 2d
    hb = chw_b/2;
    points = [  [0,0], [0,chw_t], [bh, chw_t-hb], [bh,hb], ];    
    mp = chw_t/2;  
    ht = tpr/2;
    ntw = chw_t - ht;
    nbw = (chw_t-chw_b) - ht;
    points2 = [ [0,ht], [0,ntw], [bh, mp+(nbw/2)], [bh, mp-(nbw/2)], ];    
    hull(){
        translate([0,0,bh]) rotate([0,90,0]) 
          linear_extrude(height=ih) {  polygon( points ); }
          if (tbk != 0) {
            translate([tbk,0,bh]) rotate([0,90,0]) 
              linear_extrude(height=ih) {  polygon( points ); }
          }
        translate([bl,0,bh]) rotate([0,90,0]) 
          linear_extrude(height=ih) {  polygon( points2 ); }
    }
}//dovetailrail

/* =====================
    d - block desc (outside of notch)
    dtspec - dovetail profile, see dovetail_rail()

    note: no taper is taken from the notch shape
   ===================== */
module dovetail_block( d, dtspec, clr=CLEAR ) {
    mpy = (d.y/2)- ((dtspec[1]/2) +(clr/2) );
    // note no taper
    ctspec = [ dtspec[0], dtspec[1]+clr, dtspec[2]+clr,  ];
    translate([0,0,0]) rotate([0,0,0]) 
    difference() {
        cube ( d );
        translate([d.x+CS,mpy,d.z+clr]) rotate([0,180,0]) dovetail_rail( d.x+CS2, ctspec );
    }
}

/* =========================
    cd - cylinder diameter
    ch - cylinder height
    cfn=$fn - cylinder $fn
   ========================= */
module cylinder_half( cd, ch, cfn=$fn ) {
    translate([ch,0,0]) rotate([0,-90,0])
    intersection() {
        cube( [cd/2, cd, ch] );
        translate( [0,cd/2,0] ) cylinder( d=cd, h=ch, $fn=cfn );
    }
}
// capsule shape
module capsule( cd, ch, cfn=$fn ) {
    cdh = cd / 2;
    chh = ch /2;
    hull(){ 
        translate([cdh,cdh,cdh]) sphere( d=cd, $fn=cfn );
        translate([cdh,cdh,(ch-cdh)]) sphere( d=cd, $fn=cfn );
    }
}
// quarter it
module capsule_qtr( cd, ch, cfn=$fn ) {
    cdh=cd/2;
    //translate([0,0,0])
    intersection() {
        cube( [cdh, cdh, ch] );
        translate([0,0-cdh,0]) capsule( cd, ch, cfn );
    }
}

/* =========================
    d - bounding box to center in
    btn_d - button diameter
    btn_h - button height
    stalk_d - stalk diameter
    ra - rotation angle
    f - $fn for cylinder shapes
   used by magwart
   ========================= */
module bs_shape( d, btn_d, btn_h, stalk_d, ra=0, f=$fn) {
    bdr = btn_d/2;
    stend = max((d.x+btn_d), (btn_d*2));
    stht= (d.z-btn_h)+CS2;
    hull(){ // button
        translate([bdr,d.y/2,wt]) cylinder( d=btn_d, h=btn_h, $fn=f, center=true );
        rotate([0,0,ra])
        translate([stend-bdr,d.y/2,wt]) cylinder( d=btn_d, h=btn_h, $fn=f, center=true );
    }
    hull() { // stalk
        translate([bdr,d.y/2,d.z/2]) cylinder( d=stalk_d, h=stht, $fn=f, center=true  );
        rotate([0,0,ra])
        translate([stend-bdr,d.y/2,d.z/2]) cylinder( d=stalk_d, h=stht, $fn=f, center=true  );
    }
} //bs_shape


/* =========================
    td - bounding box of shape
    wfn - $fn of sphere that gets quarterd and squished
    dst - 3vec of factors passed to scale()
   ========================= */
module qwart( td, wfn=48, dst=[2,1,2.4]) {
    // qwart shape
    intersection () {
        translate([0,0,0]) cube( [td.x, td.y, td.z] );
        translate([0,td.y/2,0])
          scale( [(td.x*dst.x), (td.y*dst.y), (td.z*dst.z)] ) { sphere(d=1, $fn=wfn); }
    }    
}

/* =========================
    bd - bounding box
    thick - how thick the clip part is (at the top of the bounding box)
    ra - rotation angle to apply to clip body. 0 is parallel, ~ 10 will have the tip touching base level
   ========================= */
module wartclip( bd, thick, ra=0 ) {
    sfn=24; wfn=48;
    th = thick/2;
    qz=thick; wofs=qz;
    pts =[ [qz,qz, -qz], [bd.x-qz, qz, -qz ], [qz,qz, bd.z-qz], [bd.x-qz, qz, bd.z-qz ], ];
    module hpts( pi ){hull(){for (i=pi){translate(pts[i]) sphere( r=qz, $fn=sfn ); }}}
    translate([bd.x,bd.y,0]) rotate([0,0,180]) 
    intersection() { 
        cube( [bd.x, bd.y, bd.z] );
        gang() {
        hpts( [0,1,2,3] );    
        translate([bd.x,wofs,bd.z-qz]) rotate([0,ra,90]) 
          qwart( [bd.y-wofs, bd.x, qz], wfn, [2,1,3.4] );
    }}//intersection
}//wartclip


/* =========================
   ========================= */

// ========================= CODE ENTRY POINT 
//  you can skip this and call hingebox_half as part of your own layout if you like
module hingedbox( bd) {
    dx = bd[0]; dy=bd[1]; dz=bd[2];
    // extra add if magwards or clasps...
    SPC= (hinge_od*1.3)  + hinge_standoff + PART_SPACE;      
    
    hingedbox_half( bd, false ); //bottom
    translate( [0,dy+SPC,0] )  hingedbox_half( bd, true); // top

    if (VIS) { // visualized top and bottom
     translate( [dx,dy+SPC,dz] ) rotate([0,180,0]) %hingedbox_half( bd );    
     translate( [dx,0, dz ] ) rotate([0,180,0])  %hingedbox_half( bd, true);
    }
}

// ======================================== No User Servicable Parts Beyond This Point
// ========================= 
// precalc / alias
bot_rat = 1.0 - top_rat;
wt = wall_thick; wt2 = wt * 2;
CS=0.01; CS2=CS*2; // makes cutouts cleaner in preview
module gang() { children( [0:1:$children-1] ); } // why this is not a builtin i do not know

// these two are inextricably tied together
// =========================
module rim( d ) {
    difference () {
        base_box( d, corner_radius - wt );
        translate( [wt,wt,0-CS]) base_box( [d.x-wt2, d.y-wt2, d.z+CS2] );
    }
}
// =========================
module base_box( d, top_inset=false, f=corner_fn ) {
    b=corner_radius;
    tb= top_inset ? top_inset : b;
    hull() {
        translate( [b,b,0] ) cylinder( r=b, r2=tb, h=d.z, $fn=f );
        translate( [b,d.y-b,0] ) cylinder( r=b, r2=tb,h=d.z, $fn=f  );
        translate( [d.x-b,b,0] ) cylinder( r=b, r2=tb,h=d.z, $fn=f  );
        translate( [d.x-b,d.y-b,0] ) cylinder( r=b, r2=tb,h=d.z, $fn=f  );
    }
}

/* =========================

    hingebox_half( d, topflag=false ) - make the bottom or top half of the box

    d - [x,y,z] box def
    topflag - boolean;  top or not

   ========================= */


// =========================
// If you find this code to be terse, sorry. You should see my C. 
module hingedbox_half( bd, topflag=false ) {

    dx = bd.x; dy=bd.y; dz=bd.z; dxc = dx/2;
    
    // object height   
    lz = (topflag) ? (dz * top_rat) : (dz * bot_rat);

    // hinge lengths
    bhl = (hinge_xrat>1)? hinge_xrat : hinge_len * hinge_xrat;
    thl = ( (hinge_len -bhl) -(CLEAR*2) ) /2;
    // hinge y offset
    hy = (0-hinge_standoff)-(hinge_od/2);
    // hinge local z
    hlz = (topflag) ? (dz * (1.0 - hinge_zrat)) : (dz * hinge_zrat) ;
    hinge_root_d = (hinge_root_d !=false)? hinge_root_d : hinge_id;

    // rim
    lip_h = dz * lip_rat;
    
    // box_def for cutout / decorate 
    side_d = [ dy-wt2, lz-wt2, wt ];
    front_d = [ dx-wt2, lz-wt2, wt ];
    top_d = [dx-wt, dy-wt, wt];
    
    // inserts
    ins_d=[ dx-wt2, dy-wt2, lz-wt2];
    
    // screw towers
    screw_id_bottom = (screw_id_bottom !=false)? screw_id_bottom : (screw_id*0.80);
    stsz = screw_od;
    
    // magwart
    // if the user hasn't set this, calculate
    magwart_box = (magwart_box != false)? magwart_box : ([ 
        round( (magnet_d*1.0)+(wall_thick*2) ), 
        round( (magnet_d*1.0)+(wall_thick*2) ),
        round( magnet_h+(wall_thick*2) )]);
    magwart_offset = (magwart_offset != false)? magwart_offset : 0-CLEAR;
    mgw_z = (topflag?dz*(1.0-magwart_zrat):dz*magwart_zrat) - magwart_box.x;

    // catch clasps
    catch_thick = (catch_thick != false)? catch_thick : (wall_thick*2) ;
    catch_inner_thick = (catch_inner_thick != false )? catch_inner_thick : wall_thick ;
    catch_hole_xtra = (catch_hole_xtra != false)? catch_hole_xtra : CLEAR*2;
    catch_offset = (catch_offset !=false )? catch_offset : CLEAR;
    catch_foot_thick = (catch_foot_thick != false)? catch_foot_thick : catch_thick * 1.5;
    // width and bottom width
    ctw = (catch_wide>1)? catch_wide : (catch_wide * dx);
    ctbw = (catch_wide_bottom>1)? catch_wide_bottom : (catch_wide_bottom * ctw) ;
    // catch tooth z point (on bottom)
    ctzp =  (topflag)? (dz*top_rat)+( (dz*bot_rat)*(1.0-catch_tooth_zrat)) : (dz*bot_rat)*catch_tooth_zrat ;
    // top catch height
    ctth = 0-ctzp;
    // catch tooth length
    ctl = catch_tooth_xrat* (ctbw -(catch_thick*2)); 
    cfl = catch_foot_xrat* (ctbw -(catch_thick*2)); 
    

    // build thing
    difference () {
        gang(){ chopd_body(); body_build(); }
        // final cutouts
        if (topflag) { 
            translate ( [wt,wt,0] ) rotate([0,0,180]) translate([0-dx,0-dy,0]) cutout_top( top_d );
            translate([dx-wt,dy,lz]) rotate([-90,0,0]) rotate([0,90,0]) cutout_top_right( side_d );
            translate([wt,0,lz]) rotate([-90,0,90]) cutout_top_left( side_d );
            translate([0,dy,lz]) rotate([90,180,180]) cutout_top_front( front_d );
            translate([dx,wt,lz]) rotate([90,180,0]) cutout_top_back( front_d );
            // screwtower lid holes
            if (screwtower_top) {for (i=screw_points) { 
                translate( [ dx-(dx*i), (dy-wt)-(stsz/2), 0-CS] ) gang() {
                    cylinder( d=hnut_d, h=hnut_t+CS2, $fn=6);
                    cylinder( d=screw_id, h=(lz-CLEAR)+CS2, $fn=screw_ifn);
                }
            }}
        } else {
            translate( [dx-wt,dy-wt,0] ) rotate([0,0,180]) cutout_bottom( top_d );
            translate([wt,dy,0]) rotate([-90,180,0]) rotate([0,90,0]) cutout_right( side_d );
            translate([dx-wt,0,0]) rotate([90,0,90]) cutout_left( side_d );
            translate([dx,dy-wt,0]) rotate([90,0,180]) cutout_front( front_d );
            translate([0,wt,0]) rotate([90,0,0]) cutout_back( front_d );
            // screwtower
            if (screw_punchbottom) { for (i=screw_points) { 
                translate( [ (dx*i), (dy-wt)-(stsz/2), 0-CS] ) gang() {
                    cylinder( d=hnut_d, h=hnut_t+CS2, $fn=6);
                    cylinder( d=screw_id, h=(lz-CLEAR)+CS2, $fn=screw_ifn);
                }}
            }//punchbottom
        }//topflag
    }// top level difference
    
    // sub modules
    module body_build() { // build interior after first cutout
        if (topflag) {
            // decorate callbacks
            translate([wt,wt,wt]) decorate_top( top_d ); 
            // top sides
            translate([0,0,lz]) rotate([-90,0,90]) decorate_top_left( side_d );
            translate([dx,dy,lz]) rotate([90,180,90]) decorate_top_right( side_d );
            translate([0,dy,lz]) rotate([90,180,180]) decorate_top_front( front_d );
            translate([dx,0,lz]) rotate([90,180,0]) decorate_top_back( front_d );
            // insert
            translate([wt,wt,wt]) rotate([0,0,0]) insert_top( ins_d ); 
            // catch clasps
            for (i=catch_points) {
                translate( [(dx*i)-(ctw/2), dy, catch_thick*2] ) rotate([-90,0,0]) 
                  catch_clasp( ctw, ctbw, ctth, catch_thick );
            }
            // screwtower top inside lid
            if (screwtower_top) {for (i=screw_points) { 
                translate( [ dx-(dx*i), (dy-wt)-(stsz/2), 0] ) 
                difference() {
                    screw_tower( lz, false ); // not doing taper doesnt matter :)
                    cylinder( d=screw_id, h=(lz-CLEAR)+CS2, $fn=screw_ifn);
                }
            }}
            // magwarts
            for (i=magwart_points) {
                translate( [ dx- ((i<1)?(dx*i):i) , dy, mgw_z] ) 
                magwart( magwart_box, 0-magwart_slotra, magwart_offset ) ;
            }
        } else { // bottom
            // decorate callbacks
            translate([wt,wt,wt]) rotate( [0,0,180]) translate( [0-dx,0-dy,0] )
              decorate_bottom( top_d );
            translate([0,dy,0]) rotate([-90,180,0]) rotate([0,90,0]) translate([0,0,0]) decorate_right( side_d );
            translate([dx,0,0]) rotate([90,0,90]) decorate_left( side_d );
            translate([dx,dy,0]) rotate([90,0,180]) decorate_front( front_d );
            translate([0,0,0]) rotate([90,0,0]) decorate_back( front_d );
            // insert
            rotate([0,0,180]) translate( [0-dx,0-dy,0] ) translate([wt,wt,wt]) insert_bottom( ins_d );
            // catch clasps' teeth
            for (i=catch_points) {
                translate( [(dx*i)-(ctl/2), dy, ctzp - ((catch_thick*2)-catch_offset) ] ) 
                rotate([0,90,0]) //translate([0-catch_thick ,0,0]) 
                  catch_tooth_shape( catch_thick*2, ctl, catch_fn );
            }
            // screwtowers bottom inside body
            if (screwtower_bottom) {for (i=screw_points) {
                translate( [ (dx*i), (dy-wt)-(stsz/2), 0] ) screw_tower( lz-(lip_h+CLEAR) );
            }}
            // magwarts
            for (i=magwart_points) {
                translate( [ ((i<1)?(dx*i):i) , dy, mgw_z] ) 
                magwart( magwart_box, magwart_slotra, magwart_offset ) ;
            }
        }
    }// body_build
   
    module chopd_body() {
        difference () {
            base_body();
            // inside hollow
            translate( [wt,wt,wt] ) base_box( [dx - wt2, dy - wt2, lz+dz] );
            if (topflag) { 
                // clean lid inside (trim hinge towers)
                translate( [0,0,lz+lip_h] ) base_box( [dx, dy, lz-(lip_h-wt)] );
                // cutout rim
                rotate([0,180,0]) translate( [0-dx,0,0-(lz+lip_h)] )
                base_box( [dx, dy, lip_h], corner_radius-wt );
            }
        }
    }//chopd_body

    module base_body() {
        // bottom gets lip added later, top gets lip cut out (inside); they do overlap.
        base_box( [dx, dy, ( topflag? lz+lip_h : lz-lip_h )] );
        // hinges
        for (i=hinge_points) {
            hcp = (dx * i);
            if (topflag) { 
                hxofs = (bhl/2) + (CLEAR);
                translate( [hcp + hxofs +thl, hy , hlz] ) rotate([0,-90,0]) hinge( thl, 1 ) ;
                translate( [hcp - hxofs , hy , hlz] ) rotate([0,-90,0]) hinge( thl, -1 ) ;
            } else {
                translate( [hcp - (bhl/2) , hy ,hlz ] ) rotate([0,90,0]) hinge( bhl,  0)  ;
            }
        }
        // rim
        if (!topflag) { translate([0,0,lz-lip_h]) rim( [dx, dy, lip_h] ); }
    }//base_body
    
    module hinge(cl,  ntf=0) {
        // ntf is which face to take nut inset out of
        ofn = hinge_ofn; ifn = hinge_ifn;
        ztn = hinge_ztnotch;
        hbs = (hinge_basepoint_bottom>1)? hinge_basepoint_bottom : hinge_basepoint_bottom * hlz;
        tbs = (hinge_basepoint_top>1)? hinge_basepoint_top : hinge_basepoint_top * hlz;
        lbtm = (hlz - (hinge_id/2));
        lp1 = (topflag) ? (0- (lbtm -tbs)) : lbtm -hbs ;
        module hingept() {
            hull() {
                cylinder( d=hinge_od, h=cl, $fn=ofn); // pin through here
                translate( [lp1* hinge_midpoint,0,0] ) cylinder( d=hinge_od, h=cl ); // middle leg point
            }
            hull () {
                translate( [lp1* hinge_midpoint,0,0] ) cylinder( d=hinge_od, h=cl ); //middle leg point
                translate( [lp1,0,0] ) cylinder( d=hinge_root_d, h=cl ); // bottom outer
                translate( [lp1,0-hy,0] ) cylinder( d=hinge_root_d, h=cl ); //bottom inner
            }
        }
        difference(){
            hingept();
            // hinge pin hole
            translate( [0,0,0-CS]) cylinder( d=hinge_id, h=cl+CS2, $fn=ifn);
            // nut holes
            if (topflag) { 
                if (ntf >0) {translate( [0,0,0-CS] ) cylinder( d=hnut_d, h=hnut_t+CS2, $fn=6 ); }
                if (ntf <0) {translate( [0,0,cl-hnut_t] ) cylinder( d=hnut_d, h=hnut_t+CS2, $fn=6 ); }
            }
            // hinge mid hole
            if (hinge_mid_hole && !topflag) {
                translate( [lp1* hinge_midpoint,0,0-CS] ) cylinder( d=hinge_mid_hole, h=cl+CS2 );
            }
            // hinge ziptie notches
            if ((ztn !=0) && topflag) {
                if (ntf >0) { translate( [0-CS,0-(ztn/2),0] ) cube( [ztn+CS2,ztn,ztn] ); }
                if (ntf <0) { translate( [0-(ztn+CS), 0-(ztn/2), cl-(ztn)] ) cube( [ztn+CS2,ztn,ztn] ); }
            }
        } // difference
    }// hinge

    module screw_tower( tz, dotaper=true ) {
        sh = (screw_od*screw_bspread)/2;
        sb = screw_od/2;
        hdp = max(screw_deep,tz);
        hd1 = dotaper?screw_id_bottom:screw_id;
        difference() {
            hull(){
                cylinder( d=screw_od, h=tz, $fn=screw_ofn );
                translate( [0-sh,0+sb,0] ) cube( [screw_od*screw_bspread,wt,tz] );
            }
            translate([0,0,tz-hdp] ) 
              cylinder( d1=hd1, d2=screw_id, h=hdp+CS, $fn=screw_ifn );
            // magnet slots
            translate([0,0,tz - (wt + screw_slot_xdepth + screw_slot_h )] )
              hull(){
                  cylinder( d=screw_slot_d, h=screw_slot_h );
                  translate([0,0-screw_od,0])
                  cylinder( d=screw_slot_d, h=screw_slot_h );
              }
        } // difference
    }// screw_tower

    module catch_clasp( cw, cwb, ch, ccr ) {
        cfn=catch_fn;
        //base inset
        bi = (cw - cwb) /2;
        zp = 0;
        ym = ch- (ccr*2);
        xm = cw - (ccr*2);
        bir = (cw - (cwb-ccr)) /2;
        points = [ [0,0], [xm, 0],  [(xm - bi), ym], [bi, ym],   ];
        module clbody () {
            // outer
            spbar( points[0], points[1] );
            spbar( points[0], points[3] );
            spbar( points[2], points[1] );
            spbar( points[2], points[3] );
            // cross members
            spbar( points[0], points[2] );
            spbar( points[1], points[3] );
            // fill
            if (catch_inner_thick) {
                translate([ccr,ccr,0]) 
                  linear_extrude( height=catch_inner_thick ){ 
                    polygon(points);
                }
            }
            // nose
            if (catch_foot_thick) {
                cft=catch_foot_thick*2;
                translate( [(cw/2)-(cfl/2),ym,cft/2] ) rotate([0,90,0]) 
                   capsule_qtr( cft, cfl, cfn);
            }
        }//clbody
        module spbar( p1, p2 ) {
            hull() { 
                translate( [ p1[0], p1[1], zp] )  sphalf( ccr );
                translate( [ p2[0], p2[1], zp] )  sphalf( ccr );
            }
        }
        module sphalf( sr ) {
            intersection(){
                cube( [sr*2, sr*2, sr] );
                translate([sr,sr,0]) sphere( r=sr, $fn=cfn );
            }
        }
        // cutout
        il = catch_tooth_xrat* (cwb -(ccr*2));
        ip= (cw/2)-(il/2);
        difference(){
            clbody();
            translate([ip,ch-ccr,0-CS]) cube( [il, ccr+catch_hole_xtra ,ccr+CS2]);
        }
    } // catch_clasp

    module magwart(td, ra=0, bttm=wall_thick ) {
        hfn = 32; // hole fn
        rotate( [-90,90,0] ) translate([0-td.x,0-td.y/2,0]) 
        gang(){ // color("white") %sphere(1); // where's that corner at now?
        difference(){
            magwart_shape( td );
            translate([bttm,0,wt]) 
              bs_shape( [td.x, td.y, td.z], magnet_d, magnet_h, magnet_slot_d, ra, hfn ) ;
        }//diff
        if (VIS){     
            translate( [(magnet_d/2),(td.y/2),wt] ) 
            color("red") %cylinder( d=magnet_d, h=magnet_h ); 
        }} // gang
    }//magwart

}// box_half

// =========================
// =========================


