#!/bin/bash

# Parameters for you to populate
RESULTS_FOLDER="/re_gecip/paediatrics/wlee/GCGR_variant_search/array_test_3"
PROJECT_CODE="re_gecip_paediatrics"
INPUT_FILE="/re_gecip/paediatrics/wlee/GCGR_variant_search/array_test_3/vep_input_3.csv"

## Further environment setup. No need to change this.
mkdir -p ${RESULTS_FOLDER}

## Script which will be submitted to the HPC. This command is provided as an example and can be adjusted to suit your needs.
/gel_data_resources/example_scripts/annotate_variants_with_vep/115.2/vep.sh \
    -i ${INPUT_FILE} \
    -c ${PROJECT_CODE} \
    -g GRCh38 \
    -v 115.2 \
    -p '--plugin dbNSFP,/public_data_resources/dbNSFP/dbNSFP4.7/4.7/dbNSFP4.7c/dbNSFP4.7c_grch38.gz,/public_data_resources/vep_resources/VEP_plugins/dbNSFP_replacement_logic,ALL --plugin LoF,loftee_path:/opt/vep/.vep/Plugins/loftee_GRCh38,human_ancestor_fa:/public_data_resources/vep_resources/LOFTEE/Build-38/human_ancestor.fa.gz,gerp_bigwig:/public_data_resources/vep_resources/LOFTEE/Build-38/gerp_conservation_scores.homo_sapiens.GRCh38.bw,conservation_file:/public_data_resources/vep_resources/LOFTEE/Build-38/loftee.sql --plugin SpliceAI,snv=/public_data_resources/SpliceAI/Predicting_splicing_from_primary_sequence-66029966/genome_scores_v1.3/spliceai_scores.raw.snv.hg38.vcf.gz,indel=/public_data_resources/SpliceAI/Predicting_splicing_from_primary_sequence-66029966/genome_scores_v1.3/spliceai_scores.raw.indel.hg38.vcf.gz --plugin CADD,/public_data_resources/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz --plugin mutfunc,db=/public_data_resources/ensembl-data/mutfuc_db/mutfunc_data.db' \
    -d '--custom /public_data_resources/clinvar/20240627/vcf_GRCh38/clinvar.vcf.gz,ClinVar,vcf,exact,0,CLNDN,CLNDNINCL,CLNDISDB,CLNDISDBINCL,CLNHGVS,CLNREVSTAT,CLNSIG,CLNSIGCONF,CLNSIGINCL,CLNVC,CLNVCSO,CLNVI --custom /public_data_resources/vep_resources/Build-38/gerp_conservation_scores.homo_sapiens.GRCh38.bw,GERP,bigwig --custom /public_data_resources/phylop100way/hg38.phyloP100way.bw,PhyloP,bigwig --custom /public_data_resources/TOPMed/allele_frequencies/bravo-dbsnp-all.vcf.gz,topmedg,vcf,exact,0,AF,SVM' \
    -s '--variant_class --sift b --gene_phenotype --regulatory --numbers --hgvs --protein --symbol --ccds --uniprot --tsl --appris --canonical --mane --biotype --domains --check_existing --af --max_af --af_1kg --af_gnomade --af_gnomadg --pubmed' \
    -o ${RESULTS_FOLDER} \
    -q short \
    -n 2 \
    -m 8G


# output of vep annotation is specified in vep_input.csv file, where the ID column (first value will be used and giv the output as ID_annotated.vcf
