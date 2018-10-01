#!/bin/sh

# make bin dir
if [ ! -d ~/bin ]
then
    mkdir ~/bin
fi

# copy shell script to ~/bin
cp ./go2.sh ~/bin/co
