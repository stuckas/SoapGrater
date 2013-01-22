include <config.scad>;

// resolution
$fn=100;

module rounded(size,r)  {
	hull() {
		translate([r,r,0]) cylinder(r=r, h=size[2]);
		translate([size[0]-r,r,0]) cylinder(r=r,h=size[2]);
		translate([r,size[1]-r,0]) cylinder(r=r,h=size[2]);
   		translate([size[0]-r,size[1]-r,0]) cylinder(r=r, h=size[2]);
	}
}

module hole(pos) {
	translate([pos[0], pos[1]-1, pos[2]-15]) rotate([90,-90,180]) {
		cylinder(r=5,h=wall_depth+2);
		hull() {
			cylinder(r2=3, r1=3, h=wall_depth+2);
			translate([10,0,0]) cylinder(r2=3, r1=3, h=wall_depth+2);
		}
	}
}


module soap_part() {
	difference() {
		rounded([soap[0]+2*wall_depth,soap[1]+2*wall_depth, height], soap_radius_outer);
		translate ([wall_depth, wall_depth, 0]) rounded(soap, soap_radius_inner);
	}
}

module back_part() {
	translate([0,soap[1]+wall_depth,0]) {
		union() {
			difference() {
				cube([soap[0]+2*wall_depth, back_depth, height]);
				translate([wall_depth,wall_depth,0]) cube([soap[0], back_depth-2*wall_depth, height-wall_depth]);

				hole([(soap[0]+2*wall_depth-distance_screws)/2,back_depth-wall_depth, height-wall_depth]);
				hole([(soap[0]+2*wall_depth+distance_screws)/2,back_depth-wall_depth, height-wall_depth]);
			}
			//translate([0,2*wall_depth,0]) cube([2*wall_depth, back_depth-2*wall_depth, 2*wall_depth]);
			//translate([soap[0],2*wall_depth,0]) cube([2*wall_depth, back_depth-2*wall_depth, 2*wall_depth]);
		}
	}
}

module slider() {
	rotate([-90,0,0]) {
		hull() {
			cylinder(r=(slider_height+slider_extra_space)/2, h=slider_depth+10);
			translate([slider_width-slider_height+slider_extra_space,0,0]) cylinder(r=(slider_height+slider_extra_space)/2, h=slider_depth+10);
		}
	}
}

// all together
rotate([0,180,0])
difference() {
	union() {
		back_part();
		soap_part();
	}
	
	translate([wall_depth+((soap[0]-slider_width+slider_height-slider_extra_space)/2), wall_depth-10,wall_depth]) slider();
}