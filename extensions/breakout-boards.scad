// If width <> 0 and height <> 0, holes, xShift and 
// yShift are computed. size of the module in mm.
// holes are on the width size
width = 27; 
height = 27.5; 

margin= 0.4; // how many millimeter more on two side ?

size =8;
cornerSize = 3.6;
model="F";

holes = 3;

xShift=6 ; // values for xShift, xShiftEnd : 1, 2, 3, 4, 5, 6
xShiftEnd = xShift;
yShift=5; // values for yShift : 0, 1, 2, 3, 4, 5

// compute holes, xShift and yShift if width and height are specified
holes = (width > 0 && height > 0) ? ceil((width + margin + 2) / size) : holes;  // 2 is here because we need at least 1 mm on each side
xShift = (width > 0 && height > 0) ? round((holes * size - (width + margin)) / 2) : xShift;
yShift = (width > 0 && height > 0) ? round(((ceil((height + margin) / size) * size) - (height + margin)) / 2) : yShift ;

echo("holes:", holes);
echo("xShift:", xShift);
echo("yShift:", yShift);
echo("debug:", (ceil((height + margin) / size) * size));

finalRotate=[0,0,0];
finalMirror=[0,0,0];



rotate([finalRotate[0], finalRotate[1], finalRotate[2]]) {
mirror([finalMirror[0], finalMirror[1], finalMirror[2]]) {
    

    //yShift = yShift - 1;

    for (x = [0:holes-1]) {
        difference() {
            translate([0,x*size,0]) holeCube();
            markers();
        }
        
        // Cube y
        difference() {        
            translate([-yShift,x*size,0]) cube(size=[yShift,size,size/2]);
            markers();
        }
        
        
        
        // First corner
        if (x == 0) {
          difference() {
              // Cube x
              translate([-yShift-cornerSize,x*size,0]) 
              
                cube(size=[cornerSize,xShift,size/2]);
              markers();
          }

    
          // Corner
          difference() {
              translate([-yShift,xShift+(x*size),0]) corner();
              markers();
          }
          
        }
        if (x > 0 && x == holes-1) {
          // Cube x
          translate([-yShift-cornerSize,(x+1)*size-xShiftEnd,0]) 
            cube(size=[cornerSize,xShiftEnd,size/2]);
          // Corner
          translate([-yShift,(x+1)*size-xShiftEnd,0]) mirror([0,1,0]) corner();
        }
    
    }

}//finalMirror
}//finalRotate

module markers() {
  markerSizeH = 0.8;
  markerSizeL = 2.8;    
   markerSpace = 1.6;
  // Markers
  for (i = [0:xShift-1]) {
      translate([size - 0.8,0.5 + (markerSpace * i),size / 4 - markerSizeL /2])
        color([0,1,0])
            cube([1.5,markerSizeH,markerSizeL]);
  }

  if (yShift > 0) {
      for (i = [0:yShift-1]) {
          translate([- yShift - 1.5 + (markerSpace * i),-1, size / 4 - markerSizeL /2])
            color([0,1,0])
                cube([markerSizeH,1.5,markerSizeL]);
      }       
  }

          
}

module corner() {
        // Corner
    // Corner bottom
    linear_extrude(height = 0.8)
    polygon(points=[[0,0], [0,cornerSize], [-cornerSize,0]]);
    // Corner height
    translate([0,0,3.2])
    linear_extrude(height = 0.8)
        polygon(points=[[0,0], [0,cornerSize], [-cornerSize,0]]);
}


// Fonction hole_cube qui crée un cube avec un trou conique au centre
// et des arêtes arrondies sauf au centre de chaque arête
module holeCube(size = 8, height_ratio = 0.5, d_outer = 6.8, d_inner = 5.2, 
                r_edge = 0.4, flat_length = 4, centered = false) {
    
    // Calcul de la hauteur en fonction du ratio
    height = size * height_ratio;
    
    // Module pour créer le modèle centré
    module centered_model() {
        difference() {
            union() {
                // Cube avec toutes les arêtes arrondies (centré)
                minkowski() {
                    cube([size-2*r_edge, size-2*r_edge, height-2*r_edge], center=true);
                    sphere(r=r_edge, $fn=30);
                }
                
                // Ajout des rectangles plats au centre de chaque arête
                
                // Arêtes horizontales sur le plan XY bas (z=-height/2)
                translate([0, -(size/2-r_edge/2), -(height/2-r_edge/2)])
                    cube([flat_length, r_edge, r_edge], center=true);
                translate([-(size/2-r_edge/2), 0, -(height/2-r_edge/2)])
                    cube([r_edge, flat_length, r_edge], center=true);
                translate([0, (size/2-r_edge/2), -(height/2-r_edge/2)])
                    cube([flat_length, r_edge, r_edge], center=true);
                translate([(size/2-r_edge/2), 0, -(height/2-r_edge/2)])
                    cube([r_edge, flat_length, r_edge], center=true);
                
                // Arêtes horizontales sur le plan XY haut (z=height/2)
                translate([0, -(size/2-r_edge/2), (height/2-r_edge/2)])
                    cube([flat_length, r_edge, r_edge], center=true);
                translate([-(size/2-r_edge/2), 0, (height/2-r_edge/2)])
                    cube([r_edge, flat_length, r_edge], center=true);
                translate([0, (size/2-r_edge/2), (height/2-r_edge/2)])
                    cube([flat_length, r_edge, r_edge], center=true);
                translate([(size/2-r_edge/2), 0, (height/2-r_edge/2)])
                    cube([r_edge, flat_length, r_edge], center=true);
                
                // Arêtes verticales
                translate([-(size/2-r_edge/2), -(size/2-r_edge/2), 0])
                    cube([r_edge, r_edge, flat_length/2], center=true);
                translate([(size/2-r_edge/2), -(size/2-r_edge/2), 0])
                    cube([r_edge, r_edge, flat_length/2], center=true);
                translate([-(size/2-r_edge/2), (size/2-r_edge/2), 0])
                    cube([r_edge, r_edge, flat_length/2], center=true);
                translate([(size/2-r_edge/2), (size/2-r_edge/2), 0])
                    cube([r_edge, r_edge, flat_length/2], center=true);
            }
            
            // Trou conique au centre
            union() {
                // Cône inférieur (d_outer → d_inner)
                translate([0, 0, -height/4])
                    cylinder(d1=d_outer, d2=d_inner, h=height/2, center=true, $fn=50);
                
                // Cône supérieur (d_inner → d_outer)
                translate([0, 0, height/4])
                    cylinder(d1=d_inner, d2=d_outer, h=height/2, center=true, $fn=50);
            }
        }
    }
    
    // Choix entre centré ou coin à l'origine selon le paramètre
    if (centered) {
        centered_model();
    } else {
        // Translation pour placer le coin à l'origine
        translate([size/2, size/2, height/2]) {
            centered_model();
        }
    }
} 