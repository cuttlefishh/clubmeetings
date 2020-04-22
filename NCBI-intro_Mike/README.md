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
For example, add the following line to your `~/.bashrc` file:
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


## BLAST functions

The BLAST+ package offers three categories of applications: 1.) search tools, 2.) BLAST database tools, and 3.) sequence filtering tools.  

1. search tools:  blastn, blastp, blastx, tblastx, tblastn, psiblast, rpsblast, and rpstblastn
2. BLAST database tools: makeblastdb, blastdb_aliastool, makeprofiledb, and blastdbcmd

Now, refer to the shell scripts in the `code` directory. 

Gather the neccessary reference sequences from the NCBI databases you want to BLAST your query sequences against:
```
test
```

makeblastdb
```
test
```

blastn

blastp


tblastn


## More example BLAST searches



## Example BLAST workflow: coral immune genes
NOD-like receptors









