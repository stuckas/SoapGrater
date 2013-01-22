include <config.scad>;

$fn=100;

module dent() {
	difference() {
		translate([-dent_width/2,0,0]) cube([dent_width*3/2,dent_depth,dent_height]);
		translate([dent_width,0,0]) rotate([0,90-dent_beta,0]) translate([-2*dent_width,0,0]) cube([3*dent_width,dent_depth,dent_height]);
		rotate([0,90-dent_alpha,0]) translate([-3*dent_width,0,-dent_height*5]) cube([3*dent_width,dent_depth,dent_height*5]);
	}
}


union() {
	intersection() {
		union() {
			for (j=[0:4])
				for (i=[1:4]) {
					translate([i*(dent_inter_space+dent_width),j*(2*dent_depth-dent_overlapp)-(i%2)*(dent_depth-dent_overlapp/2),0]) dent();
				}
			translate([0,0,-(slider_height-dent_height)]) 
				difference() {
					cube([slider_depth,slider_width,(slider_height-dent_height)]);
					for (j=[0:4])
						for (i=[1:4]) {
							translate([i*(dent_inter_space+dent_width)-dent_inter_space,j*(2*dent_depth-dent_overlapp)-(i%2)*(dent_depth-dent_overlapp/2),0]) cube([dent_inter_space,dent_depth,(slider_height-dent_height)]);
						}
				}
		}
		translate([0,0,-(slider_height-dent_height)]) cube([slider_depth,slider_width,slider_height]);
	}
	// border
	translate([0,0,0]) rotate([0,90,0]) cylinder(r=slider_height/2, h=slider_depth);
	translate([0,slider_width,0]) rotate([0,90,0]) cylinder(r=slider_height/2, h=slider_depth);
}