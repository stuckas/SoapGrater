
// definitions
soap=[46,26,100];
// radius soap (inner)
rs=5;

// height outer
ho=40;
// radius outer
ro=rs;
// wall diameter
d=6;

// depth backpart
back=40;
//distance of screws;
ds=35;

// width slider
ws=soap[0]+d;
// radius slider
rs=2;

// depth slider
hs=back+soap[1]-d+10;

// spring space
r_spring = rs+1;
d_spring = back-2*d+2;

// resolution
$fn=20;

module rounded(size,r)  {
	hull() {
		translate([r,r,0]) cylinder(r=r, h=size[2]);
		translate([size[0]-r,r,0]) cylinder(r=r,h=size[2]);
		translate([r,size[1]-r,0]) cylinder(r=r,h=size[2]);
   		translate([size[0]-r,size[1]-r,0]) cylinder(r=r, h=size[2]);
	}
}

module hole(pos) {
	translate(pos) rotate([90,-90,180]) {
		cylinder(r=5,h=d*2);
		hull() {
			cylinder(r=3, h=d*2);
			translate([10,0,0]) cylinder(r=3, h=d*2);
		}
	}
}


module soap_part() {
difference() {
	rounded([soap[0]+2*d,soap[1]+2*d, ho], ro);
	translate ([d, d, 0]) rounded(soap, rs);
}
}

module back_part() {
translate([0,soap[1]+d,0]) {
union() {
	difference() {
		cube([soap[0]+2*d, back, ho]);
		translate([d,d,0]) cube([soap[0], back-2*d, ho-d]);

		hole([(soap[0]+2*d-ds)/2,back-d-3, ho-d-15]);
		hole([(soap[0]+2*d+ds)/2,back-d-3, ho-d-15]);
	}
	translate([0,2*d,0]) cube([2*d, back-2*d, 2*d]);
	translate([soap[0],2*d,0]) cube([2*d, back-2*d, 2*d]);
}
}
}

module slider() {

rotate([-90,0,0]) {
	hull() {
		cylinder(r=rs, h=hs);
		translate([ws-2*rs,0,0]) cylinder(r=rs, h=hs);
	}

	// spring space
	translate([0,0,soap[1]+d+10])cylinder(r=r_spring, h=d_spring);
	translate([ws-2*rs,0,soap[1]+d+10]) cylinder(r=r_spring, h=d_spring);
}
}

// all together

difference() {
	union() {
		back_part();
		soap_part();

	}
	
	translate([d+((soap[0]-ws)/2)+rs, d-10,d]) slider();
}


// slider
translate([-soap[0]-3*d,0,rs]) rotate([-90,0,0]) {

	cylinder(r=rs, h=hs);
	translate([ws-2*rs,0,0]) cylinder(r=rs, h=hs);
	translate([0,-rs+1,0]) cube([ws-2*rs, 2*rs-1,hs-2]);
	translate([0,-rs,0]) cube([ws-2*rs, 2*rs,d]);
}