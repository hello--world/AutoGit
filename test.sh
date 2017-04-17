#!/bin/bash
#auto test shell
#by hfy 2017

DIR="test"

if [ ! -d $DIR ];then

  mkdir -p $DIR
  echo "Create $DIR succeed!"

else

  echo "$DIR is exist!"

fi
