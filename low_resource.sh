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
udpipe --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/czech-pdt-ud-2.2-conll18-180430.udpipe cs_pud/cs_pud-ud-test.txt > "cs_pud/cs_pud-udpipe.conllu"


echo "Now working on en_pud"
udpipe --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/english-ewt-ud-2.2-conll18-180430.udpipe en_pud/en_pud-ud-test.txt > "en_pud/en_pud-udpipe.conllu"


echo "Now working on fi_pud"
udpipe --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/finnish-tdt-ud-2.2-conll18-180430.udpipe fi_pud/fi_pud-ud-test.txt > "fi_pud/fi_pud-udpipe.conllu"


echo "Now working on sv_pud"
udpipe --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/swedish-talbanken-ud-2.2-conll18-180430.udpipe sv_pud/sv_pud-ud-test.txt > "sv_pud/sv_pud-udpipe.conllu"


echo "Now working on ja_modern"
udpipe --tokenize --tag --parse "${UDPIPE_MODEL_DIR}"/japanese-gsd-ud-2.2-conll18-180430.udpipe ja_modern/ja_modern-ud-test.txt > "ja_modern/ja_modern-udpipe.conllu"

