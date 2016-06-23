# metafont
Stroke fonts as in ink.

##26/01/16

Création d'un premier modèle, basé sur les lettres «PRODS».

###Création de deux fonctions de courbes.

####spirou_half
```
def spirou_half(suffix i,j,k,val) =
 cutdraw z.i{0u,y.j-y.i}
 ... (val[x.j,x.i],val[y.i,y.j]){z.j-z.i}
 ... z.j{x.k-x.i,0u}
 ... (val[x.j,x.k],val[y.k,y.j]){z.k-z.j}
 ... z.k{0u,y.k-y.j} enddef;
```

`spirou_half` = fonction des courbes horizontales
Exemple d'utilisation :

####spirou_crescent

```
def spirou_crescent(suffix i,j,k,val) =
 draw z.i{x.j-x.i,0u}
 ... (val[x.i,x.j],val[y.j,y.i]){z.j-z.i}
 ... z.j{0u,y.k-y.i}
 ... (val[x.k,x.j],val[y.j,y.k]){z.k-z.j}
 ... z.k{x.k-x.j,0u} enddef;
```
`spirou_crescent` = fonction des courbes verticales
test

# metafont
Stroke fonts as in ink.

##26 January 16

Création d'un premier modèle, basé sur les lettres «PRODS».

###Création de deux fonctions de courbes.

####spirou_half
```
def spirou_half(suffix i,j,k,val) =
 cutdraw z.i{0u,y.j-y.i}
 ... (val[x.j,x.i],val[y.i,y.j]){z.j-z.i}
 ... z.j{x.k-x.i,0u}
 ... (val[x.j,x.k],val[y.k,y.j]){z.k-z.j}
 ... z.k{0u,y.k-y.j} enddef;
```

`spirou_half` = fonction des courbes horizontales
Exemple d'utilisation :

####spirou_crescent

```
def spirou_crescent(suffix i,j,k,val) =
 draw z.i{x.j-x.i,0u}
 ... (val[x.i,x.j],val[y.j,y.i]){z.j-z.i}
 ... z.j{0u,y.k-y.i}
 ... (val[x.k,x.j],val[y.j,y.k]){z.k-z.j}
 ... z.k{x.k-x.j,0u} enddef;
```
`spirou_crescent` = fonction des courbes verticales

##February 2016
Criterias refined and defined
* Width
* Thickness
* Incline (x and y)
* Contrast (x and y)
* Curvature
* Tension
Separate work : morphology and ends

##22 March 2016
Criterias refined and defined
* Width
* Thickness (not so used by Franquin)
* Incline (x and y)
* Contrast (x and y)
* Curvature → Tension → Puffiness (that control morphology)
* Perspective (x and y)
* Sommit
* Mid element position (x and y)
* Openess and closeness

Separate work : ends

##22 April 2016
Initials to be used for names
* W - Width
* T - Thickness (not so used by Franquin)
* I - Incline (x and y)
* C - Contrast (x and y)
* P - Curvature → Tension → Puffiness (that control morphology)
* Z - Perspective (x and y)
* S - Sommit
* M - Mid element position (x and y)
* O - Openess and closeness

Separate work : E - ends

##29 April 2016
* w - width - chasse
* b - boldness - graisse
* i - incline (ix and iy) - inclinaison
* c - contrast (cx and cy) - contraste
* p - perspective (px and py) - perspective
* r - roundness - rondeur
* t - tension - tension
* m - mid element position (mx and my) - milieu
* o - openess (and closeness) - ouverture
* e - ends - embouts

##2 June 2016
Pad http://pads.osp.kitchen/p/metafranquin

##Doc

Organisation des fichiers et dossiers.

- Les sources des glyphes sont dans le dossier 'UC' (uppercase).

- Les variables globales sont dans le fichier 'paramSave.mp'.
    (pour modifier, chasse, graisse, tension, courbes...)

- Les fonctions se trouvent dans 'def.mp'.


###Mode Preview

    cd metapost-metafont/
    
Voir le dessin d'une lettre en prévisualisation.

    bash preview.sh A
    
Voir en inkscape

    bash preview.sh A svg
    
Pour modifier les options d'affichages, ParamSave.mp > VISUALISATION


###Mode exécution

Exécuter tout les glyphs

    bash exe.sh


##Composer un glyph

Créer un fichier au nom du glyphe dans le dossier UC.
(exemple H.mp)


###Avant de dessiner

Au début de ce fichier il faut déclarer un *input* pour associer le fichier de fonctions et le fichier de variables globales.
param.mp appelle paramSave.mp qui appelle def.mp

```
input ../param
```

À la suite, il faut déclarer la chasse de la lettre.

```
chasse:=6;
```

Ouvrir le dessin d'un glyphe.

```
spchar(65)
```
Le 65 est la valeur HTML-code du glyphe. Mais ceci n'est pas indispensable.

La fermeture du glyphe se fait par:

```
spcharend(5);
end;
```
Le 5 correspond au nombre de points du glyphe.

###Dessiner

Le dessin du glyphe doit se situer entre `spchar()` et `spcharend()`.


####Les fonctions de courbe

La fontion *spirou_half* sert à créer les courbe du «O» «C» «P» «R» etc.

![Specimen](https://github.com/speculoos/metafont/blob/master/metapost-metafont/screenshot/spirou_half.png?raw=true)

Il faut écrire la courbe de cette manière.

```
spirou_half(point1, point2, point3);
```

La fonction *crb()* sert à créer des droites qui peuvent être mise sous tension. Elle compose par exemple le A.
