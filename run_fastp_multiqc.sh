#!/bin/bash

$QCFOLDER="outputsQC"
SAMPLESHEET1="../inputs/samplesheet_EXP21001376.tsv"

###Edit above block to configure appropiate paths

mkdir -p $QCFOLDER
while read -r SAMPLE FASTQ1 FASTQ2 REST; do
    echo "Working on --> "$SAMPLE
    fastp -h outputsQC/${SAMPLE}_Shallow_fastp.html -j outputsQC/${SAMPLE}_Shallow_fastp.json -i ${FASTQ1} -I ${FASTQ2}
done < $SAMPLESHEET1

multiqc $QCFOLDER
