size =8;
model="SP";

length1=2;
length2=4;
length3=2;
length4=3;
options="";


filename="sg90-4x1.stl";

holeArray=[[-1,0,0],[-1,1,0],[4,0,0],[4,1,0]];

finalRotate=[0,0,0];
finalMirror=[0,0,0];

rounded = true;

rotate([finalRotate[0], finalRotate[1], finalRotate[2]]) {
mirror([finalMirror[0], finalMirror[1], finalMirror[2]]) {    
    // Model I
    if (model == "I") {
        for (x = [0:length1-1]) {
            echo (x);
            translate([0,x*size,0]) holeCube();
        }
    }

    // Model IR (Rounded)
    if (model == "IR") {
        if (length1 == 1) {
            import("imports/hole-cube-turn-1.stl");
        } 
        else 
        {
            
            for (x = [0:length1-1]) {
                if (x==0) {
                    rotate([180,0,0]) {
                        translate([0,x*size-size,-size/2]) import("imports/hole-cube-turn.stl");
                    }
                }  else if(x==length1-1) {
                    translate([0,x*size,0]) import("imports/hole-cube-turn.stl");
                } else {
                    echo (x);
                    translate([0,x*size,0]) holeCube();
                }
            }
        }
    }

    // Model IH (I Half)
    if (model == "IH") {
        for (x = [0:length1-1]) {
            echo (x);
            translate([0,x*size,0]) holeCubeHalf();
        }
    }

    // Model IHR (Rounded)
    if (model == "IHR") {
        for (x = [0:length1-1]) {
            if (x==0) {
                rotate([0,0,180]) {
                    translate([-size,-size,0]) import("imports/hole-cube-half-turn.stl");
                }
            }  else if(x==length1-1) {
                translate([0,x*size,0]) import("imports/hole-cube-half-turn.stl");
            } else {
                echo (x);
                translate([0,x*size,0]) holeCubeHalf();
            }
        }
    }

    // Model C (Cube)
    if (model == "C") {
        for (z = [0:length1-1]) {
           for (x = [0:length2-1]) {
               for (y = [0:length3-1]) {           
                   echo (x);
                   translate([y*size,x*size,z*size/2]) holeCube();                          
               }
           }        
        }
    }




    //Model LF (L Flat)
    if (model == "LF") {
        for (x = [0:length1-1]) {
            echo (x);
            translate([0,x*size,0]) holeCube();
        }
       for (x = [0:length2-1]) {
            translate([x*size,(length1-1)*size,0]) holeCube();
        }    
    }

//Model L
    if (model == "L") {
        for (z = [0:length3-1]) {
            for (x = [0:length1-1]) {
                translate([z*size,x*size,0]) holeCube();
            }
            // Bloc avec coins arrondis
            translate([z*size,(length1-1+1)*size,0]) {
              corner_cube();
            }
           for (x = [0:length2-1]) {
               translate([z*size,(length1-1+1)*size+size/2,x*size+size/2]) {
                    rotate([90,0,0]) {
                        holeCube();
                    }           
               }
             }            
        }
    }


    //Model P (Plate)
    if (model == "P") {
        for (x = [0:length1-1]) {
           for (y = [0:length2-1]) {
                translate([y*size,x*size,0]) holeCube();
           }
        }
    }

    //Model UF (U flat)
    if (model == "UF") {
        for (x = [0:length1-1]) {
            echo (x);
            translate([0,x*size,0]) holeCube();
        }
       for (x = [0:length2-1]) {
            translate([x*size,(length1-1)*size,0]) holeCube();
        }    
       for (x = [0:length3-1]) {
            translate([(length2-1)*size,(length1-1)*size - x*size,0]) holeCube();
        }        
    }

    //Model SF (S flat)
    if (model == "SF") {
        for (x = [0:length1-1]) {
            translate([0,x*size,0]) holeCube();
        }
       for (x = [0:length2-1]) {
            translate([x*size,(length1-1)*size,0]) holeCube();
        }    
       for (x = [0:length3-1]) {
            translate([(length2-1)*size,(length1-1)*size + x*size,0]) holeCube();
        }        
    }

    //Model U
    if (model == "U") {
        for (x = [0:length1-1]) {
            translate([0,x*size,0]) holeCube();
        }
        // Bloc
        translate([0,(length1-1+1)*size,0]) {
            corner_cube();
        }
       for (x = [0:length2-1]) {
           translate([0,(length1-1+1)*size+size/2,x*size+size/2]) {
                rotate([90,0,0]) {
                    holeCube();
                }           
           }
         }       
        // Bloc
        translate([0,(length1-1+1)*size,(length2-1+1)*size + size/2]) {
            corner_cube();
        }     
       for (x = [0:length3-1]) {
           translate([0,(length1-1)*size - x*size ,(length2-1)*size+size+size/2]) {
                holeCube();
           }
         }        
    }

    //Model S
    if (model == "S") {
        for (x = [0:length1-1]) {
            translate([0,x*size,0]) holeCube();
        }
        // Bloc
        translate([0,(length1-1+1)*size,0]) {
            cube([size,size/2,size/2],false);
        }
       for (x = [0:length2-1]) {
           translate([0,(length1-1+1)*size+size/2,x*size+size/2]) {
                rotate([90,0,0]) {
                    holeCube();
                }           
           }
         }       
        // Bloc
        translate([0,(length1-1+1)*size,(length2-1+1)*size + size/2]) {
            cube([size,size/2,size/2],false);
        }     
       for (x = [0:length3-1]) {
           translate([0,(length1-1)*size + size + size/2 + x*size ,(length2-1)*size+size+size/2]) {
                holeCube();
           }
         }        
    }
    
    // Model SP (Spring)
    if (model == "SP") {
        for (x = [0:length1-1]) {
            echo (x);
            translate([0,x*size,0]) holeCube();
        }
        for (x = [length1:length1+length2-1]) {
            echo (x);
            translate([0,x*size,0]) sinusoide();
        }   
        for (x = [length1+length2:length1+length2+length3-1]) {
            echo (x);
            translate([0,x*size,0]) holeCube();
        }          
    }
    
    // Model T (Twist)
 /*   if (model == "T") {
        for (x = [0:length1-1]) {
            translate([0,x*size,0]) holeCube();
            translate([0,x*size,size/2]) holeCube();
        }
        for (x = [length1:length1+length2-1]) {
            rotate([0,90,0]) {
                translate([-size,x*size,0]) holeCube();
                translate([-size,x*size,size/2]) holeCube();
            }
        }   
    }*/

    // Model TE (Twist Each)
/*    if (model == "TE") {
        for (x = [0:length1 -1 ]) {
            if (x%2 == 0) {
                translate([0,x*size,0]) holeCube();
                translate([0,x*size,size/2]) holeCube();            
            }
            else {
                rotate([0,90,0]) {
                    translate([-size,x*size,0]) holeCube();
                    translate([-size,x*size,size/2]) holeCube();
                }
            }
        }   
    }    */
    
   
    // Model TH (Twist Half)
    if (model == "TH") {
        for (x = [0:length1-1]) {
            translate([0,x*size,0]) holeCube();
        }
        for (x = [length1:length1+length2-1]) {
            rotate([0,90,0]) {
                translate([-size,x*size,0]) holeCube();
            }
        }   
    }    
    
    // Model THE (Twist Half Each)
    if (model == "THE") {
        for (x = [0:length1 -1 ]) {
            if (x%2 == 0) {
                translate([0,x*size,0]) holeCube();
            }
            else {
                rotate([0,90,0]) {
                    translate([-size,x*size,0]) holeCube();
                }
            }
        }    
    }     

    
    if (model == "THEL") {
        // Partie verticale (vers le haut)
        for (x = [0:length1 - 1]) {
            if (x % 2 == 0) {
                translate([0, x * size, 0]) holeCube();
            } else {
                rotate([0, 90, 0]) {
                    translate([-size, x * size, 0]) holeCube();
                }
            }
        }

        // Partie horizontale (vers la gauche, au niveau du bas)
        for (y = [1:length2]) { // on commence à 1 pour ne pas doubler le coin déjà posé
            if (y % 2 == 0) {
                translate([-y * size, 0, 0]) holeCube();
            } else {
                rotate([90, 0, 0]) {
                    translate([-y * size , 0, -size]) holeCube();
                }
            }
        }
    }    
        
    
    // Model F => File
    if (model == "F") {
        import(str("imports/",filename));
        if (len(holeArray) > 0) {
        for(i= [0 : len(holeArray) - 1]) // rows
        {
            echo(str("row:",i));

            echo(str(holeArray[i][0], ",",holeArray[i][1], ",", holeArray[i][2] ));
            translate([holeArray[i][1]*size,holeArray[i][0]*size,holeArray[i][2]*size/2]) holeCube();

        }
        }   
    }

    // Model FH => File Half (Half height
    if (model == "FH") {
        import(str("imports/",filename));
        if (len(holeArray) > 0) {
        for(i= [0 : len(holeArray) - 1]) // rows
        {
            echo(str("row:",i));

            echo(str(holeArray[i][0], ",",holeArray[i][1], ",", holeArray[i][2] ));
            translate([holeArray[i][1]*size,holeArray[i][0]*size+size,holeArray[i][2]*size/2+size/4]) {
                rotate([180,0,0]) {
                    holeCubeHalf();
                }
            }
                

        }
    }
    }
    
    // Model CP - Cover Plate
    if (model == "CP") {
        for (x = [0:length1-1]) {
            for (y = [0:length2-1]) {
                // Vérifier si c'est un coin
                isCorner = (x == 0 || x == length1-1) && (y == 0 || y == length2-1);
                
                translate([y*size, x*size, 0]) {
                    if (isCorner) {
                        holeCube(); // Utiliser le cube normal pour les coins
                    } else {
                        // Créer un cube modifié avec l'épaisseur length3 pour les autres positions
                        linear_extrude(height = length3) {
                            square([size, size]);
                        }
                        // Vous pouvez aussi appeler une fonction personnalisée ici
                        // thinHoleCube(length3);
                    }
                }
            }
        }
    }   
    
    // Model CPC - Cover Plate Cube
    if (model == "CPC") {
        // fond
        cube([length1*size, length2*size, length3]);
        // side
        cube([length1*size, length3, length4*size]);
        translate([0, length2*size-length3, 0])
            cube([length1*size, length3, length4*size]);
            
        // side whith hole
        difference() { 
            cube([length3, length2*size, length4*size]);
            translate([0,0, length4*size -size])
                cube([size, size, size]);
            translate([0, length2*size - size, length4*size -size])
                cube([size, size, size]);                
        }
        
        translate([size/2, 0, length4*size - size])
            rotate([0,270,0])
                holeCube();
        translate([size/2, length2*size - size, length4*size - size])
            rotate([0,270,0])
                holeCube();                
        
        difference() { 
            translate([length1*size - length3 ,0, 0])
                cube([length3, length2*size, length4*size]);
            translate([length1*size - length3,0, length4*size -size])
                cube([size, size, size]);
            translate([length1*size - length3, length2*size - size, length4*size -size])
                cube([size, size, size]);                
        }        
            
        translate([length1*size, 0, length4*size - size])
            rotate([0,270,0]) {
                holeCube();
                rotate([270,180, 0])                
                linear_extrude(height = size) {
                    polygon(points = [
                        [0, 0],
                        [4.8, 0],
                        [0, 4.8]
                    ]);
                }                
            }
                
        translate([length1*size, length2*size - size, length4*size - size])
            rotate([0,270,0]) {
                holeCube(); 
                rotate([270,180, 0])                
                linear_extrude(height = size) {
                    polygon(points = [
                        [0, 0],
                        [4.8, 0],
                        [0, 4.8]
                    ]);
                }                 
            }
   
        // Triangles
        translate([0 ,0, length4*size - size])
        rotate([270, 0, 0]) 
        linear_extrude(height = size) {
            polygon(points = [
                [0, 0],
                [4.8, 0],
                [0, 4.8]
            ]);
        }

        translate([0 ,length2*size - size, length4*size - size])
        rotate([270, 0, 0]) 
        linear_extrude(height = size) {
            polygon(points = [
                [0, 0],
                [4.8, 0],
                [0, 4.8]
            ]);
        }
           
        
    } 
    
    // Model CPV - Cover Plate Verticale
    if (model == "CPV") {
        for (x = [0:length1-1]) {
            for (y = [0:(length2-1)*2]) {
                // Vérifier si c'est un coin
                isCorner = (x == 0 || x == length1-1) && (y == 0 || y == (length2-1)*2 );
                
                echo(y);
                translate([y*size/2, x*size, 0]) {
                    if (isCorner) {
                        if (y ==0) {
                        rotate([0,270,0])
                            translate([0,0,-size/2])
                                holeCube(); // Utiliser le cube normal pour les coins
                        } else {
                        rotate([0,270,0])
                            translate([0,0,-size])
                                holeCube(); // Utiliser le cube normal pour les coins
                        }
                    } else {
                        // Créer un cube modifié avec l'épaisseur length3 pour les autres positions
                        linear_extrude(height = length3) {
                            square([size, size]);
                        }
                        // Vous pouvez aussi appeler une fonction personnalisée ici
                        // thinHoleCube(length3);
                    }
                }
            }
        }
    }   
        
    // Model CPVW - Cover Plate Verticale with wall
    if (model == "CPVW") {
        union() {
            for (x = [0:length1-1]) {
                for (y = [0:(length2-1)*2]) {
                    // Vérifier si c'est un coin
                    isCorner = (x == 0 || x == length1-1) && (y == 0 || y == (length2-1)*2 );
                    
                    echo(y);
                    translate([y*size/2, x*size, 0]) {
                        if (isCorner) {
                            if (y ==0) {
                            rotate([0,270,0])
                                translate([0,0,-size/2])
                                    holeCube(); // Utiliser le cube normal pour les coins
                            } else {
                            rotate([0,270,0])
                                translate([0,0,-size])
                                    holeCube(); // Utiliser le cube normal pour les coins
                            }
                        } else {
                            // Créer un cube modifié avec l'épaisseur length3 pour les autres positions
                            linear_extrude(height = length3) {
                                square([size, size]);
                            }
                            // Vous pouvez aussi appeler une fonction personnalisée ici
                            // thinHoleCube(length3);
                        }
                    }
                }
            }
            // Mur gauche (à l'intérieur)
            translate([0, size - 0.4, 0]) {
                cube([length3, length1*size - size*2 +0.8, size]);
            }
            
            // Mur droit (à l'intérieur)
            translate([(length2-1)*size + (size-length3), size - 0.4, 0]) {
                cube([length3, length1*size - size*2 +0.8, size]);
            }
            
            // Mur inférieur (à l'intérieur)
            translate([size/2-0.4, 0, 0]) {
                cube([(length2-1)*size + 0.8, length3, size]);
            }
            
            // Mur supérieur (à l'intérieur)
            translate([size/2-0.4, (length1-1)*size + (size-length3), 0]) {
                cube([(length2-1)*size + 0.8, length3, size]);
            }            
        }
    } 
   
    // Model CPW - Cover Plate with wall
    if (model == "CPW") {
        union() {
            // Construction de base de la plaque
            for (x = [0:length1-1]) {
                for (y = [0:length2-1]) {
                    // Vérifier si c'est un coin
                    isCorner = (x == 0 || x == length1-1) && (y == 0 || y == length2-1);
                    
                    translate([y*size, x*size, 0]) {
                        if (isCorner) {
                            holeCube(); // Utiliser le cube normal pour les coins
                        } else {
                            // Créer un cube modifié avec l'épaisseur length3 pour les autres positions
                            linear_extrude(height = length3) {
                                square([size, size]);
                            }
                        }
                    }
                }
            }
            
            // Mur gauche (à l'intérieur)
            translate([0, 0, 0]) {
                cube([length3, length1*size, size/2]);
            }
            
            // Mur droit (à l'intérieur)
            translate([(length2-1)*size + (size-length3), 0, 0]) {
                cube([length3, length1*size, size/2]);
            }
            
            // Mur inférieur (à l'intérieur)
            translate([length3, 0, 0]) {
                cube([(length2-1)*size + (size-2*length3), length3, size/2]);
            }
            
            // Mur supérieur (à l'intérieur)
            translate([length3, (length1-1)*size + (size-length3), 0]) {
                cube([(length2-1)*size + (size-2*length3), length3, size/2]);
            }
        }
    }
    
    
    
    
}//finalMirror
}//finalRotate


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

