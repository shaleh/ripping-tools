#!/bin/bash

begin=`date +"%s"`
abcde -c ../abcde.conf
end=`date +"%s"`

duration=$((end - begin))
echo "Elapsed: $((duration / 60)) minutes"
