#!/bin/bash

if [ $# -ne 1 ]; then
    echo "parameter number; $#" 1>&2
    echo "paramter nums to be 1" 1>&2
    exit 1
fi

#echo "file Name :" $1
#echo "line nuber:" $2

lineNum=5000000

fpath=$1
fname_ext="${fpath##*/}"
fname="${fname_ext%.*}_"
#echo $fname

cur_path=$(pwd)
if [ ! -e $cur_path/split_etm ]; then
    mkdir $cur_path/split_etm
fi
split.exe -l $lineNum -d $1 split_etm/$fname --additional-suffix=.txt

