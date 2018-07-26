#!/bin/bash

# usage: call script if you want to only evaluate on treebanks which were included in the 2018 shared task
# requires shared_task_tbs.txt which contains the TBID of the 82 treebanks used in ST 2018

for tb in ~/ud_folder/ud-treebanks-v2.2/*/*-ud-test.conllu; do
  dir=`dirname $tb`          # e.g. /home/james/ud_folder/ud-treebanks-v2.2/UD_Afrikaans-AfriBooms
  long_name=`basename $dir`  # e.g. UD_Afrikaans-AfriBooms
  code=`basename $tb`        # e.g. af_afribooms-ud-test.conllu
  code=${code%%-*}           # e.g. af_afribooms

  # remove new UD v2.2 treebanks that were not used in shared task
  if grep -Fxq ${code} shared_task_tbs.txt
  then
      echo "${code} was used in the 2018 shared task; leaving directory unchanged"
  else
      echo "directory removal notification: removing directory ${code} as it was not used in the 2018 shared task"
      rm -r ${code}
  fi
done
