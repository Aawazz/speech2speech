#!/bin/bash

#--------------------------------------------------------------------#

if [[ $1 == "" ]];then
   echo "$(tput setaf 1)ERROR: Check Usage $(tput setaf 7)";
   echo "USAGE: ./speechRec.sh <fileName.wav>";
   echo "Exiting the script...";
   exit 0;
fi

# Check if file exists
if [[ ! -f $1 ]];then
   echo "$(tput setaf 1)ERROR: $1: file not found..!!$(tput setaf 7)";
   echo "Exiting the script...";
   exit 0;
fi

#----------- Speech Recognition ---------------------------#

echo "$(tput setaf 3) Performing Speech Recognition .... $(tput setaf 7)";

# Replace .wav with .pcm
rawFile=`echo $1| awk '{ sub(/.wav/,".pcm"); print }'`

# Convert .wav to .pcm
sox $1 -b 16 -s -c 1 -r 16k -t raw $rawFile

# Enter the .pcm file in pcm.list
echo $rawFile > pcm.list

# Perform Speech Recognition
./run_barista.sh

# Assuming results are stored on wsj.hyp
english=$(head wsj.hyp);

if [[ $english == "" ]];then
   echo "$(tput setaf 1)ERROR: No Speech Recognition performed/No Speech Detected$(tput setaf 7)";
   echo "Check log file for details":   
   echo "Exiting the script...";
   exit 0;
fi

# Strip the line number
english=`echo $english | awk '{ $1="" ; sub(/^[ ]/,"");print}'`;

echo "English  = $english";

# remove the .pcm file
rm $rawFile;

#----------------------------------------------------------#

#---------- Speech Translation ----------------------------#

echo "$(tput setaf 3) Performing Speech Translation .... $(tput setaf 7)";

#--- Remove the noises in text 
# Noises are [LAUGHTER], [NOISE] and [VOCALIZED-NOISE] 
english=`echo $english | awk '{sub(/\[.*\] /,"");print}'`;

# Convert it to my+name+is+jigar format to give it to the URL.
newString=`echo $english | awk '{gsub(/[ ]+/,"+"); print}'`;

spanish=`link="http://translate.google.com/translate_a/t?client=t&text=${newString}?&hl=pt-BR&sl=en&tl=es&multires=1&ssel=0&tsel=0&sc=1";
curl -sAv "Mozilla" $link | awk -F'"' '{print $2}'`

# Chop off the last weird character. I dont know why this extra character appears,
# Maybe because of the above awk coomand.
spanish=`echo $spanish | awk '{ $NF="" ; sub(/^[ ]/,"");print}'`;

# Write spanish translation to file for converting it from UTF8 -> ISO
echo $spanish > inSpanish.txt
iconv -fUTF8 inSpanish.txt -tiso-8859-2 -c -o spanish.txt;

# Print the spanish data
echo -n "Spanish = ";
cat spanish.txt

rm inSpanish.txt;

#---------------------------------------------------------------#

#------------ Text to Speech -----------------------------------#

echo "$(tput setaf 3) Performing Text to Speech .... $(tput setaf 7)";

./run_festival.sh

#------------- End of file -------------------------------------#
