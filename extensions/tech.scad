/*# Links

Made with https://marian42.de/partdesigner/
https://github.com/marian42/partdesigner
Mettre Orientation en Y
Utiliser la flèche bleu vers la droite pour ajouter des blocs

*/

length=5;

size=8;

import(str("./imports/tech-",length,".stl"));

rotate([0,0,90])
    translate([size,-size,0])
        import(str("../assets/stl/bricks/I-",length,".stl"));