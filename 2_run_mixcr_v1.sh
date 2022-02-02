#!/bin/bash

OUTDIR="outputs"
SAMPLESHEET1="inputs/samplesheet_EXP21001376.tsv"

##Edit block above to point to appropriate paths
#---------------------------------------------------------------------------


while read -r SAMPLE FASTQ1 FASTQ2 REST; do
   echo "Working on --> "$SAMPLE
   mkdir -p ${OUTDIR}/${SAMPLE}
    
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
     ${FASTQ1} ${FASTQ2} ${OUTDIR}/${SAMPLE}/${SAMPLE}analysis

done < $SAMPLESHEET1