// Module pour créer un cube avec coins arrondis et arêtes plates sur les 12 arêtes
module corner_cube() {
    // Rayon des arrondis fixé à 0.8mm
    r_edge = 0.8;
    // Dimensions utilisant la variable globale size
    w = size;
    d = size/2;
    h = size/2;
    
    // Longueur fixe des arêtes plates (2.4mm)
    flat_length = 2.4;
    
    difference() {
        union() {
            // Cube de base avec coins arrondis
            translate([r_edge, r_edge, r_edge]) 
            minkowski() {
                cube([w-2*r_edge, d-2*r_edge, h-2*r_edge], false);
                sphere(r=r_edge, $fn=20);
            }
            
            // 4 Arêtes horizontales sur axe X (parallèles à l'axe X)
            // Face avant (y=d), en bas
            translate([w/2, d-r_edge/2, 0+r_edge/2])
                cube([flat_length, r_edge, r_edge], center=true);
            // Face avant (y=d), en haut
            translate([w/2, d-r_edge/2, h-r_edge/2])
                cube([flat_length, r_edge, r_edge], center=true);
            // Face arrière (y=0), en bas
            translate([w/2, 0+r_edge/2, 0+r_edge/2])
                cube([flat_length, r_edge, r_edge], center=true);
            // Face arrière (y=0), en haut
            translate([w/2, 0+r_edge/2, h-r_edge/2])
                cube([flat_length, r_edge, r_edge], center=true);
            
            // 4 Arêtes horizontales sur axe Y (parallèles à l'axe Y)
            // Face gauche (x=0), en bas
            translate([0+r_edge/2, d/2, 0+r_edge/2])
                cube([r_edge, flat_length, r_edge], center=true);
            // Face gauche (x=0), en haut
            translate([0+r_edge/2, d/2, h-r_edge/2])
                cube([r_edge, flat_length, r_edge], center=true);
            // Face droite (x=w), en bas
            translate([w-r_edge/2, d/2, 0+r_edge/2])
                cube([r_edge, flat_length, r_edge], center=true);
            // Face droite (x=w), en haut
            translate([w-r_edge/2, d/2, h-r_edge/2])
                cube([r_edge, flat_length, r_edge], center=true);
                
            // 4 Arêtes verticales sur axe Z (parallèles à l'axe Z)
            // Coin avant gauche
            translate([0+r_edge/2, d-r_edge/2, h/2])
                cube([r_edge, r_edge, flat_length], center=true);
            // Coin avant droit
            translate([w-r_edge/2, d-r_edge/2, h/2])
                cube([r_edge, r_edge, flat_length], center=true);
            // Coin arrière gauche
            translate([0+r_edge/2, 0+r_edge/2, h/2])
                cube([r_edge, r_edge, flat_length], center=true);
            // Coin arrière droit
            translate([w-r_edge/2, 0+r_edge/2, h/2])
                cube([r_edge, r_edge, flat_length], center=true);
        }
        
        // Soustraction d'un grand cube pour ne pas affecter l'extérieur du bloc
        translate([-1, -1, -1])
            cube([w+2, d+2, 0]); // Coupe le bas
    }
}

