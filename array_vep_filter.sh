#!/bin/bash

#BSUB -q short
#BSUB -P re_gecip_paediatrics
#BSUB -cwd "/re_gecip/paediatrics/wlee/GCGR_variant_search/array_test_3/"
#BSUB -o logs/vep_array_%J.stdout
#BSUB -e logs/vep_array_%J.stderr
#BSUB -n 2
#BSUB -R "rusage[mem=2000]"
#BSUB -M 2000
#BSUB -J "vepFilter[1-1000]%100"


file_string=$(ls -1 /re_gecip/paediatrics/wlee/GCGR_variant_search/array_test_3/althom_*_annotated.vcf.gz)
file_array=($file_string)

vcf=${file_array[$LSB_JOBINDEX]}

base=$(basename "$vcf" _annotated.vcf.gz)

module purge
module load bcftools/1.21

bcftools +split-vep "$vcf" \
        -i "gnomADe_AF < 0.02 || gnomADg_AF < 0.02" \
        -d \
	-H \
        -f '%CHROM\t%POS\t%REF\t%ALT\t%EXON\t%INTRON\t%gnomADe_AF\t%gnomADg_AF\t%CADD_PHRED\t%SpliceAI_pred_DS_AG\t%SpliceAI_pred_DS_AL\t%SpliceAI_pred_DS_DG\t%SpliceAI_pred_DS_DL\n' \
        > "$base"_rare_variants_v2.tsv

# awk -F'\t' 'NR==1 || ($7 != "." && $7 > 20)' "$base"_rare_variants.tsv  > "$base"_rare_pathogenic.tsv
