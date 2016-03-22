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

