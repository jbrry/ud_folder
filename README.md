# UD-Folder

This is a folder for scripts related to UD Parsing. 

At the moment, the scripts are designed to turn gold CoNLLU files to UDPipe predicted output. This is useful to evaluate parsing systems which do not take in gold CoNLLU data as input, e.g. in the CoNLL UD Parsing shared tasks where systems are expected to parse raw text or UDPipe predicted output. 

As a way of evaluating a parsing system after the official TIRA runs and when the VM has been re-allocated to TIRA, it will be useful to have a folder which contains the test data as it is found on TIRA (e.g. predicted by the baseline UDPipe).

In order to use these scripts you will need to get UDPipe: 

- git clone https://github.com/ufal/udpipe
- cd udpipe/src
- make

Then copy the 'udpipe/src/udpipe' binary executable to your $PATH or link it to /usr/bin/ etc. 

- To get the UD 2.2 treebanks run 'get_data.sh'
- To create a folder for each treebank and convert the CoNLLU test file back to text run 'create_test_text_file.sh'
- Finally, to use UDPipe to predict on the test.txt files to generate UDPipe predcited CoNLLU files run 'udpipe_test.sh' (Wokr in Progress)

### Things which still need to be done:
- Finish prediction script 'udpipe_test.sh'
- Ensure we are using the same params used by UDPipe for the 2018 shared task
- Ensure we are using the same splits used by UDPipe the 2018 shared task

Useful references and acknowledgements:

1. https://github.com/ufal/udpipe
2. https://github.com/CoNLL-UD-2017/UFAL-UDPipe-1.2
3. http://ufal.mff.cuni.cz/udpipe
4. http://universaldependencies.org/conll18/baseline.html
5. http://wiki.apertium.org/wiki/UDPipe

Thank you to the developers of UDPipe.
