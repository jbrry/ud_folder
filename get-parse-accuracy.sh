#!/bin/bash

TASKDIR=/scratch/jwagner/ud-parsing/tira-media/universal-dependency-learning/conll18-ud-development-2018-05-06
EVAL=${HOME}/ud-parsing/conll2018/evaluation_script/conll18_tira_eval.py

SEED=$1
    for PARSER in best*; do
        OUTDIR=$PWD/${PARSER}/seed-$SEED/system
        EVALDIR=$PWD/${PARSER}/seed-$SEED/eval
        rm -rf $OUTDIR $EVALDIR
	mkdir ${OUTDIR}
        mkdir ${EVALDIR}
	cd ${PARSER}/seed-$SEED
	for TBID in *_*; do
	    cd system
	    ln -s ../$TBID/*.conllu
	    cd ..
	done
	cd ../..
	# Run evaluator
        ${EVAL} ${TASKDIR} ${OUTDIR} ${EVALDIR}
    done


# For two-pass mode, use the following:
#
#    --quit-before-parsing                                      \
#
# If using two-pass mode, don't forget to comment out "rm -rf" above.
#
#./part-2.py                       \
#    --debug                                     \
#    --deadline 1.0                                  \
#    --workers 8                                         \
#    --keep-files                                            \
#    --task-dir ${TASKDIR}                                         \
#    --work-dir ${WORKDIR}                                            \
#    --output-dir ${OUTDIR}                                             \
#    --model-dir /scratch/jwagner/ud-parsing/compressed-models/${MODEL}  \
#    --script-dir /home/jwagner/ud-parsing/ADAPT-DCU/scripts
#
# TODO: add option --part-2 to shared_task_2018.py rather than using a copy
#       that skips conflicting steps


