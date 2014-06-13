#!/bin/bash

spanish=`cat spanish.txt`;
echo "Spanish = ${spanish}";

if [[ $spanish == "" ]];then
   echo "ERROR: Check no text found in spanish.txt";
   echo "Exiting the script festival_tts.sh";
   exit 0;
fi

#--- Remove the noises in text --------------#
# Noises are [LAUGHTER], [NOISE] and [VOCALIZED-NOISE] 

spanish=`echo $text | awk '{sub(/\[.*\] /,"");print}'`;

#--------------------------------------------#

Festival=/home/jigar/tts/festival/bin

echo $spanish | $Festival/festival --tts --language spanish;
