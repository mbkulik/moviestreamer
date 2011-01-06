#!/bin/sh

for i in $( ls $1 );
do
    if [[ $i == *".mp4"* ]]; then

        echo "Converting $i to ogv"

        ogvfile="${1}/${i/.mp4/.ogv}"
        #echo "ogvfile is: $ogvfile\n"

        if [ -f $ogvfile ];
        then
            echo "$ogvfile already exists, skipping conversion"
        else
            ffmpeg2theora $1 --output $ogvfile
            echo "Finished Converting!\n";
        fi
    fi
done
