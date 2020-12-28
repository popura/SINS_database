#!/bin/bash

if [ ! -d data ]
then
  mkdir data
fi
cd data

nodes=(1 2 3 4 6 7 8 9 10 11 12 13)

records=(
  2546677
  2547307
  2547309
  2555084
  2547313
  2547315
  2547319
  2555080
  2555137
  2558362
  2555141
  2555143
)

for i in `seq 1 "${#records[*]}"`
#for i in `seq 1 4`
do
  if [ ! -d node"${nodes[i-1]}" ]
  then
    mkdir node"${nodes[i-1]}"
  fi
  cd node"${nodes[i-1]}"

  for fname in `cat ../../node"${nodes[i-1]}".md5 | awk '{print $2}'`
  do
    echo $fname
    if [ ! -e $fname ]
    then
      wget -O $fname https://zenodo.org/record/"${records[i-1]}"/files/$fname?download=1
    fi
  done
  md5sum -c `../../hash/node"${nodes[i-1]}".md5`
  cd ../
done
