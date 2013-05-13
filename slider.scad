include <config.scad>;

$fn=10;

module dent() {
	difference() {
		translate([-dent_width/2,0,0])
			cube([dent_width*3/2,dent_depth,dent_height]);
		translate([dent_width,0,0])
			rotate([0,90-dent_beta,0])
			translate([-2*dent_width,0,0])
			cube([3*dent_width,dent_depth,dent_height]);
		rotate([0,90-dent_alpha,0])
			translate([-3*dent_width,0,-dent_height*5])
			cube([3*dent_width,dent_depth,dent_height*5]);
	}
}

adjust_x=0;
adjust_y=-1;

dents_x=7;
dents_y=7;

union() {
	translate([0,0,slider[2]-dent_height]) intersection() {
		union() {
			for (j=[0:dents_x])
				for (i=[1:dents_y]) {
					translate([i*(dent_inter_space+dent_width)+adjust_x,j*(2*dent_depth-dent_overlapp)-(i%2)*(dent_depth-dent_overlapp/2)+adjust_y,0]) dent();
				}
			translate([0,0,-(slider[2]-dent_height)]) 
				difference() {
					cube([slider[1],slider[0],(slider[2]-dent_height)]);
					for (j=[0:dents_x])
						for (i=[1:dents_y]) {
							translate([i*(dent_inter_space+dent_width)-dent_inter_space+adjust_x,j*(2*dent_depth-dent_overlapp)-(i%2)*(dent_depth-dent_overlapp/2)+adjust_y,0]) cube([dent_inter_space,dent_depth,(slider[2]-dent_height)]);
						}
				}
		}
		translate([0,wall/2,-slider[2]+dent_height]) cube([slider[1],slider[0]-wall,slider[2]]);
	}

	// border
	difference() {
		cube([slider[1],slider[0],slider[2]]);
		translate([wall/2,wall/2,0]) cube([slider[1]-wall,slider[0]-wall,slider[2]]);
	}
}