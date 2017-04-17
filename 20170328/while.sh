#!/bin/bash
#test while
#by hfy 2017

i=0
while [[ $i -lt 10 ]]

do 
	echo "$i"
	(( i++ ))
done
