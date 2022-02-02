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

1) create a tab delimited samplesheet per experiment for input to mixcr as below e.g.samplesheet_EXP21001293.tsv. No headers. Specifiy complete paths to the fastq files
```
DSCO28-MTC-1    ../data/DSCO28-MTC-1_S7_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-1_S7_L001_R2_001.fastq.gz
DSCO28-MTC-2    ../data/DSCO28-MTC-2_S1_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-2_S1_L001_R2_001.fastq.gz
DSCO28-MTC-3    ../data/DSCO28-MTC-3_S3_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-3_S3_L001_R2_001.fastq.gz
DSCO28-TRF-1    ../data/DSCO28-TRF-1_S6_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-1_S6_L001_R2_001.fastq.gz
DSCO28-TRF-2    ../data/DSO28-TRF-2_S4_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-2_S4_L001_R2_001.fastq.gz
DSCO28-TRF-3    ../data/DSCO28-TRF-3_S5_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-3_S5_L001_R2_001.fastq.gz
FFPE-9G7045 ../data/FFPE-9G7045_S2_L001_R1_001.fastq.gz ../data/FFPE-9G7045_S2_L001_R2_001.fastq.gz
```
2) Create another tab delimited samplesheet for preovide mixcr outputs as input to VDJtools as below e.g. metadataToConvert_EXP21001293.txt. Header present. Do not specify complete paths, but place the file in the same folder as the inputs folder. (Strange Bug!) 	
```file_name	sample_id
	DSCO28-MTC-1analysis.clonotypes.TRB.fixed.txt	DSCO28-MTC-1
	DSCO28-MTC-2analysis.clonotypes.TRB.fixed.txt	DSCO28-MTC-2
	DSCO28-MTC-3analysis.clonotypes.TRB.fixed.txt	DSCO28-MTC-3
	DSCO28-TRF-1analysis.clonotypes.TRB.fixed.txt	DSCO28-TRF-1
	DSCO28-TRF-2analysis.clonotypes.TRB.fixed.txt	DSCO28-TRF-2
	DSCO28-TRF-3analysis.clonotypes.TRB.fixed.txt	DSCO28-TRF-3
	FFPE-9G7045analysis.clonotypes.TRB.fixed.txt	FFPE-9G7045```
