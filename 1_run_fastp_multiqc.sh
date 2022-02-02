#!/bin/bash

$QCFOLDER="outputsQC"
SAMPLESHEET1="../inputs/samplesheet_EXP21001376.tsv"

##Edit block above to point to appropriate paths
#---------------------------------------------------------------------------

mkdir -p $QCFOLDER
while read -r SAMPLE FASTQ1 FASTQ2 REST; do
    echo "Working on --> "$SAMPLE
    fastp -h outputsQC/${SAMPLE}_fastp.html -j outputsQC/${SAMPLE}_fastp.json -i ${FASTQ1} -I ${FASTQ2}
    fastqc ${FASTQ1} ${FASTQ2}
done < $SAMPLESHEET1

multiqc $QCFOLDER
