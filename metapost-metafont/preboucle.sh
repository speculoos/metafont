#!/bin/bash

#mpost UC/$1.mp
#rm *.log
#okular $1.*
for (( ; ; ));do
  mpost -interaction=batchmode UC/$1.mp
sleep 1; done

