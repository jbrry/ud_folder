# ud_folder

### Introduction

This is a folder for scripts related to UD Parsing. 

At the moment, the scripts are designed to turn gold CoNLLU files to UDPipe predicted output. This is useful to evaluate parsing systems which do not take in gold CoNLLU data as input, e.g. in the CoNLL UD Parsing shared tasks where systems are expected to parse raw text or UDPipe predicted output. 

As a way of evaluating a parsing system after the official TIRA runs and when the VM has been re-allocated to TIRA, it will be useful to have a folder which contains the test data as it is found on TIRA (e.g. predicted by the baseline UDPipe) to carry on further experiments, perform sanity checks etc.


### Requirements

In order to use these scripts you will need to get [UDPipe](http://ufal.mff.cuni.cz/udpipe): 

```
git clone https://github.com/ufal/udpipe
cd udpipe/src
make
```

Then copy the `udpipe/src/udpipe` binary executable to your $PATH or link it to /usr/bin/ etc. 

#### Baseline models 

You can download the baseline UDPipe 2.2 models which were used for the shared task here: http://universaldependencies.org/conll18/baseline.html

### Instructions

- To get the UD 2.2 treebanks run `get_data.sh`
- To create a folder for each treebank and convert the CoNLLU test file back to text run `create_test_text_file.sh`
- Finally, to use UDPipe to predict on the test.txt files to generate UDPipe predcited CoNLLU files run `udpipe_test.sh` 

### Work in progress

Things which still need to be done:

- Ensure we are using the same params used by UDPipe for the 2018 shared task
- Ensure we are using the same models used by UDPipe the 2018 shared task, e.g. for the following cases:

1. Czech PUD ← Czech PDT
2. English PUD ← English EWT
3. Finnish PUD ← Finnish TDT
4. Japanese Modern ← Japanese GSD
5. Swedish PUD ← Swedish Talbanken
6. Mixed model for all other cases with no training data. 

### Useful references and acknowledgements

1. https://github.com/ufal/udpipe
2. https://github.com/CoNLL-UD-2017/UFAL-UDPipe-1.2
3. http://ufal.mff.cuni.cz/udpipe
4. http://universaldependencies.org/conll18/baseline.html
5. http://wiki.apertium.org/wiki/UDPipe

I would like to thank the developers of UDPipe. 
