#!/bin/bash

spanish=`cat spanish.txt`;

# Remove the spanish.txt file
rm spanish.txt;

if [[ $spanish == "" ]];then
   echo "ERROR: Check no text found in spanish.txt";
   echo "Exiting the script festival_tts.sh";
   exit 0;
fi

Festival=/home/jigar/tts/festival/bin

echo $spanish | $Festival/festival --tts --language spanish;
