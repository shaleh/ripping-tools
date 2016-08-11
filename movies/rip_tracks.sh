#!/bin/bash

if [ $# -ne 5 ]; then
	>&2 echo "Usage: $0 season first_episode first_title count cmdfile"
	exit 1
fi

season=$(printf "%02d" $1)
episode_num=$2
initial=$3  # First title
count=$4  # how many titles?
cmdfile=$5

device=/dev/dvd

for i in $(seq $initial $((initial + count - 1)))
do
    title=$i
    echo "Title $title"
    echo "Episode $episode_num"
    episode=$(printf "%02d" $episode_num)
    episode_num=$((episode_num + 1))
    . $cmdfile
done

eject $device
