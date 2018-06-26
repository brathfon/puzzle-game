#!/bin/bash


outer=0
counter=0

while [ $outer -lt 11 ]
do
  #echo "$outer"

  inner=0
  while [ $inner -lt 4 ]
  do
    cp green-$inner.png  $counter-green-$inner.png
    #echo "counter $counter"
    let inner=inner+1
    let counter=counter+1
  done

  let outer=outer+1
done