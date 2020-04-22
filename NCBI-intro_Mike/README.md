## A brief intro to NCBI resources
This information accompanies the presentation to NCBI BLAST+ applications both through the web portal and the command line interface.

Link to the NCBI's homepage: https://www.ncbi.nlm.nih.gov/  
Link to BLAST webpage: https://blast.ncbi.nlm.nih.gov/Blast.cgi  

BLAST+ Command Line Applications installers and exectuables: https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/  
BLAST+ Command Line Applications User Manual: https://www.ncbi.nlm.nih.gov/books/NBK279690/  
Functionality offered by BLAST+ applications: https://www.ncbi.nlm.nih.gov/books/NBK279692/  
BLAST+ databases available via ftp: https://ftp.ncbi.nlm.nih.gov/blast/db/

This tutorial is adapted from Eric Normandeau's: https://github.com/enormandeau/ncbi_blast_tutorial


## Getting started with this workshop and installing BLAST+

Clone the MBE Coding Club "clubmeetings" repository onto your local machine:
```
git clone https://github.com/MBE-Coding-Club/clubmeetings.git
```

Get the compiled  NCBI blast+ executables onto your local computer from this URL:
```
ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/
```
Decompress the archive. For example:
```
tar xvfz ncbi-blast-2.10.0+-x64-linux.tar.gz 
```
Add the `bin` folder from the extracted archive to your path.  
For example, add the following line to your `~/.bash_profile` file:
```
export PATH="/PATH/TO/ncbi-blast-2.10.0+/bin":$PATH
```
And change the `/PATH/TO` part to the path where you have put the extracted
archive.


## Basic BLAST database and query search example

In order to test BLAST, you need a test fasta file. Use the following files
that come with the tutorial:

- `seqs/sequences.fasta`
- `seqs/reference.fasta`

#### Create blast database
The different blast tools require a formatted database to search against. In
order to create the database, we use the `makeblastdb` tool:

```
makeblastdb -in seqs/reference.fasta -title reference -dbtype nucl -out databases/reference
```

This will create a list of files in the `databases` folder. These are all part
of the blast database.

#### Run test BLAST
We can now blast our sequences against the database. In this case, both our
query sequences and database sequences are DNA sequences, so we use the
`blastn` tool:
```
blastn -db databases/reference -query seqs/sequences.fasta -evalue 1e-3 -word_size 11 -outfmt 0 > outputs/sequences.reference
```
You can use different output formats with the `outmft` option:
```
 -outfmt <String>
   alignment view options:
     0 = pairwise,
     1 = query-anchored showing identities,
     2 = query-anchored no identities,
     3 = flat query-anchored, show identities,
     4 = flat query-anchored, no identities,
     5 = XML Blast output,
     6 = tabular,
     7 = tabular with comment lines,
     8 = Text ASN.1,
     9 = Binary ASN.1,
    10 = Comma-separated values,
    11 = BLAST archive format (ASN.1)
```

#### More options and getting help

If you need help to know the options and parameters you can pass `blastn` and
the other blast+ utilities, use the `--help` option and pipe the output into
`less`, for example:
```
blastn --help | less
```

## BLAST+ functions

The BLAST+ package offers three categories of applications: 1.) search tools, 2.) BLAST database tools, and 3.) sequence filtering tools.  

1. search tools:  blastn, blastp, blastx, tblastx, tblastn, psiblast, rpsblast, and rpstblastn
2. BLAST database tools: makeblastdb, blastdb_aliastool, makeprofiledb, and blastdbcmd

makeblastdb
```
test
```

blastn


## BLAST output

Bit score
E-value
Identities
Gaps 

Helpful YouTube videos from the NCBI: Part I https://www.youtube.com/watch?v=nO0wJgZRZJs  
Part II https://www.youtube.com/watch?v=Z7ek7UoP7Bg


## More example BLAST searches

blastp

tblastn

## Further exploration of the NCBI's resources with BLAST

You are now encouraged to create your own BLAST databases and conduct searches using your own query sequences!

Follow the links below to download the neccessary reference sequences from the NCBI databases you want to BLAST your query sequences against:
https://www.ncbi.nlm.nih.gov/refseq/
https://ftp.ncbi.nlm.nih.gov/genomes/refseq/

Or you can try to download the genome assemblies you are interested in using with the NCBI Datasets tool. 
https://www.ncbi.nlm.nih.gov/datasets/
https://www.ncbi.nlm.nih.gov/datasets/docs/command-line-start/
https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/

To start, download the datasets tool and add the executable to your path:
```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/mac/datasets'
```
For example, add the following line to your `~/.bash_profile` file:
```
export PATH="/PATH/TO/datasets":$PATH
```
And change the `/PATH/TO` part to the path where you have put the executable file. You may have to `chmod +x datasets` to use the datasets tools. 


## Detailed example: BLAST searches for stony coral MyD88 homologs 

To illustrate more features of BLAST+ on the command line, we will now cover a more specific example of using BLAST to search for coral genes with sequence similarity to myeloid differentiation primary protein 88, or MyD88, an evolutionarily conserved cytosolic adapter protein that plays a central role in immune responses. 
First, will we need to obtain reference sequences for all of the five genome assemblies in the NCBI RefSeq database. These are genome assemblies that have been submitted to the NCBI from various research groups and have received annotations in the NCBI's automated genome annotation pipeline.  
There are five coral species with genomes available in NCBI RefSeq: *Acropora digitifera*, *A. millepora*, *Orbicella faveolata*, *Stylophora pistillata*, and *Pocillopora damicornis*.
For the remainder of the tutorial you can also refer to the shell scripts in the `code` directory.

The genome assemblies were accessed using the NCBI Datasets tool (https://www.ncbi.nlm.nih.gov/datasets/), the command-line program jq (https://stedolan.github.io/jq/), and the assembly summary for all genomes in the NCBI RefSeq database (https://ftp.ncbi.nlm.nih.gov/genomes/refseq/assembly_summary_refseq.txt).
```
datasets assembly-descriptors --refseq tax-name Scleractinia --limit ALL 
datasets assembly-descriptors --refseq tax-name Scleractinia --limit ALL | jq '.datasets[].assembly_accession' -r > refseq_genomes.txt
grep -f refseq_genomes.txt assembly_summary_refseq.txt > genomes_summary.txt
```

```
awk -F "\t" '$11=="latest"{print $20}' genomes_summary.txt > ftpdirpaths.txt

awk 'BEGIN{FS=OFS="/";filesuffix="protein.faa.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' ftpdirpaths.txt > ftpfilepaths.txt
```

```
for target in ftpfilepaths.txt
do
rsync --copy-links --recursive --times --verbose \
${target} \
./seqs
done
```

Make a local BLAST database with just the Scleractinian protein sequences as reference:
```
makeblastdb -dbtype prot -in seqs/ -out databases/coral_prot
```

Conduct a  blastp search to identify proteins with similarity to MyD88
```
blastp -db databases/amil -query seqs/myd88_prot.fasta -evalue 1e-3 -outfmt 0 > output/myd88_amil.txt
```
