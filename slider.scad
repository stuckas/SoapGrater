include <config.scad>;

$fn=10;

module dent() {
	difference() {
		translate([-dent_width/2,0,0]) cube([dent_width*3/2,dent_depth,dent_height]);
		translate([dent_width,0,0]) rotate([0,90-dent_beta,0]) translate([-2*dent_width,0,0]) cube([3*dent_width,dent_depth,dent_height]);
		rotate([0,90-dent_alpha,0]) translate([-3*dent_width,0,-dent_height*5]) cube([3*dent_width,dent_depth,dent_height*5]);
	}
}

adjust_x=0;
adjust_y=1;

union() {
	intersection() {
		union() {
			for (j=[0:6])
				for (i=[1:5]) {
					translate([i*(dent_inter_space+dent_width)+adjust_x,j*(2*dent_depth-dent_overlapp)-(i%2)*(dent_depth-dent_overlapp/2)+adjust_y,0]) dent();
				}
			translate([0,0,-(slider_height-dent_height)]) 
				difference() {
					cube([slider_depth,slider_width,(slider_height-dent_height)]);
					for (j=[0:6])
						for (i=[1:5]) {
							translate([i*(dent_inter_space+dent_width)-dent_inter_space+adjust_x,j*(2*dent_depth-dent_overlapp)-(i%2)*(dent_depth-dent_overlapp/2)+adjust_y,0]) cube([dent_inter_space,dent_depth,(slider_height-dent_height)]);
						}
				}
		}
		translate([0,0,-(slider_height-dent_height)]) cube([slider_depth,slider_width,slider_height]);
	}
	// side rounded parts
	translate([0,0,-dent_height/2]) rotate([0,90,0]) difference() { 
		cylinder(r=slider_height/2, h=slider_depth);
		translate([-slider_height/2,0,0]) cube([slider_height, slider_height/2, slider_depth]);
	}
	translate([0,slider_width,-dent_height/2]) rotate([0,90,0]) difference() { 
		cylinder(r=slider_height/2, h=slider_depth);
		translate([-slider_height/2,-slider_height/2,0]) cube([slider_height, slider_height/2, slider_depth]);
	}
}