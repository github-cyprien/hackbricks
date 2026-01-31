include <BOSL2/std.scad>
include <BOSL2/threading.scad>

size=8;
length=2;
type="nut"; // screw, nut
head="easy"; // hex,slot,easy,easy-slim


    
if (type=="screw") {
    rotate([0,180,0])
        union() {
            threaded_rod(d=5.3, l=length*size/2+3, pitch=1.25, $fa=1, $fs=1, anchor=TOP); // d = 5.5 => Dur à visser, 5.3 => Facile
            
            if (head=="slot") {        
                // TÊTE FRAISÉE (tronconique)
                difference() {
                    // tête conique
                    cylinder(h=2, d2=6.8, d1=5.2, $fn=64);
                    // fente tournevis plat
                    translate([-0.5, -3.5, 1])  // centrée et enfoncée de 1mm
                        cube([1, 7, 1.2]);  // largeur 1 mm, long traversant                                
                }
            }
            
            if (head=="easy")  {
                // tête conique
                translate([0, 0, -0.5])
                    cylinder(h=2, d2=6.8, d1=5.2, $fn=64);
                // tête facile à visser
                translate([0, 0, 1.5])
                    import("imports/easy-head.stl");
            }
            if (head=="easy-slim")  {
                // tête conique
                translate([0, 0, -0.5])
                    cylinder(h=2, d2=6.8, d1=5.2, $fn=64);
                // tête facile à visser
                translate([0, 0, 1.5])
                    import("imports/easy-head-slim.stl");
            }            
        }
}

if(type=="nut" && head=="hex")
    threaded_nut(nutwidth=8, id=5.7, h=4, pitch=1.25, bevel=false, $slop=0.1, $fa=1, $fs=1);

if (type=="nut" && head=="easy") {
    union() {    
        translate([0,0,2])
            threaded_nut(shape="square", nutwidth=7, id=5.7, h=4, pitch=1.25, bevel=false, $slop=0.1, $fa=1, $fs=1);
        difference() {
            import("imports/easy-head.stl");
            cylinder(h=4, r=3.5, $fn=64);
            //threaded_rod(d=5.4, l=length*size/2+5, pitch=1.25, $fa=1, $fs=1);
        }        
    }
}


