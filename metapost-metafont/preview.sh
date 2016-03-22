#!/bin/bash
LETTER=$1
FORMAT=$2

cat paramSave.mp > param.mp

mpost -s 'outputformat="svg"' UC/$LETTER.mp
mv $LETTER*.svg svg/$LETTER.svg
convert svg/$LETTER.svg  png/$LETTER.png

if [ $FORMAT = "svg" ]
then 
    inkscape svg/$LETTER.svg
else
    #gftodvi spirou.2602gf
    eog png/$LETTER.png
fi 

echo '%TempParamFile' > param.mp

rm *.log
