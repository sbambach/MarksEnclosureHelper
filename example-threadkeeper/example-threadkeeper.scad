include <../hingebox_code.scad>  // uses github.com/h2odragon/MarksEnclosureHelper

hingedbox( box_def );

//my_divs(box_def);
//cutout_top(box_def);
//aslot( 60 );


box_def = [116, 84, 42]; 
wall_thick = 1.2;  
top_rat = 0.15;  
lip_rat= 0.10;  
corner_radius=6;

hinge_points = [0.25, 0.75];
hinge_len = 40; 
hinge_ztnotch=4.4;

catch_points = [0.5];


module decorate_top( d ) { center_scale( d, 0.3)  { translate([3,18,-1]) surface("cymraeg.png");
   }}

module cutout_top(d) {
  translate([(d.x/6),(d.y/4),0])
    hull() {
   
    #cylinder(d=10, h=d.z+1);
    translate([(d.x/1.5),0,0])
    #cylinder(d=10, h=d.z+1);
  }

translate([(d.x/6),(d.y/1.2),0])
    hull() {
   
    #cylinder(d=10, h=d.z+1);
    translate([(d.x/1.5),0,0])
    #cylinder(d=10, h=d.z+1);
  }    
}

module aslot( tl, sz=8 ) {
    hull(){
        #cylinder(d=sz, h=2);
        translate([0,tl,2]) 
        #cylinder(d=sz, h=2);
    }
}
    

module insert_bottom( d ) {
    l=[0.5]; 
    diecut(d){ 
        dividers(d, l, l, d.z);
        } 
      } 
