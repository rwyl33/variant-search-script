# Variant search script
These set of scripts finds GCGR variants which are inherited as alternate homozygous in participants in Genomics England, annotate these variants, and extract the allele frequencies and pathogenicity prediction scores of these variants. 

## array_variant_search_GRCh38.sh
This script searches for alternate homozygous variants from a given list of GRCh38 standard VCF files taken from Labkey

## vep_input_script.sh
This script formats the participants vcf files (containing alternate homozygous GCGR variants) for VEP annotation

## array_vep_script.sh
This is the script provided by Genomics England to annotate variants with VEP 115.2

## array_vep_filter.sh
This is the script used to extract VEP annotations, such as gnomAD allele frequency, CADD Phred score, and SpliceAI scores and filters for variants with gnomAD genome allele frequency < 0.02 and CADD Phred scores > 20

## compile_rare_pathogenic_script.sh
This is the script which combines all alternate homozygous GCGR variants which have gnomAD genome allele frequency < 0.02 and CADD Phred scores > 20 into one master file. 
