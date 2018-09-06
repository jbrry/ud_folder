#!/bin/bash

# Usage: move all ST 2018 files into their own treebank folder to avoid using new treebanks. 
#        assumes 'remove_new_tbs.sh' has already been run to remove new tbs from ud_folder

ST2018TBDIR=~/ud_folder/shared-task-treebanks2.2

for tb in ~/ud_folder/*/*-ud-test.conllu; do
  dir=`dirname ${tb}`
  mv ${dir} ${ST2018TBDIR}
done
