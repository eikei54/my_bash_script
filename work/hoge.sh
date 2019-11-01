#!/bin/bash

TARGET_PATH="/d/work/FA/CCB8-34002/XJ/051/ComboX_303"
SIZE_THRESHOLD=800000000
PATH_SP_ETM=`which sp_etm.sh`

echo $PATH_SP_ETM

for file in `ls $TARGET_PATH/*.txt`; do
#    echo "${file}"
    filesize=`wc -c < ${file}`
    if [ $filesize -ge $SIZE_THRESHOLD ]; then
        #echo "${file}"
        source $PATH_SP_ETM ${file}
    fi
done
