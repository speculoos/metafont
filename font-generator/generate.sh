#!/usr/bin/env bash
rm svg/clean/*.svg

# bash exe.sh

python path.py

function inkscapeAction {
  LETTER=$1
  echo $LETTER
  NUMB_STROKE="$(cut -d\| -f2 $LETTER | grep -o 'id="stroke' | wc -l)"
  NUMB_GOUACHE="$(cut -d\| -f2 $LETTER | grep -o 'id="gouache' | wc -l)"


  STROKE="$(for (( i = 1; i <= ${NUMB_STROKE}; i++ ));do
        echo --select=stroke$i
      done)"

  GOUACHE="$(for (( i = 1; i <= ${NUMB_GOUACHE}; i++ ));do
        echo '--select=gouache'$i
        echo '--verb SelectionDiff'
      done)"

  inkscape \
    ${STROKE} \
    --verb SelectionUnGroup \
    --verb StrokeToPath \
    --verb SelectionUnion \
    ${GOUACHE} \
    --verb EditPasteWidth \
    --verb FileSave \
    --verb FileClose \
    --verb FileQuit \
  $LETTER
}

for LETTER_svg in svg/clean/*svg
do

  inkscapeAction $LETTER_svg
done

python import.py
