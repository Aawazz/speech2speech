#!/usr/bin/env bash
# This script sets the environment variables for barista binaries.

# Enter the barista binary directory
BARISTAROOT=/home/jigar/barista/bin
export PATH=$BARISTAROOT:$PATH;

wsjdir=/home/jigar/barista/egs/models/allModels

barista conf/actors.ini conf/graph.dot &> log

perl int2sym.pl --ignore-first-field $wsjdir/words.txt wsj.tra > wsj.hyp
#perl int2sym.pl --ignore-first-field $hub4dir/words.txt hub4.tra > hub4.hyp
#perl int2sym.pl --ignore-first-field $icsidir/words.txt icsi.tra > icsi.hyp
