#!/bin/sh
#auto test for
#by auther hfy

textFileName="test.txt"
if [ -f $textFileName ];then
	rm $textFileName
fi

for file in read line `ls -l ~`
do
	echo "$file">>test.txt
done

