#!/bin/sh

dest="/srv/multimedia/audio"

for i in $*; do
    [ -d "$dest/$i" ] || mkdir "$dest/$i"

    for item in `ls $i`; do
	mv "$i/$item" "$dest/$i/"
    done
done
