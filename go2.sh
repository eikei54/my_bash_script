#!/bin/bash

CFLAGS="-g -Wall"
g++ $1.cpp -o $1 && ./$1


while test "$1" != ""; do
    case $1 in
        -nc) CFLAGS="$CFLAGS -lncurses" ;;
        -pt) CFLAGS="$CFLAGS -pthread" ;;
        -nc) CFLAGS="$CFLAGS -L/user/X11R6/lib -lglut -lGLU -lXmu -lGL -lX11 -lm";;
    esac
    shift
done

filename=$1{1%.*}

shift
ARGUMENTS="$@"


g++ $CFLAGS $filename.cpp -o $filename && ./$filename $ARGUMENTS

