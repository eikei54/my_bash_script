#!/bin/sh


# check the number of arguments
if [ $# -ne 1 ]; then
    echo "parameter number; $#" 1>&2
    echo "paramter nums to be 1" 1>&2
    exit 1
fi

# trim white space from input string
TESTCODE_NAME=$(echo $1)
#echo $TESTCODE_NAME

if [ ${#TESTCODE_NAME} -ne 7 ]; then
    echo "Length for input           : ${#TESTCODE_NAME}" 1>&2
    echo "TestCode name's length to be 7" 1>&2
    exit 1
fi

URL_CODE_TRACKER="http://tecodetracker.rochester.hgst.com/api/v1/products/"

#
# get PROD_TYPE
#
# expect the character like LXJ, LHA, PCM
#
PROD_TYPE=$(echo ${TESTCODE_NAME:0:3})
URL_CODE_TRACKER=$URL_CODE_TRACKER$PROD_TYPE"/releases/"$TESTCODE_NAME"?pathvalidate=false"

# display Code Tracer URL
echo "CodeTracker-URL:"
echo "  "$URL_CODE_TRACKER

# get length for json data array
testcode_len=$(curl -s $URL_CODE_TRACKER | jq length )

# Operate json array
for id_ in $(seq 0 $((testcode_len - 1))); do
    row=$(curl -s $URL_CODE_TRACKER | jq .softwareComponents[$id_].name -r)
    if [ $row = "ipMfg" ] \
        || [ $row = "mfgCmd" ] \
        || [ $row = "dtmData" ]; then
        branch_path_=$(curl -s $URL_CODE_TRACKER | jq .softwareComponents[$id_].softwareChangeUri -r)
        hash_val_=$(curl -s $URL_CODE_TRACKER | jq .softwareComponents[$id_].softwareChangeNumber -r)
        binPath_=$(curl -s $URL_CODE_TRACKER | jq .softwareComponents[$id_].compiledUri -r)
        server_=$(curl -s $URL_CODE_TRACKER | jq .softwareComponents[$id_].compiledServer -r)


        fullPath_=$(echo $server_"\\"$binPath_ | sed 's/\\/\\/g')
        echo ${row^}":"
        echo "  Branch: "$branch_path_"   #"$hash_val_
        echo "  Binary: "$fullPath_
    fi
done

