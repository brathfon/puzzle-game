#!/bin/bash


counter=300

while [ $counter -gt 0 ]
do
  echo "$counter"
  let counter=counter-1
done