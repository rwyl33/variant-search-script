#!/bin/bash

#BSUB -q short
#BSUB -P re_gecip_paediatrics
#BSUB -cwd "/re_gecip/paediatrics/wlee/GCGR_variant_search/array_test_3/"
#BSUB -o logs/master_job.%J.stdout
#BSUB -e logs/master_job.%J.stderr
#BSUB -n 1
#BSUB -R "rusage[mem=1000]"
#BSUB -M 1000
#BSUB -J "compileAllVariants"


# Combine all files, skip duplicate headers, prepend source filename
awk 'FNR==1 && NR!=1 {next} {print FILENAME "\t" $0}' *_rare_pathogenic.tsv > master_rare_pathogenic_variants.tsv
