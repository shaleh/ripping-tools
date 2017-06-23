#!/bin/bash

if [ $# -ne 6 ]; then
	>&2 echo "Usage: $0 title ch1 ch2 first_chapter chapter_length cmdfile"
	exit 1
fi

title=$1
ch1=$2
chN=$3
initial=$4  # First chapter
length=$5  # how many chapters per item?
cmdfile=$6

device=/dev/dvd

for i in $(seq $ch1 $chN)
do
        # Need the minus 1 because 2 - 6 is 5 items not 4.
        last=$((initial + $length - 1))
	echo "Starting $i"
	echo "$initial to $last"
	episode=$(printf "%02d" $i)
	. $cmdfile
	initial=$((last + 1))
done

eject $device
