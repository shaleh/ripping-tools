#!/bin/bash

source rip.cfg

OPTIND=1
while getopts "a:t:" opt
do
      case "$opt" in
          a|audio)
              AUDIO="-a $OPTARG"
              ;;
          t|track)
              TRACK="-t $OPTARG"
              ;;
          \?)  # getopts is done with what it understands
              break
              ;;
          -*)
              echo "Usage: $0 [-a|--audio a,b,c...] [-t|--track N] outdir track name"
              exit 0
              ;;
          *)
              echo "Unknown value: $opt"
              exit 1
              ;;
      esac
done

shift $((OPTIND - 1))  # Move past hyphen arguments, what is left is the path and the name

dir=$1
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
$RIP_TOOL -i /dev/dvd -O --preset Normal -E copy $TRACK $AUDIO -o "$output"
end=`date +"%s"`

duration=$((end - begin))
echo "Elapsed: $((duration / 60)) minutes"
eject
