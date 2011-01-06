#!/bin/sh

for i in $( ls $1 );
do
echo "Converting $i to ogv\n"
ffmpeg2theora $1
echo "\nFinished Converting!\n";
done
