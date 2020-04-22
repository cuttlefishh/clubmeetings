## A brief intro to NCBI resources
This information accompanies the presentation to NCBI BLAST+ applications both through the web portal and the command line interface.


Link to the NCBI's homepage: https://www.ncbi.nlm.nih.gov/  
Link to BLAST webpage: https://blast.ncbi.nlm.nih.gov/Blast.cgi  

BLAST+ Command Line Applications installers and exectuables: https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/  
BLAST+ Command Line Applications User Manual: https://www.ncbi.nlm.nih.gov/books/NBK279690/  
Functionality offered by BLAST+ applications: https://www.ncbi.nlm.nih.gov/books/NBK279692/  

BLAST+ databases available via ftp: https://ftp.ncbi.nlm.nih.gov/blast/db/  

## Getting started with this workshop

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

Add the `bin` folder from the extracted archive to your path. For example, add
the following line to your `~/.bashrc` file:
```
export PATH="/PATH/TO/ncbi-blast-2.10.0+/bin":$PATH
```
And change the `/PATH/TO` part to the path where you have put the extracted
archive.


Gather the neccessary reference sequences from the NCBI databases you want to BLAST your query sequences against:
```
test
```

## BLAST functions

The BLAST+ package offers three categories of applications: 1.) search tools, 2.) BLAST database tools, and 3.) sequence filtering tools.  

1. search tools:  blastn, blastp, blastx, tblastx, tblastn, psiblast, rpsblast, and rpstblastn
2. BLAST database tools: makeblastdb, blastdb_aliastool, makeprofiledb, and blastdbcmd

Refer to the shell scripts in the "code" directory. 

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