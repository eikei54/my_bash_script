
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "parameter number; $#" 1>&2
    echo "paramter nums to be 1" 1>&2
    exit 1
fi

#echo "file Name :" $1
#echo "line nuber:" $2

lineNum=5000000

SOURCE_PATH="$1"

#
# Get current path
#
echo $SOURCE_PATH
CURR_PATH=`pushd $SOURCE_PATH`
set ${CURR_PATH}
echo "hoge1"
echo ${1}
SOURCE_PATH=${1}
echo "hoge2"
pwd


result="$(file $SOURCE_PATH)"
if [[ $result == *"cannot open"* ]] ;then
    echo "NO FILE FOUND ($result) ";
elif [[ $result == *"directory"* ]] ;then
    echo "DIRECTORY FOUND ($result) ";

    #for file in `ls $fpath/*.txt`; do
    ##    echo "${file}"
    #    filesize=`wc -c < ${file}`
    #    if [ $filesize -ge $SIZE_THRESHOLD ]; then
    #        #echo "${file}"
    #        #source $PATH_SP_ETM ${file}
    #        inner_sp_etm ${file}
    #    fi
    #done
else
    echo "FILE FOUND ($result) ";
fi

# back to the initial directory
popd


function inner_sp_etm ( ) {

    fpath_ = $1
    fname_ext="${fpath_##*/}"
    fname="${fname_ext%.*}_"
    echo $fname_ext
    echo $fname_
}

