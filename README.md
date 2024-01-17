# vcf2fa
An awk script for converting VCF to fasta files, one file per sample.

## Requirements
The VCF file(s) must be sorted by coordinate.  
Diploid; Column 9 starts with "GT".

## Usage
`vcf2fa.sh sample_list vcf_file [vcf_file2 ...]`  
"sample_list": nameroot of the output files corresponding to the samples in the VCF file; one sample per line; no white spaces are allowed.
