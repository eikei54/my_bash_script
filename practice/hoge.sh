#!/bin/sh

SOURCE_PATH="/x/fwtest/Traces/L2/p6s/Integrity_CIV-X04/9JA0742A_07-18-19_18-23-51/errors/Error_000_ERR_COMMAND_TIMEOUT"
WORK_PATH="/d/work/FA"


CR_RED=$'\e[1;31m'
CR_GRN=$'\e[1;32m'
CR_YEL=$'\e[1;33m'
CR_BLU=$'\e[1;34m'
CR_MAG=$'\e[1;35m'
CR_CYN=$'\e[1;36m'
CR_END=$'\e[0m'



#echo $SOURCE_PATH
JIRA_PATH=`echo $SOURCE_PATH | sed -e "s:^.*Traces::"`

#echo "/x/fwtest/Traces/L2/p6s/Integrity_CIV-X04/9JA0742A_07-18-19_18-23-51/errors/Error_000_ERR_COMMAND_TIMEOUT" | sed -e "s:^.*Traces::"

#hoge="\""$(echo -E $1)"\""
#echo $1
org_param=$(echo $1 | sed -e 's:\\:\/:g' | sed -e 's/://g')
#org_param=$(echo $1 | sed -e 's:\\:\/:g')
echo "/"$org_param

TARGET_PATH=$WORK_PATH
TARGET_PATH+=$jira_no
TARGET_PATH+=$JIRA_PATH

echo "pass1"
if [ "$(ls -l ./*.d3z  2>/dev/null)" ]; then
    echo "pass3"
    printf "%s\n" "${CR_RED}No memdump exist in $TARGET_PATH.${CR_END}"
    printf "%s\n" "Open $SOURCE_PATH ..."
    start $SOURCE_PATH
    exit 1
else
    echo "pass4"
    printf "%s\n" "${CR_GRN}At least one memdump file exist in  $TARGET_PATH.${CR_END}"
fi

echo "pass2"

#ls ./*.d3z > /dev/null 2>&1
#if [ $? -ne 0 ]; then
#    echo "No match"
#    printf "%s\n" "${CR_RED}No memdump exist in $TARGET_PATH.${CR_END}"
#    printf "%s\n" "Open $SOURCE_PATH ..."
#else
#    echo "${CR_GRN}At least one file in $TARGET_PATH.${CR_END}"
#fi

#echo $TARGET_PATH

#if [ ! -e $TARGET_PATH ]; then
#    mkdir -p $TARGET_PATH
#fi

#cp -rp $SOURCE_PATH $TARGET_PATH


#for fore in `seq 30 37`; do
#    printf "\e[${fore}m \\\e[${fore}m \e[0m\n";
#    for mode in 1 4 5; do
#        printf "\e[${fore};${mode}m \\\e[${fore};${mode}m \e[0m";
#        for back in `seq 40 47`; do
#            printf "\e[${fore};${back};${mode}m \\\e[${fore};${back};${mode}m \e[0m";
#        done;
#        echo;
#    done;
#    echo;
#done;
#printf " \\\e[0m\n"

