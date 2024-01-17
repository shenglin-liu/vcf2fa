#!/bin/awk -f

# An awk script for converting VCF to fasta files.
# The VCF file(s) must be sorted by coordinate.
# Diploid; Column 9 starts with "GT".
# Usage: [path]/vcf2fa.sh sample_list vcf_file [vcf_file2 ...]

BEGIN{
	iupac["A"]["A"]="A";
	iupac["C"]["C"]="C";
	iupac["G"]["G"]="G";
	iupac["T"]["T"]="T";
	
	iupac["A"]["C"]="M";
	iupac["A"]["G"]="R";
	iupac["A"]["T"]="W";
	
	iupac["C"]["A"]="M";
	iupac["C"]["G"]="S";
	iupac["C"]["T"]="Y";
	
	iupac["G"]["A"]="R";
	iupac["G"]["C"]="S";
	iupac["G"]["T"]="K";
	
	iupac["T"]["A"]="W";
	iupac["T"]["C"]="Y";
	iupac["T"]["G"]="K";
	
	iupac["N"]["N"]="N";
	
	FS="\t";chr="";
}
FNR==NR{f[NR+9]=$1".fa";next}
/^#/{next}
$1!=chr{
	if(chr!="")for(i=10;i<=NF;i++)printf "\n" > f[i];
	chr=$1;pos=1;
	for(i=10;i<=NF;i++)print ">"chr > f[i];
}
{
	for(j=pos;j<$2;j++)for(i=10;i<=NF;i++)printf "N" > f[i];
	split($5,a,",");
	a[0]=$4;a["."]="N";
	for(i=10;i<=NF;i++)
	{
		split($i,b,"[/|:]");
		printf iupac[a[b[1]]][a[b[2]]] > f[i];
	}
	pos=$2+1;
}
END{for(i in f)printf "\n" > f[i]}
