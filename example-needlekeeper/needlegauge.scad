// copyright (c) 2019 Marie Lamb. Licensed GPLv3 as part of Mark's Enclosure Helper project.
module NeedleGauge() {
$fn=25;
rdxp=-75;
rdn=5;
divisions = [  // y place, label
        [0,  "0 "],
        [8,  "  1  "],
        [16, "     2"],
        [24, "        3"],
        [30, "            4"],
        [36, "                6"],
        [42, "                      8"]
    
    ];
    mirror([1,0,0])
    scale([.5,.5,.5])
    for (rddef=divisions) {
         translate([rdxp+rddef[0],5,1.9]) 
  rotate([180,0,0])
                linear_extrude(height=1){ text( rddef[1] );  }
            }
            
difference() {

scale([1,.25,.015])
    translate([0,-20,0])
cube(80,true);

//size 0 - 2 mm
    translate([35,-10,0])
rotate([0,0,90])
cylinder(10,1,1,true);

//size 1 - 2.25 mm
    
 translate([28,-10,0])
rotate([0,0,90])
cylinder(10,1.125,1.125,true);

//size 2 - 2.75 mm

 translate([19,-10,0])
rotate([0,0,90])
cylinder(10,1.375,1.375,true);

//size 3 - 3.25 mm

 translate([9,-10,0])
rotate([0,0,90])
cylinder(10,1.625,1.625,true);

//size 4 - 3.5 mm

 translate([-2,-10,0])
rotate([0,0,90])
cylinder(10,1.75,1.75,true);

//size 6 - 4.0 mm

 translate([-14,-10,0])
rotate([0,0,90])
cylinder(10,2,2,true);

//size 8 - 5mm
 translate([-28,-10,0])
rotate([0,0,90])
cylinder(10,2.5,2.5,true);


}

}

