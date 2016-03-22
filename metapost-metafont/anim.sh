#!/bin/bash
SPIROU=('esp' 'A' 'esp')
DOSSIER='A'
tLen=${#SPIROU[@]}
Format='png '
echo ${SPIROU[*]}

for ((i=1; i<70; i++ ))
do 
    if [ $1 = "chasse" ]
    then
	CHEMIN='animation/chasse/lettres/'	
	VarPost=`echo "scale=2; 1 + $i / 10" | bc -l`
	sed -r 's/^ux:=.*$/ux:='$VarPost'u;/g' paramSave.mp >> param.mp
    fi
    
    if [ $1 = "graisse" ]
    then
	CHEMIN='animation/graisse/lettres/'
	VarPost=`echo "scale=2; 2 + $i / 10" | bc -l`
	sed -r 's/^sas:=.*$/sas:='$VarPost'u;/g' paramSave.mp >> param.mp
    fi
    if [ $1 = "courbure" ]
    then
	CHEMIN='animation/courbure/RO/'
	VarPost=`echo "scale=2; 1 - $i / 100" | bc -l`
	sed -r 's/^val:=.*$/val:='$VarPost';/g' paramSave.mp >> param.mp
    fi
    if [ $1 = "plein" ]
    then
	CHEMIN='animation/plein-delie/'$DOSSIER'/'
	mkdir $CHEMIN
	VarPostx=`echo "scale=2; 1.1 - $i / 100" | bc -l`
	VarPost=`echo "scale=2; 1.1 + $i / 100" | bc -l`
	    sed -r 's/^sasx:=.*$/sasx:='$VarPost'sas;/g' paramSave.mp >> param.mp
	    sed -r 's/^sasy:=.*$/sasy:='$VarPostx'sas;/g' param.mp >> param.mp
    fi
    if [ $1 = "tension" ]
    then
	CHEMIN='animation/tension/'$DOSSIER'/'
	mkdir $CHEMIN
	VarPost=`echo "scale=2; 1.00 - $i / 100" | bc -l`
	sed -r 's/^tens:=.*$/tens:='$VarPost';/g' paramSave.mp >> param.mp
	VarPost=$VarPost
    fi

    for (( a=0; a<${tLen}; a++ ));
	do
	    mpost -s 'outputformat="svg"' UC/${SPIROU[$a]}.mp
	    mv ${SPIROU[$a]}*.svg svg/${SPIROU[$a]}.svg
	    convert svg/${SPIROU[$a]}.svg $CHEMIN/${SPIROU[$a]}-$1-$VarPost.png
	done
    echo '%TempFile' > param.mp
    Final=''
    for ((j=0;j<${tLen}; j++ ));
    do
	Final+=$CHEMIN${SPIROU[$j]}-$1-$VarPost.$Format
    done
    montage ${Final[*]} -mode Concatenate  -tile x1 -geometry +2+2 $CHEMIN/Anim-$1-$VarPost.png
    #eog $CHEMIN/Anim-$1-$VarPost.png
    

done
#convert -delay 50 $CHEMIN/Anim-$1-*.png Anim-$1-complet.gif
mkdir $CHEMIN/final

cp $CHEMIN/Anim-$1-*.png $CHEMIN/final

mogrify -resize x500 $CHEMIN/final/*.png

convert -size 564x500 xc:white +swap -gravity center -delay 0 \
	               $CHEMIN/final/Anim-$1-*.png  $CHEMIN/final/Anim-$1.gif

convert  $CHEMIN/final/Anim-$1.gif -resize x400 $CHEMIN/final/Anim-$1-resize.gif

rm *.log
