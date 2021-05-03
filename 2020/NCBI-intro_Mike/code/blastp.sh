#!/bin/bash
#purpose: Conduct blastp searches against NCBI RefSeq genome assemblies

blastp \
-db ${prodir}/data/blastdb_protein_all \
-query ${prodir}/query/nfkb.fasta \
-out ${prodir}/outputs/blastdb_protein_all
