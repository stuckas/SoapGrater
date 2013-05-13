include <config.scad>;

module hole(pos) {
	translate([pos[0], pos[1]-1, pos[2]-15]) rotate([90,-90,180]) {
		cylinder(r=5,h=wall+2);
		hull() {
			cylinder(r2=3, r1=3, h=wall+2);
			translate([10,0,0]) cylinder(r2=3, r1=3, h=wall+2);
		}
	}
}

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

	// mounting holes
	hole([(soap[0]+2*wall-distance_screws)/2,outer[1]-wall, outer[2]-wall]);
	hole([(soap[0]+2*wall+distance_screws)/2,outer[1]-wall, outer[2]-wall]);
}