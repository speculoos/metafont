#!/bin/bash

#exporter le mf en ttf2otff // mftrace
rm temp/*
mftrace --formats=ttf info.mf
mv info.ttf temp/font.ttf
rm *.ttf

#convertir ttf en otf. // python
python ttf2sfd.py

#boucle de Mpost mp en svg
rm svg/*.svg
for LETTER_MP in UC/*.mp
    do
	IFS=.
	set $LETTER_MP
	LETTER_=$1
	IFS=/
	set $LETTER_
	LETTER=$2
	IFS=
	echo $LETTER
	mpost -s 'outputformat="svg"' UC/$LETTER.mp
	mv $LETTER*.svg svg/$LETTER.svg
    done

#boucle python importation des svg dans le otf.
python importSVG.py

#les remove
rm *.log 