// Fonction pour générer les points de la sinusoïde
function points_sinusoide(largeur, hauteur, nombre_points) = [
    for (i = [0:nombre_points])
        let (x = i * largeur / nombre_points)
        let (y = (hauteur/2) * sin(360 * x / largeur))
        [x, y]
];

// Génération de la sinusoïde avec répétition intégrée
module sinusoide(
    largeur = size/2,           // Largeur par défaut (en mm)
    hauteur = 7.2,           // Hauteur par défaut (en mm)
    epaisseur = size/2,         // Épaisseur par défaut (en mm)
    epaisseur_trait = 0.8,   // Épaisseur du trait par défaut (en mm)
    nombre_points = 100      // Nombre de points par défaut
) {
    // Générer une sinusoïde simple
    module sinusoide_simple() {
        points = points_sinusoide(largeur, hauteur, nombre_points);
        
        // Extrusion de la courbe le long de l'axe Z (pour l'épaisseur)
        linear_extrude(height=epaisseur) {
            // Création du chemin avec l'épaisseur du trait
            union() {
                for (i = [0:nombre_points-1]) {
                    hull() {
                        translate([points[i][0], points[i][1], 0])
                            circle(d=epaisseur_trait, $fn=16);
                        translate([points[i+1][0], points[i+1][1], 0])
                            circle(d=epaisseur_trait, $fn=16);
                    }
                }
            }
        }
    }
    
    // Créer deux sinusoïdes côte à côte
    rotate([0, 0, 90]) {
        translate([0,-largeur,0]) {
            sinusoide_simple();
            translate([largeur, 0, 0])
                sinusoide_simple();
        
        }
    }
}

