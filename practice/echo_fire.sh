#!/bin/sh
echo "called File!"

tar_list=$(find ./ -name "*.tar.bz2")
for id_ in $tar_list; do
    echo "enter for loop"
    echo $id_
done

source ./echo_ice.sh


