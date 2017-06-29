#!/usr/bin/env bash

for (( ; ; )); do curl http://pads.osp.kitchen/p/metafranquin/export/txt > metafranquin.mp && mpost -interaction=batchmode metafranquin.mp ; sleep 2; done
# mpost -interaction=batchmode -s 'outputformat="svg"' metafranquin.mp


