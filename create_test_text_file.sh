#!/bin/sh

# get test file for each treebank in the folder
for tb in ~/ud_folder/ud-treebanks-v2.2/*/*-ud-test.conllu; do
  dir=`dirname $tb`          # e.g. /home/james/ud_folder/ud-treebanks-v2.2/UD_Afrikaans-AfriBooms
  long_name=`basename $dir`  # e.g. UD_Afrikaans-AfriBooms
  code=`basename $tb`        # e.g. af_afribooms-ud-test.conllu
  code=${code%%-*}           # e.g. af_afribooms

  echo $code $long_name | tee -a iso_names.txt      # put tbid and tbname in a text file

  mkdir -p "$code"                                  # make a new directory for each tbid
  if [ -f "$dir"/"$code"-ud-test.conllu ]; then     # if there exists a path with tbid-ud-test.conllu
    cp "$dir"/"$code"-ud-test.conllu "$code"        # copy that file to the newly created tbid folders
  fi
  for conllu in "$code"/*.conllu; do   
    perl conllu_to_text.pl --language="$code" <"$conllu" >"${conllu%.conllu}.txt" # transform the conllu file to text file
  done
done
