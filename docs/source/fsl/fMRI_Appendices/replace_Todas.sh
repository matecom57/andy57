#!/bin/bash

dir=$(ls -1 *.rst)

for ss in $dir
do
   echo $ss
   sed -i -e 's/figura:/figure:/g' $ss
done
