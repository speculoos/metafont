##Doc
Organisation des fichiers et dossiers.

-Les sources des glyphes sont dans le dossier 'UC' (uppercase).

-Les variables globales sont dans le fichier 'paramSave.mp'.
    (pour modifier, chasse, graisse, tension, courbes...)

-Les fonctions se trouvent dans 'def.mp'.


###Mode Preview
Voir le dessin d'une lettre dans en prévisualition.

    bash preview.sh A

###Mode exécution
Exécuter tout les glyphs

    bash exe.sh


###Composer un glyph
Créer un fichier au nom du glyphe dans le dossir UC.
(exemple H.mp)


####Avant de dessiner.
Au début de ce fichier il faut déclarer un *input* pour associer le fichier de fonctions et le fichier de variables globales.

```
input ../param

```

À la suite il faut déclarer la chasse de la lettre.

```
chasse:=6;
```

Ouvrir le dessin d'un glyphe.

```
spchar(65)
```
Le 65 est la valeur HTML-code du glyph. Mais ceci n'est pas indispensable.

La fermeture du glyphe se fait par:

```
spcharend(5);
end;
```
Le 5 correspond au nombres de points du glyph.

####Dessiner

Le dessin du glyphe doit se situer entre `spchar()` et `spcharend()`.


