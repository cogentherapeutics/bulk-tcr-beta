# bulk-tcr-beta
Bulk TCR-beta chain sequencing workflow - with DNA as starting material

### Notion page for detailed documentation
https://www.notion.so/cogen/Running-Bulk-TCR-Sequencing-pipeline-for-translational-lab-members-5bb8a7eb89b04ea68ab601a8e8c7bbab

This includes below steps and scripts

1) fastp - QC and pre-processing of fastq files/ multiqc to create a multisample report: `run_fastp_multiqc.sh`
2) mixcr - alignment and assembly of clonotypes from fastq files: `run_mixcr_v1.sh`, `fix_TRBfiles.R`
3) vdjtools - postprocessing/graphical and text file results for interpretation: `run_vdjtools_single_samples.sh`, `run_vdjtools_custom_samples.sh`, `vdjtools-patch.sh`

Currently fastp, multiqc, mixcr and vdjtools are installed on the galaxy server

## Inputs

1) SAMPLSHEET1
create a tab delimited samplesheet per experiment for input to mixcr as below e.g.samplesheet_EXP21001293.tsv. No headers. Specifiy complete paths to the fastq files
```
DSCO28-MTC-1    ../data/DSCO28-MTC-1_S7_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-1_S7_L001_R2_001.fastq.gz
DSCO28-MTC-2    ../data/DSCO28-MTC-2_S1_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-2_S1_L001_R2_001.fastq.gz
DSCO28-MTC-3    ../data/DSCO28-MTC-3_S3_L001_R1_001.fastq.gz    ../data/DSCO28-MTC-3_S3_L001_R2_001.fastq.gz
DSCO28-TRF-1    ../data/DSCO28-TRF-1_S6_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-1_S6_L001_R2_001.fastq.gz
DSCO28-TRF-2    ../data/DSO28-TRF-2_S4_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-2_S4_L001_R2_001.fastq.gz
DSCO28-TRF-3    ../data/DSCO28-TRF-3_S5_L001_R1_001.fastq.gz    ../data/DSCO28-TRF-3_S5_L001_R2_001.fastq.gz
FFPE-9G7045 ../data/FFPE-9G7045_S2_L001_R1_001.fastq.gz ../data/FFPE-9G7045_S2_L001_R2_001.fastq.gz
```
2) SAMPELSHEET2
Create another tab delimited samplesheet for preovide mixcr outputs as input to VDJtools as below e.g. metadataToConvert_EXP21001293.txt. Header present. Do not specify complete paths, but place the file in the same folder as the inputs folder. (Strange Bug!) 	
```file_name	sample_id
	DSCO28-MTC-1analysis.clonotypes.TRB.fixed.txt	DSCO28-MTC-1
	DSCO28-MTC-2analysis.clonotypes.TRB.fixed.txt	DSCO28-MTC-2
	DSCO28-MTC-3analysis.clonotypes.TRB.fixed.txt	DSCO28-MTC-3
	DSCO28-TRF-1analysis.clonotypes.TRB.fixed.txt	DSCO28-TRF-1
	DSCO28-TRF-2analysis.clonotypes.TRB.fixed.txt	DSCO28-TRF-2
	DSCO28-TRF-3analysis.clonotypes.TRB.fixed.txt	DSCO28-TRF-3
	FFPE-9G7045analysis.clonotypes.TRB.fixed.txt	FFPE-9G7045
```

## Outputs

1) Make sure a file called metadata.txt gets automatically created by VDJtools, looks like below
```file_name	sample_id	..filter..
VDJtools.HNSCC-15396-1.txt	HNSCC-15396-1	conv:MiXcr
VDJtools.HNSCC-15396-2.txt	HNSCC-15396-2	conv:MiXcr
VDJtools.HNSCC-15396-3.txt	HNSCC-15396-3	conv:MiXcr
VDJtools.HNSCC-6827-1.txt	HNSCC-6827-1	conv:MiXcr
VDJtools.HNSCC-6827-2.txt	HNSCC-6827-2	conv:MiXcr
VDJtools.HNSCC-6827-3.txt	HNSCC-6827-3	conv:MiXcr
```

2) mixcr

1. *.TRB.txt
2. *.clna
3. *.vdjca

3) vdjtools (depending on the type of plots, read more in vdjtools documentation)

1. *.pdf
2. *.summary.txt
3. *.txt
4. metadata.txt

## Setting up your own user conda environment

###Step1 ### Logon to Galaxy server and then issue the below commands:
conda create --name tcrbeta
conda activate tcrbeta

###Step2 ### The above creates and activates a conda environment called "tcrbeta" for you, then you can install R libaries using conda install commands for specific R libraries like ggplot etc inside this "tcrbeta" so that this setup remains specific to tcrseq only and does not ever conflict with anything else you might use your bash for###

###Step3 ### #The version that I've is R 4.0.5
#Install R
conda install -c conda-forge r-base

###Step4 ### #Install R libraries
conda install -c conda-forge r-ggplot2
conda install -c conda-forge r-gplots
conda install -c conda-forge r-rcolorbrewer
conda install -c conda-forge r-VennDiagram
conda install -c conda-forge r-reshape2
conda install -c conda-forge r-ape
conda install -c conda-forge r-plotrix

###Step4 - alternative ### #Install any missing R library in the above way. And, if you cannot find any library with channel conda-forge, try channel "-c bioconda" instead of "-c conda-forge"

For more understadning read:
Overall for more understanding read 
1) [https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/](https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/) 

2) [https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands)