// Exemple d'utilisation de la fonction avec les paramètres par défaut
//hole_cube();

// Pour utiliser le module avec des paramètres personnalisés :
// hole_cube(size = 12, height_ratio = 0.4, d_outer = 6, d_inner = 4, r_edge = 1, flat_length = 3, centered = true);


/*
module holeCube() {
    if (rounded)
        //import("imports/hole-cube-rounded.stl");
        //import("imports/hole-cube-r3.stl");
    
    else
        import("imports/hole-cube.stl");
    difference() {
        cube([size,size,size/2]);
        translate([size/2, size/2, 0]) cylinder (h = size/4, r1=8/2, r2=6.4/2, center=false, $fn=100 );
        translate([size/2, size/2, size/4])  cylinder (h = 4.8, r1=6.4/2, r2=8/2, center=false, $fn=100 );
    }
}
*/
module holeCubeHalf() {
   import("imports/hole-cube-half.stl");
    //difference() {
    //    cube([size,size,size/2]);
    //    translate([size/2, size/2, 0]) cylinder (h = size/4, r1=8/2, r2=6.4/2, center=false, $fn=100 );
    //    translate([size/2, size/2, size/4])  cylinder (h = 4.8, r1=6.4/2, r2=8/2, center=false, $fn=100 );
    //}
}   