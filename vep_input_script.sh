#!/bin/bash

#BSUB -q short
#BSUB -P re_gecip_paediatrics
#BSUB -o logs/vep_input.%J.stdout
#BSUB -e logs/vep_input.%J.stderr
#BSUB -J "vep_input"
#BSUB -R "rusage[mem=1000] span[hosts=1]"
#BSUB -M 1000
#BSUB -n 1
#BSUB -cwd "/re_gecip/paediatrics/wlee/GCGR_variant_search/array_test_3"



echo "ID,VCF" > vep_input_3.csv

find /re_gecip/paediatrics/wlee/GCGR_variant_search/array_test_3/ -name "althom_*" | while read f; do
        echo "$(basename "$f"|cut -d. -f1 ),$f"
        done >> vep_input_3.csv
