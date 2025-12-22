length = 3;
M4 = true;
locker = false;
h_base = 1.5; // 0.6 for clip2a


module clip(
    M4 = false,
    locker = false,

    h_total = length,
    h_cone_bas = 2.2,
    h_cone_haut = 2.2,
    h_base = 1.5,
    larg_top = locker ? 3.2 : 1.2,  
    larg_bot = locker ? 2 : 0.8,    
    largeur = locker ? 3.2 : 4.6,   
    d_centre_bas = 5,
    d_centre_haut = 5.3,
    d_ext_bas = 6.3,
    d_ext_haut = locker ? 6.5 : 6.3, 
    
    d_vis_bas = 3,
    d_vis_haut = 3.6,
    d_fraisee = 5.8,
    profondeur_fraisee = 3,
    
    resolution = 50,    
) {

    h_centre = h_total - h_cone_bas - h_cone_haut;
    h_trap = h_total - h_base;

    module cylindre_complet() {
        union() {
            translate([-h_total/2 + h_cone_bas, 0, 0])
                rotate([0, 90, 0])
                    cylinder(h=h_centre, d1=d_centre_bas, d2=d_centre_haut, $fn=resolution);

            translate([h_total/2 - h_cone_haut, 0, 0])
                rotate([0, 90, 0])
                    cylinder(h=h_cone_haut, d1=d_centre_haut, d2=d_ext_haut, $fn=resolution);

            translate([-h_total/2, 0, 0])
                rotate([0, 90, 0])
                    cylinder(h=h_cone_bas, d1=d_ext_bas, d2=d_centre_bas, $fn=resolution);
            /*translate([0, 0, 0])
                rotate([0, 90, 0])
                    cylinder(h=3, d1=3, d2=6, center=true, $fn=resolution);            */
        }
    }

    module fente_trapeze() {
        linear_extrude(height=max(d_ext_bas, d_ext_haut) + 0.2, center=true)
            polygon(points=[
                [ h_trap, -larg_top/2],
                [ h_trap,  larg_top/2],
                [    0,    larg_bot/2],
                [    0,   -larg_bot/2]
            ]);
    }

    module trou_vis() {
        rotate([0, 90, 0])
            cylinder(h=h_total + 1, d1=d_vis_bas, d2=d_vis_haut, center=true, $fn=resolution);
    }

    module chanfrein_fraisee() {
        translate([h_total/2 - profondeur_fraisee/2, 0, 0])
            rotate([0, 90, 0])
                cylinder(h=profondeur_fraisee, d1=d_vis_haut, d2=d_fraisee, center=true, $fn=resolution);
    }
    
    module addCenter() {

    }   

    difference() {
        intersection() {
            cylindre_complet();            
            translate([-h_total/2, -max(d_ext_bas, d_ext_haut)/2, -largeur/2]) {
                cube([h_total, max(d_ext_bas, d_ext_haut), largeur]);
            }
                
        }

        translate([-h_total/2 + h_base + 0.1, 0, 0])
            fente_trapeze();

        if (M4) {
            union() {
                trou_vis();
                chanfrein_fraisee();
                
            }
        }
    }
}

// Exemple d’appel avec trou de vis conique M4
//clip(h_total = length*4); // clip3a avec h_total=3
//clip(h_total = length*4, h_base= 0.6); // clip2a
//clip(h_total = length*4, M4 = true); // clip2M4 With M4
//clip(h_total = length*4, larg_top = 3.2, larg_bot = 2, d_ext_haut= 6.5, largeur = 3.2); // clip3
clip(h_total = length*4, M4 = M4, locker = locker, h_base = h_base);