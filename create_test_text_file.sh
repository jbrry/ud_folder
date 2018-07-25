#!/bin/sh

# get test file for each treebank in the folder
for tb in ~/ud_folder/ud-treebanks-v2.2/*/*-ud-test.conllu; do
  dir=`dirname $tb`
  echo $dir            # e.g. /home/james/ud-parsing-udpipe/ud-treebanks-v2.2/UD_Afrikaans-AfriBooms
  
  long_name=`basename $dir`
  echo $long_name      # e.g. UD_Afrikaans-AfriBooms

  code=`basename $tb`
  echo $code           # e.g. af_afribooms-ud-test.conllu

  code=${code%%-*}
  echo $code           # e.g. af_afribooms
  

  echo $code $long_name | tee -a iso_names.txt      # put tbid and tbname in a text file

  mkdir -p "$code"                                  # make a new directory for each tbid
  if [ -f "$dir"/"$code"-ud-test.conllu ]; then     # if there exists a path with tbid-ud-test.conllu
    cp "$dir"/"$code"-ud-test.conllu "$code"        # copy that file to the newly created tbid folders
#  else
#    perl conllu_split.pl "$code" "$code" <"$dir"/"$code"-ud-train.conllu # split the text file
  fi

  for conllu in "$code"/*.conllu; do   
    perl conllu_to_text.pl --language="$code" <"$conllu" >"${conllu%.conllu}.txt" # transform the conllu file to text file
  done
done
