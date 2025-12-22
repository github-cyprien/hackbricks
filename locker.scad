length = 3;
strong=true;

module locker(  h_total=10.2, 
                d_centre_haut=5.3, 
                largeur_bas=1.8, 
                largeur_haut=2.9, 
                strong=false
) {
    hauteur_trapeze = h_total;
    resolution = 50;

    difference() {
        intersection() {
            cylinder(h = h_total, d = d_centre_haut, center = true, $fn=resolution);

            // Découpe trapézoïdale intégrée
            hull() {
                translate([-largeur_bas/2, -5, -hauteur_trapeze/2])
                    cube([largeur_bas, 10, 0.1]);
                translate([-largeur_haut/2, -5, hauteur_trapeze/2])
                    cube([largeur_haut, 10, 0.1]);
            }
        }

        if (strong) {
            // Petit carré creusé sur le dessus
            profondeur = 0.6;
            translate([-1.5/2, -1.5/2, hauteur_trapeze/2 - profondeur])
                cube([1.5, 1.5, profondeur]);
        }
    }
}
// Exemple d'utilisation
//locker(h_total=16 -1.8, d_centre_haut=5.3, largeur_bas=1.8, largeur_haut=2.9); // Locker 4
//locker(h_total=12 -1.8, d_centre_haut=5.3, largeur_bas=1.8, largeur_haut=3.0); // Locker 3
//locker(h_total=8 -1.8, d_centre_haut=5.2, largeur_bas=1.8, largeur_haut=3.1); // locker-2
//locker(h_total=8 -1.8, d_centre_haut=5.3, largeur_bas=1.8, largeur_haut=3.1, strong=true); // locker-2-strong
locker(h_total=length * 4 - 1.8, d_centre_haut=5.3, largeur_bas=1.8, largeur_haut=3.1, strong=strong); // locker-2-strong
