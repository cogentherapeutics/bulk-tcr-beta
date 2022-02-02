#!/bin/bash
while read -r SAMPLE FASTQ1 FASTQ2 REST; do
   echo "Working on --> "$SAMPLE
   mkdir -p ../outputs/${SAMPLE}
    
		mixcr analyze amplicon \
     --verbose \
     --species hsa \
     --starting-material dna \
     --5-end v-primers --3-end j-primers \
     --adapters adapters-present \
     --report analysis_${SAMPLE} \
     --receptor-type trb \
     --region-of-interest CDR3 \
     --only-productive \
     ${FASTQ1} ${FASTQ2} ../outputs/${SAMPLE}/${SAMPLE}analysis

done < ../inputs/samplesheet_EXP21001376.tsv
