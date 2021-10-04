$fn = 50;
wall = 4;
width = 100;
depth = 150;
height = 32;
chamfer = 10;
 
module hole() {
  translate([0, 0, -5])
  cylinder(r=0.8, h=10);
}

 
difference() {
  // main body of the shell with rounded frame inside
  union() {
    difference() {
      translate([0, 0, -2])
      linear_extrude(height)
      offset(r=chamfer)
      offset(r=-chamfer)
      square([width + wall, depth + wall], center=true);

      linear_extrude(height)
      offset(r=chamfer)
      offset(r=-chamfer)
      square([width, depth], center=true);
       
    }
    chamfered_frame();
  }
    
  // central hole
  translate([0, 0, -5])
  cylinder(r=15, h=10);
   
  translate([0, 0, -1])
  cylinder(r=16, h=10);

  // holes in the bottom part of the shell
  translate([-35, -60, 0])
  for (y = [0 : 4]) {
    for (x = [0 : 3]) {
      translate([x * 23.3, y * 30, 0])
      hole();
    }
  }
  
  translate([-35 + 23.3 / 2, -60 + 15, 0])
  for (y = [0 : 3]) {
    for (x = [0 : 2]) {
      if (!(x == 1 && y == 1) && !(x == 1 && y == 2)) {
        translate([x * 23.3, y * 30, 0])
        hole();
      }
    }
  }
  
  translate([-width / 2 + 15, depth / 2, 15])
  rotate([90, 0, 0])
  for (i = [0 : 6]) {
    translate([i * 23.3 / 2, 0, 0])
    hole();
  }

  translate([-width / 2 + 15, -depth / 2, 15])
  rotate([90, 0, 0])
  for (i = [0 : 6]) {
    translate([i * 23.3 / 2, 0, 0])
    hole();
  }
  
  translate([-width / 2, -depth / 2 + 15, 15])
  rotate([90, 0, 90])
  for (i = [0 : 8]) {
    translate([i * 30 / 2, 0, 0])
    hole();
  }

  translate([width / 2, -depth / 2 + 15, 15])
  rotate([90, 0, 90])
  for (i = [0 : 8]) {
    translate([i * 30 / 2, 0, 0])
    hole();
  }
}



module cushion() {
  translate([-width / 2, -depth / 2 + chamfer, chamfer]) {
    translate([chamfer, 0, 0])
    sphere(r=chamfer);
    translate([chamfer, 0, 0])
    rotate([0, 90, 0])
    cylinder(r=chamfer, h=width - chamfer * 2);
    translate([width - chamfer, 0, 0])
    sphere(r=chamfer);
  }

  translate([-width / 2, depth / 2 - chamfer, chamfer]) {
    translate([chamfer, 0, 0])
    sphere(r=chamfer);
    translate([chamfer, 0, 0])
    rotate([0, 90, 0])
    cylinder(r=chamfer, h=width - chamfer * 2);
    translate([width - chamfer, 0, 0])
    sphere(r=chamfer);
  }

  translate([-width / 2 + chamfer, depth / 2 - chamfer, chamfer])
  rotate([90, 0, 0])
  cylinder(r=chamfer, h=depth - chamfer * 2);

  translate([width / 2 - chamfer, depth / 2 - chamfer, chamfer])
  rotate([90, 0, 0])
  cylinder(r=chamfer, h=depth - chamfer * 2);

  translate([-width / 2 + chamfer, -depth / 2 + chamfer, 0])
  cube([width - chamfer * 2, depth - chamfer * 2, chamfer * 2]);
}

module chamfered_frame() {
  translate([0, 0, 1])
  difference() {
    linear_extrude(chamfer)
    offset(r=chamfer)
    offset(r=-chamfer)
    square([width, depth], center=true);
    
    cushion();
  }
}