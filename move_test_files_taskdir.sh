#!/bin/bash

# Usage: Move the gold test files in the folder to the taskdirectory which replicates the task dir on TIRA. 
#        Renames the ud-test files to match that of "goldfile" in metadata.json
#        {"lcode":"af", "tcode":"afribooms", "rawfile":"af_afribooms.txt", "psegmorfile":"af_afribooms-udpipe.conllu", "outfile":"af_afribooms.conllu", "goldfile":"af_afribooms.conllu"},

TASKDIR=~/udpipe_test_files

for tb in ~/ud_folder/shared-task-treebanks2.2/*/*-ud-test.conllu; do

  dir=`dirname $tb`          # e.g. /home/james/ud_folder/shared-task-treebanks2.2/UD_Afrikaans-AfriBooms
  long_name=`basename $dir`  # e.g. UD_Afrikaans-AfriBooms
  code=`basename $tb`        # e.g. af_afribooms-ud-test.conllu
  tbid=${code%%-*}           # e.g. af_afribooms
  
  cd ${dir}  
  cp ${code} ${tbid}.conllu
  mv ${tbid}.conllu ${TASKDIR}
  cd ..
done
