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
* W Width
* T Thickness (not so used by Franquin)
* I Incline (x and y)
* C Contrast (x and y)
* P Curvature → Tension → Puffiness (that control morphology)
* Z Perspective (x and y)
* S Sommit
* M Mid element position (x and y)
* O Openess and closeness

Separate work : E ends
