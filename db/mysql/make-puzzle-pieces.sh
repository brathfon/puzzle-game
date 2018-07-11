#!/bin/bash


counter=300

while [ $counter -gt 0 ]
do
  let counter=counter-1
  echo "INSERT INTO puzzle_pieces (price) VALUES ($counter);"
done
