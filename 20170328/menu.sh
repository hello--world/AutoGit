#!/bin/bash
#menu test
#by hfy 2017

#if [[ $1 -eq "" ]];then
if [[ -z "$1" ]];then
	echo "---------------"
	echo "1.打印1"
	echo "2.打印2"
	echo "3.打印3"
	echo "---------------"
fi

if [[ "$1" -eq "1" ]];then
	echo "1"
fi

if [[ "$1" -eq "2" ]];then
	echo "2";
fi

if [[ "$1" -eq "3" ]];then
	echo "3"
fi
