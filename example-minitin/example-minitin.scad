include <../hingebox_code.scad> // uses github.com/h2odragon/MarksEnclosureHelper

hingedbox( box_def );

box_def = [60, 35, 20]; 
wall_thick = 1.2;  
top_rat = 0.35;  
lip_rat= 0.05;  

hinge_points = [0.35,0.65];  // yes, they run together
hinge_len = 24; 
hinge_ztnotch = 4.4;

//catch_points=[0.5];


magwart_points = [0.3,0.7];
magwart_zrat = 0.5;

magnet_d =6.3; 
magnet_h =2.3;
magnet_slot_d=0;

magwart_box = [ 
    round( (magnet_d*1.0)+(wall_thick*2) ), 
    round( (magnet_d*1.6)+(wall_thick*2) ),
    round( magnet_h+(wall_thick*2) )  ];


module decorate_top( d ) { center_scale( d, 0.6) { surface("smile.png"); }}

