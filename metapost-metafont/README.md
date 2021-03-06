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
