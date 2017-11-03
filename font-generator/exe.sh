#!/usr/bin/env bash

rm svg/*.svg

for (( ; ; ));do
  curl http://pads.osp.kitchen/p/metafranquin/export/txt > svg/metafranquin.mp
  mpost -interaction=batchmode svg/metafranquin.mp
  mv *.svg svg/
sleep 4;
done
# mpost -interaction=batchmode -s 'outputformat="svg"' metafranquin.mp


