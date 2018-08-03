#!/bin/bash

# usage: use different models for certain PUD/ low resource languages

# cs_pud    ->   czech-pdt-ud-2.2-conll18-180430.udpipe
# en_pud    ->   english-ewt-ud-2.2-conll18-180430.udpipe
# fi_pud    ->   finnish-tdt-ud-2.2-conll18-180430.udpipe
# sv_pud    ->   swedish-talbanken-ud-2.2-conll18-180430.udpipe
# ja_modern ->   japanese-gsd-ud-2.2-conll18-180430.udpipe

UD_FOLDER=~/ud_folder
UDPIPE_MODEL_DIR=~/ud_folder/models 


echo "Now working on cs_pud"
udpipe --accuracy --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/czech-pdt-ud-2.2-conll18-180430.udpipe cs_pud/cs_pud-ud-test.conllu > "cs_pud/cs_pud-udpipe.result"


echo "Now working on en_pud"
udpipe --accuracy --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/english-ewt-ud-2.2-conll18-180430.udpipe en_pud/en_pud-ud-test.conllu > "en_pud/en_pud-udpipe.result"


echo "Now working on fi_pud"
udpipe --accuracy --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/finnish-tdt-ud-2.2-conll18-180430.udpipe fi_pud/fi_pud-ud-test.conllu > "fi_pud/fi_pud-udpipe.result"


echo "Now working on sv_pud"
udpipe --accuracy --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/swedish-talbanken-ud-2.2-conll18-180430.udpipe sv_pud/sv_pud-ud-test.conllu > "sv_pud/sv_pud-udpipe.result"


echo "Now working on ja_modern"
udpipe --accuracy --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/japanese-gsd-ud-2.2-conll18-180430.udpipe ja_modern/ja_modern-ud-test.conllu > "ja_modern/ja_modern-udpipe.result"











###############



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
  model_str=$(echo "${lower_long_name}" | awk '{print substr($0,4)}')

  code=`basename ${tb}`   # e.g. af_afribooms-ud-test.conllu
  code=${code%%-*}        # e.g. af_afribooms

  for test_file in ${code}/${code}-ud-test.conllu; do
    echo "Now working on --" ${test_file}
    if [[ -n $(find "${UDPIPE_MODEL_DIR}/" -name "${model_str}"*.udpipe) ]]
    then
        echo "Found UDPipe model for ${model_str}"
        udpipe --accuracy --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/"${model_str}"-ud-2.2-conll18-180430.udpipe ${test_file} > "$code/$code-udpipe.result"
    else
        echo "No UDPipe model found for ${model_str}, using mixed UDPipe model"
        udpipe --accuracy --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/"${MIXED_MODEL_STR}"-ud-2.2-conll18-180430.udpipe ${test_file} > "$code/$code-udpipe.result"
    fi
    done
done







