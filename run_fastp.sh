#!/bin/bash
while read -r SAMPLE FASTQ1 FASTQ2 REST; do
    echo "Working on --> "$SAMPLE
    fastp -h outputsQC/${SAMPLE}_Shallow_fastp.html -j outputsQC/${SAMPLE}_Shallow_fastp.json -i ${FASTQ1} -I ${FASTQ2}
done < ../inputs/samplesheet_EXP21001376.tsv
