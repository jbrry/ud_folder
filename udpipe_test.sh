#!/bin/sh

UDPIPE_MODEL_DIR=~/ud_folder/models    # need to download and extract models from: http://universaldependencies.org/conll18/baseline.html
MIXED_MODEL_STR="mixed-ud"             # a mixed UD model is used for certain languages which have no training data


for tb in ~/ud_folder/ud-treebanks-v2.2/*/*-ud-test.conllu; do
  dir=`dirname ${tb}`            # e.g. /home/james/ud_folder/ud-treebanks-v2.2/UD_Afrikaans-AfriBooms  
  long_name=`basename ${dir}`    # e.g. UD_Afrikaans-AfriBooms

  # UDPipe models are formatted like so: 
  # UD_Afrikaans-AfriBooms --> afrikaans-afribooms-ud-2.2-conll18-180430.udpipe
 
  # lower the string and strip "UD_" to get the necessary key for the model 
  lower_long_name=$(echo "${long_name}" | awk '{print tolower($0)}')
  model_str=$(echo "${lower_long_name}" | awk '{print substr($0,4)}') # replace first three characters, e.g. "UD_"

  code=`basename ${tb}`   # e.g. af_afribooms-ud-test.conllu
  code=${code%%-*}        # e.g. af_afribooms
  
  for text_file in ${code}/${code}*.txt; do 
    echo "Now working on --" ${text_file}
    if [[ -n $(find "${UDPIPE_MODEL_DIR}/" -name "${model_str}"*.udpipe) ]]
    then
        echo "Found UDPipe model for ${model_str}"
        udpipe --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/"${model_str}"-ud-2.2-conll18-180430.udpipe ${text_file} > "$code/$code-udpipe.conllu"
    else 
	echo "No UDPipe model found for ${model_str}, using mixed UDPipe model"
        udpipe --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/"${MIXED_MODEL_STR}"-ud-2.2-conll18-180430.udpipe ${text_file} > "$code/$code-udpipe.conllu"
    fi 
    done
done 

# do we need to call out params at test time?

