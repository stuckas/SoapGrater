include <config.scad>;

difference() {
	cube(outer);

	// soap
	#translate([wall,wall,0]) cube(soap);

	// slider
	#translate([(outer[0]-slider[0]-slider_extra_space)/2,0,wall])
		cube([slider[0]+slider_extra_space, 
			slider[1], 
			slider[2]+slider_extra_space]);

	// back hole
	translate([wall, soap[1]+2*wall, 0])
		cube([soap[0],
			outer[1]-soap[1]-3*wall,
			outer[2]-wall]);
}