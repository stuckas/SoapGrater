alpha=30;
beta=78;
h=2; // base height
dh=1; // height dent
u=5; // length
b=5; // widgh
overlapp = 2; // overlapping dent
space=5;

ws=26;
hs=35;
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
			for (j=[0:4])
				for (i=[1:4]) {
					translate([i*(space+u),j*(2*b-overlapp)-(i%2)*(b-overlapp/2),0]) dent();
				}
			translate([0,0,-h]) 
				difference() {
					cube([hs,ws,h]);
					for (j=[0:4])
						for (i=[1:4]) {
							translate([i*(space+u)-space,j*(2*b-overlapp)-(i%2)*(b-overlapp/2),0]) cube([space,b,h]);
						}
				}
		}
		translate([0,0,-h]) cube([hs,ws,h+dh]);
	}
	// border
	translate([0,0,-0.5]) rotate([0,90,0]) cylinder(r=rs, h=hs);
	translate([0,ws,-0.5]) rotate([0,90,0]) cylinder(r=rs, h=hs);
}