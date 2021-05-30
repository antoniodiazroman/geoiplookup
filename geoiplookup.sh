#!/bin/bash

if [[ $# -eq 0 ]];
then
    echo "Usages:"
    echo "# geoiplookup.sh host1 host2 ... hostN"
    echo "# geoiplookup.sh hostsfile.txt"
    exit 1
elif [[ $# -eq 1 && -f $1 ]];
then
    parallel --gnu -j $(nproc) "echo \"{}: \"\$(geoiplookup {})" ::: $(cat $1)
else
    parallel --gnu -j $(nproc) "echo \"{}: \"\$(geoiplookup {})" ::: $@
fi
