//import("tempeh-moulds-v-02/rectangle-100x150/Tempeh-mould-10x15-lid.stl");

$fn = 50;
width = 100 - 1.5;
depth = 150 - 1.5;
wall = 2;
chamfer = 10;
grip_w = 10;
grip_h = 12;
grip_r = 8;


module rounded_profile() {
  translate([-chamfer, 0, chamfer])
  difference() {
    translate([chamfer / 2, 0, -chamfer / 2])
    cube([chamfer, depth, chamfer], center=true);
    translate([0, depth / 2 + 0.5, 0])
    rotate([90, 0, 0])
    cylinder(r=chamfer, h=depth + 1);
  }
}

module grip() {
  translate([0, 0, grip_h / 2])
  cube([grip_w, depth, grip_h], center=true);
  
  difference() {
    hull() {
      translate([0, depth / 2 - grip_r, 12])
      rotate([0, 90, 0])
      cylinder(r=grip_r, h=grip_w, center=true);
      
      translate([0, -depth / 2 + grip_r, 12])
      rotate([0, 90, 0])
      cylinder(r=grip_r, h=grip_w, center=true);
    }
    
    // rubber band notches
    translate([0, -40, grip_h + grip_r - 1])
    cube([grip_w + 1e-3, 5, 2 + 1e-3], center=true);
    
    translate([0, 40, grip_h + grip_r - 1])
    cube([grip_w + 1e-3, 5, 2 + 1e-3], center=true);
  }
}


module lid() {
  linear_extrude(wall)
  offset(r=chamfer)
  offset(r=-chamfer)
  square([width, depth], center=true);
  
  translate([0, 0, wall]) {
    translate([-grip_w / 2, 0, 0])
    rounded_profile();

    translate([grip_w / 2, 0, 0])
    rotate([0, 0, 180])
    rounded_profile();
    
    grip();
  }
}

module hole() {
  translate([0, 0, -5])
  cylinder(r=0.8, h=10);
}

difference() {
  lid();
  
  translate([-35, -60, -2])
  for (y = [0 : 4]) {
    for (x = [0 : 3]) {
      translate([x * 23.3, y * 30, 0])
      hole();
    }
  }
  
  translate([-35 + 23.3 / 2, -60 + 15, -2])
  for (y = [0 : 3]) {
    for (x = [0 : 2]) {
      if (x != 1) {
        translate([x * 23.3, y * 30, 0])
        hole();
      }
    }
  }
}
