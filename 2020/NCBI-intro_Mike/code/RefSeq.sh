#!/bin/bash
#purpose: download genome assemblies from NCBI RefSeq
#A. digitifera, A. millepora, S. pistillata, P. damicornis, O. faveolata

targets=rsyncfilepaths.txt
for link in $(cat $targets)
do
rsync --copy-links --recursive --times --verbose \
${link} \
./seqs/
done
