#!/bin/sh

# Copyright (c) 2019 Akihiro Kamimura <Akihiro.Kamimura@wdc.com>
# All rights reserved.


#
# Editable Part
#

LOCAL_DIR_PATH="/d/work/FA"
PREFIX_JIRA_NO="CCB8-"$1

#
# Bash Console Color Config
#

CR_RED=$'\e[1;31m'
CR_GRN=$'\e[1;32m'
CR_YEL=$'\e[1;33m'
CR_BLU=$'\e[1;34m'
CR_MAG=$'\e[1;35m'
CR_CYN=$'\e[1;36m'
CR_END=$'\e[0m'

#
# Program Start
#

usage_msg='usage:
 - copy X_path data to the local
 - extract compressed bz2 format files
 - open local copied directory

     -h             print help message
     -v             print version'

# check the option arguments
#
while getopts hv option
do
    case "$option" in
    h)
        echo "${usage_msg}"
        exit 0
        ;;
    v)
        echo "version 1"
        exit 0
        ;;
    esac
done
shift $(($OPTIND - 1))

SOURCE_PATH=$2

# check the number of arguments
if [ $# -ne 2 ]; then
    echo "parameter number; $#" 1>&2
    echo "paramter nums to be 2" 1>&2
    exit 1
fi

#
# Get Folder name, like "Error_000_ERR_COMMAND_TIMEOUT"
#

FOLDER_NAME=`echo $SOURCE_PATH | sed -e "s:^\(.*\)[\/|\\]::1"`
TEXT_TO_CONSOLE="FOLDER_NAME is ...."
echo $TEXT_TO_CONSOLE$FOLDER_NAME


# convert "\" to "/"
SOURCE_PATH=`echo $SOURCE_PATH | sed -e 's:\\\:\/:g'`

# In case FOLDER_NAME became "XXXX.txt.bz2"
# the SOURCE_PATH should be re-look again.

if [[ $FOLDER_NAME =~ .*\.txt\.bz2 ]]; then
    TEMP_SOURCE_PATH=`echo $SOURCE_PATH | sed -e "s:\([^\\|\/]\+\?\)\?\$::"`

    # delete 1 character from $TEMP
    # by having unrequired "/"
    SOURCE_PATH=${TEMP_SOURCE_PATH/%?/}
    FOLDER_NAME=`echo $SOURCE_PATH | sed -e "s:^\(.*\)/::1"`

    #echo $FOLDER_NAME
fi

#
# Get original path without Folder name
#

JIRA_PATH=`echo $SOURCE_PATH | sed -e "s:^\(.*\)/.*:\1:"`
JIRA_PATH=`echo $JIRA_PATH | sed -e "s:^.*Traces::"`

TARGET_PATH=$LOCAL_DIR_PATH"/"
TARGET_PATH+=$PREFIX_JIRA_NO
TARGET_PATH+=$JIRA_PATH

#
# Get original path to be used in the local foler
#
echo "Copying X_Drive data to ...."
TEXT_TO_CONSOLE="Copied To       : "

echo $TEXT_TO_CONSOLE$TARGET_PATH"/"$FOLDER_NAME

if [ ! -e $TARGET_PATH ]; then
    mkdir -p $TARGET_PATH
fi

#
# Copy X Drive's data to the Target Path
#

cp -rp $SOURCE_PATH $TARGET_PATH

# ReSet $TARGET_PATH folder

TARGET_PATH=$TARGET_PATH"/"$FOLDER_NAME

#
# Check if ETM, Memdump exist or not in $TARGET_PATH
#
#echo $TARGET_PATH"/*.d3z"
ls $TARGET_PATH/*.d3z  1>/dev/null 2>/dev/null
# option A for ls command can show the result without "current dir", .:w
if [ $? -ne 0 ]; then
    printf "%s\n" "${CR_YEL}<Warning> No memdump exist in $TARGET_PATH${CR_END} "
    printf "%s\n" "Open original X_Path.."
    printf "%s\n" "$SOURCE_PATH"
    start $SOURCE_PATH
    exit 1
else
    printf "%s\n" "${CR_GRN}At least one memdump file exist in  $TARGET_PATH.${CR_END}"
fi

#
# if ETM, Memdump files seems to exist, the current directory
# would move to $TARGET_PATH in local directory
#
pushd $TARGET_PATH

# open TARGET_PATH folder

echo "Open Local Dir: $TARGET_PATH"
start $TARGET_PATH

# extract "txt.bz2"
find ./ -name "*.txt.bz2" | xargs -i bzip2 -d {}


for file in `ls $TARGET_PATH/*.txt`; do
    echo "${file}"
done
