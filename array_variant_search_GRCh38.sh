# this script searches for alternate homozygous variants from a given list of GRCh38 standard VCF files taken from Labkey

#!/bin/bash

#BSUB -q short
#BSUB -P re_gecip_paediatrics
#BSUB -cwd "/re_gecip/paediatrics/wlee/GCGR_variant_search/array_test_3/"
#BSUB -o logs/job.%J.stdout
#BSUB -e logs/job.%J.stderr
#BSUB -n 2
#BSUB -R "rusage[mem=2000]"
#BSUB -M 2000
#BSUB -J "myArray[18000-19000]%100"

mkdir -p ./logs

#The file all_genome_standard_vcf_filepaths_GRCh38.tsv contains a list of file paths for the standard vcf of each participant mapped to genome build GRCh38

# The file paths to the standard vcf files and participant IDs are contained in column and column 1 of all_genome_standard_vcf_filepaths_GRCh38.tsv, respectively
paths=$(cut -f 9 all_genome_standard_vcf_filepaths_GRCh38.tsv)
ids=$(cut -f 1 all_genome_standard_vcf_filepaths_GRCh38.tsv)

# The strings of filepaths and participant IDs are converted to Bash arrays
patharr=($paths)
idarr=($ids)

id=${idarr[$LSB_JOBINDEX]}
path=${patharr[$LSB_JOBINDEX]}


vcffile=$(find "$path" -type f -name "*.vcf.gz")

# Then, intersect the files for the coordinates of GCGR gene body, contained in the GCGR_coords_GRCh38.bed file

module load bedtools/2.31.1

bedtools intersect -header -wa -a "$vcffile" -b GCGR_coords_GRCh38.bed > "$id".vcf

# use FILTER expression in BCFtools to filter for good quality and alternate homozygous variants
# infile.vcf is the participant's VCF file restricted to GCGR coords
# outfile.vcf contains GCGR variants from participant that pass quality check and are inherited as alternate homozygous

module load bcftools/1.21

infile="$id".vcf
outfile="althom_$id"

bcftools view -i 'FILTER = "PASS" && GT="1/1"' "$infile" -o "$outfile".vcf

