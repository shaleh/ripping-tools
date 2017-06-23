#!/bin/bash

BASE=${BASE:-/srv/multimedia/video/}

dir=$1
shift
audio=$1
shift
dest=$(echo "$*" | sed -e 's/ /_/g')
if [ ! -d "$BASE/$dir" ]; then
	echo "Error: $dir does not exist"
	exit 1
fi
output="$BASE/$dir/${dest}.mp4"
if [ -f "$output" ]; then
	echo "Error: $output already exists"
	exit 2
fi
echo $output

begin=`date +"%s"`
HandBrakeCLI -i /dev/dvd --main-feature -O --preset Normal -a $audio -E copy -o "$output"
end=`date +"%s"`

duration=$((end - begin))
echo "Elapsed: $((duration / 60)) minutes"
eject
