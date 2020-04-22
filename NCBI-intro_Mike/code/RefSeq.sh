#!/bin/bash
#purpose: download genome assemblies from NCBI RefSeq

refseq="rsync://ftp.ncbi.nlm.nih.gov/genomes/all/GCF"
#A. digitifera, A. millepora, S. pistillata, P. damicornis, O. faveolata, D. gigantea, E. pallida, N. vectensis
targets="000/222/465/GCF_000222465.1_Adig_1.1 004/143/615/GCF_004143615.1_amil_sf_1.1 002/571/385/GCF_002571385.1_Stylophora_pistillata_v1 003/704/095/GCF_003704095.1_ASM370409v1 002/042/975/GCF_002042975.1_ofav_dov_v1 004/324/835/GCF_004324835.1_DenGig_1.0 001/417/965/GCF_001417965.1_Aiptasia_genome_1.1 000/209/225/GCF_000209225.1_ASM20922v1"
for target in $targets
do
echo "Copying ${target} directory protein files from NCBI Refseq"
rsync --copy-links --recursive --times --verbose \
${refseq}/${target}/*protein* \
"$1"/seqs/
done
