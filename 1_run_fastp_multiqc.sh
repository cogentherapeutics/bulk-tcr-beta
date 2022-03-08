#!/bin/bash


SAMPLESHEET1="~schavan/projects/tcr_beta_seq/input_trbs/samplesheet_EXP21001376.tsv" #same samplesheet as given to mixcr, only SAMPLE column is relevant for this script
IN_DIR="/mnt/seqcore/fastqs/tcrseq/EXP21001376_FFPE" #raw fastq dir
OUT_DIR="~schavan/projects/tcr_beta_seq/out" #dir to hold final trimmed fastq files

##Edit block above ONLY to point to appropriate paths
#---------------------------------------------------------------------------

mkdir -p $QCFOLDER
while read -r SAMPLE FASTQ1 FASTQ2 REST; do

echo "Working on --> "$SAMPLE
#Merge Lanes
    cat $IN_DIR/$SAMPLE*R1* > ${OUT_DIR}/${SAMPLE}.merged.R1.fastq.gz
    cat $IN_DIR/$SAMPLE*R2* > ${OUT_DIR}/${SAMPLE}.merged.R2.fastq.gz

echo "Running fastp--->"$SAMPLE
#Run fastp
    fastp -h $OUT_DIR/${SAMPLE}_fastp.html -j $OUT_DIR/${SAMPLE}_fastp.json \
    -i ${OUT_DIR}/${SAMPLE}.merged.R1.fastq.gz -I ${OUT_DIR}/${SAMPLE}.merged.R2.fastq.gz \
    -o ${OUT_DIR}/${SAMPLE}.merged.trimmed.R1.fastq.gz -O ${OUT_DIR}/${SAMPLE}.merged.trimmed.R2.fastq.gz \
    --dedup --cut_front --cut_tail_window_size --cut_tail --cut_front_window_size \
    --n_base_limit --length_required 40 --low_complexity_filter --overrepresentation_analysis

#Before trimming
    fastqc ${FASTQ1} ${FASTQ2}
#After trimming
    fastqc ${SAMPLE}.merged.trimmed.R1.fastq.gz ${SAMPLE}.merged.trimmed.R2.fastq.gz

#Run MultiQC
    echo "Running MultiQC--->"
    multiqc $OUT_DIR
    
done < $SAMPLESHEET1

multiqc $QCFOLDER
