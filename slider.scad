alpha=30;
beta=73;
h=2; // base height
dh=1; // height dent
u=5; // length
b=5; // widgh
space=5;

ws=51;
hs=60;
// radius slider
rs=1.5;

$fn=100;

module dent() {
	difference() {
		translate([-u/2,0,0]) cube([u*3/2,b,dh]);
		translate([u,0,0]) rotate([0,90-beta,0]) translate([-2*u,0,0]) cube([3*u,b,dh]);
		rotate([0,90-alpha,0]) translate([-3*u,0,-dh*5]) cube([3*u,b,dh*5]);
	}
}


union() {
	intersection() {
		union() {
			for (j=[0:13])
				for (i=[0:9]) {
					translate([i*(space+u)+space,j*(b+1)-(i%2)*2,0]) dent();
				}

			translate([0,0,-2]) 
				difference() {
					cube([hs,ws,2]);
					for (j=[0:13])
						for (i=[0:9]) {
							translate([i*(space+u)+1,j*(b+1)-(i%2)*2,0]) cube([space-1,b,2]);
						}
				}
		}
		translate([0,0,-2]) cube([hs,ws,3]);
	}
	// border
	translate([0,0,-0.5]) rotate([0,90,0]) cylinder(r=rs, h=hs);
	translate([0,ws,-0.5]) rotate([0,90,0]) cylinder(r=rs, h=hs);
}