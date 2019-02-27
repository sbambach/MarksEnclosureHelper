include <../hingebox_code.scad> // uses github.com/h2odragon/MarksEnclosureHelper
include <needlegauge.scad>

hingedbox( box_def );
//my_divs(box_def);


box_def = [190, 35, 20]; 
wall_thick = 1.2;  
top_rat = 0.15;  
lip_rat= 0.10;  

corner_radius=2;

hinge_points = [0.15,0.5, 0.85];
hinge_len = 36; 
hinge_ztnotch = 4.4;


catch_points=[0.5];
catch_wide = 0.2;

module decorate_top(d) {
    rotate([0,0,180]) translate([0-d.x,0-d.y,0])
    translate([d.x/2,(d.y/2)+3,0])
    NeedleGauge();
    
}

module cutout_top(d) {
    ndlx=70; ndly=d.y/5;
    
    translate([(d.x/1.95)-(ndlx/2),(d.y/2.5)-(ndly),0-CS]) cube([ndlx,ndly,d.z+CS2]);
    
}

module insert_bottom(d) { diecut(d) { my_divs(d); }}
    

module my_divs(d ) {
    divisions = [  // y place, label
        [8,  "    8"],
        [16, "  6"],
        [24, "5"],
        [30, "4 & 3"]
    ];
    dxl = d.x * 0.8; // div length
    dxp = (d.x / 2) - dxl/2;
    difference(){
        gang(){
            for (ddef=divisions) {
                rotate([-15,0,0])
                // wall
                translate( [dxp+(dxp*.8),ddef[0],0] ) rotate([0,0,0]) cube( [dxl, wall_thick, d.z ] );
                // text
                rotate([-15,0,0])
                translate([dxp+ddef[0] ,ddef[0]+(wall_thick/3),d.z/3]) rotate([90,0,0])
                linear_extrude(height=wall_thick){ text( ddef[1] );  }
            }
        }//gang
        translate([0,0,0-d.z]) cube([ d.x,d.y,d.z]);
        
    }
}

