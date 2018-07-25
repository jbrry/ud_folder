#!/bin/sh

UDPIPE_MODEL_DIR=~/ud_folder/udpipe_baseline/models

for tb in ~/ud_folder/ud-treebanks-v2.2/*/*-ud-test.conllu; do
  dir=`dirname ${tb}`            # e.g. /home/james/ud_folder/ud-treebanks-v2.2/UD_Afrikaans-AfriBooms  
  long_name=`basename ${dir}`    # e.g. UD_Afrikaans-AfriBooms

  # UDPipe models are formatted like so: 
  # UD_Afrikaans-AfriBooms --> afrikaans-afribooms-ud-2.2-conll18-180430.udpipe
 
  # lower the string and strip "UD_" to get the necessary key for the model 
  lower_long_name=$(echo "${long_name}" | awk '{print tolower($0)}')
  model_str=$(echo "${lower_long_name}" | awk '{print substr($0,4)}') # replace first three characters, e.g. "UD_"
  echo ${model_str}

  code=`basename ${tb}`   # e.g. af_afribooms-ud-test.conllu
  code=${code%%-*}        # e.g. af_afribooms
  
  for text_file in ${code}/${code}*.txt; do 
    echo ${text_file}

   ## Work in progres ##
   udpipe --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/"${model_str}"-ud-2.2-conll18-180430.udpipe ${text_file} > "$code/$code-udpipe.conllu"

   done
done 

# ensure the use of the right params. 


