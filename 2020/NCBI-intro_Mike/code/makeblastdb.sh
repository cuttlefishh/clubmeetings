#!/bin/bash
#./code/makeblastdb.sh
#purpose: Create BLAST databases from NCBI RefSeq genomes

#Make nucleotide blast databases from DNA sequence fasta files
makeblastdb \
-dbtype nucl \
-parse_seqids \
-in seqs/db_all.fasta \
-input_type 'fasta' \
-out databases/db_all \
-max_file_sz "4GB"
