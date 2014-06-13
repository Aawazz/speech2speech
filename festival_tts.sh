#!/bin/bash

if [[ $1 == "" ]];then
   echo "ERROR: Check USAGE";
   echo "USAGE: festival_tts.sh <spanish_text>";
   echo "Exiting the script";
   exit 0;
fi
echo $1;

Festival=/home/jigar/tts/festival/bin

echo $1 | $Festival/festival --tts --language spanish;
