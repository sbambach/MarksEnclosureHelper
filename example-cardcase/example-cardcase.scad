include <../hingebox_code.scad>  // uses github.com/h2odragon/MarksEnclosureHelper

hingedbox( box_def );
//cutout_front( box_def);
   
box_def = [120, 80, 40];     
wall_thick = 1.2;  
top_rat = 0.15;  
lip_rat= 0.0;  
corner_radius = 5;

hinge_points = [0.25,0.75];
hinge_len = 42; 
hinge_zrat=0.65;
hinge_ztnotch = 4.4;

catch_points = [ 0.5 ];

slot_point= 23;

// fugly but functional
module decorate_top_front( d ) { 
    xc = slot_point;
    bw = 28;  // bottom 
    uw = 28;  // upper 
    bp = -9; // base point
    tp = 0- (box_def.z - ( 8+ ( uw/2)) ); // top point
    hull(){
        translate([xc,bp, 0 ]) cylinder(d=bw, h=d.z);
        translate([xc,tp, 0]) cylinder(d=uw, h=d.z);
     }
}
module cutout_front( d ) {
    xc = slot_point;
    bw = 17;  // bottom 
    uw = 23;  // upper 
    bp = 3+ (bw/2); // base point
    tp = d.y ; // top point
    hull(){
        translate([xc,bp, 0-CS ]) cylinder(d=bw, h=d.z+CS2);
        translate([xc,tp, 0-CS]) cylinder(d=uw, h=d.z+CS2);
     }
}

