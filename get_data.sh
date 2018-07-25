#!/bin/sh

# get the UD 2.2 treebanks/tools
curl --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-2837{/ud-treebanks-v2.2.tgz,/ud-documentation-v2.2.tgz,/ud-tools-v2.2.tgz}

# handle unpacking 
gunzip ud-documentation-v2.2.tgz ud-tools-v2.2.tgz ud-treebanks-v2.2.tgz
tar -xvf ud-documentation-v2.2.tar
tar -xvf ud-tools-v2.2.tar
tar -xvf ud-treebanks-v2.2.tar

# clean up directory
rm ud-documentation-v2.2.tar ud-tools-v2.2.tar ud-treebanks-v2.2.tar
