# bulk-tcr-beta
Bulk TCR-beta chain sequencing workflow - with DNA as starting material

# Notion page for detailed documentation
https://www.notion.so/cogen/Running-Bulk-TCR-Sequencing-pipeline-for-translational-lab-members-5bb8a7eb89b04ea68ab601a8e8c7bbab

This includes 3 scripts

1) fastp - QC and pre-processing of fastq files/ multiqc to create a multisample report
2) mixcr - alignment and assembly of clonotypes from fastq files
3) vdjtools - postprocessing/graphical and text file results for interpretation

Currently fastp, multiqc, mixcr and vdjtools are installed on the galaxy server

Inputs

1) create a tab delimited samplesheet per experiment for mixcr as below e.g.samplesheet_EXP21001293.tsv
```
DSCO28-MTC-1    ../data/DSCO28-MTC-1_S7_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-1_S7_L001_R2_001.fastq.gz
DSCO28-MTC-2    ../data/DSCO28-MTC-2_S1_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-2_S1_L001_R2_001.fastq.gz
DSCO28-MTC-3    ../data/DSCO28-MTC-3_S3_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-3_S3_L001_R2_001.fastq.gz
DSCO28-TRF-1    ../data/DSCO28-TRF-1_S6_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-1_S6_L001_R2_001.fastq.gz
DSCO28-TRF-2    ../data/DSO28-TRF-2_S4_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-2_S4_L001_R2_001.fastq.gz
DSCO28-TRF-3    ../data/DSCO28-TRF-3_S5_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-3_S5_L001_R2_001.fastq.gz
FFPE-9G7045 ../data/FFPE-9G7045_S2_L001_R1_001.fastq.gz ../data/FFPE-9G7045_S2_L001_R2_001.fastq.gz
```
