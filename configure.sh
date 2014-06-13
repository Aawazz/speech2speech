

#-------- USER CONFIGURATION-------#
#-------- Enter the path of barista and festival binaries ---------#

Barista_path=/home/jigar/barista/bin;
models=/home/jigar/barista/egs/models/allModels;
Festival=/home/jigar/tts/festival/bin;

#------------ changes in run.sh -------------------------------#


Barista_path=`echo $Barista_path | awk '{ gsub("/","\/");print}'`;
conf=`echo $conf | awk '{ gsub("/","\/");print}'`;
models=`echo $models | awk '{ gsub("/","\/");print}'`;
Festival=`echo $Festival | awk '{ gsub("/","\/");print}'`;

perl -p -i -e "s/.*BARISTAROOT=.*/BARISTAROOT=${Barista_path}/" run.sh 
perl -p -i -e "s/wsjdir=.*/wsjdir=${models}/" run.sh

perl -p -i -e "s/model_rxfilename.*/model_rxfilename=${models}\/final.mdl/" conf/actors.ini
perl -p -i -e "s/fst_rxfilename.*/fst_rxfilename=${models}\/HCLG.fst/" conf/actors.ini
perl -p -i -e "s/word_syms_filename.*/word_syms_filename=${models}\/words.txt/" conf/actors.ini
perl -p -i -e "s/Festival=.*/Festival=${Festival}/" festival_tts.sh

#------------------------------------------------------------#

