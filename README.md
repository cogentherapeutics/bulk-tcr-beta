# Analysis workflow for bulk-tcr-beta sequencing data
Bulk TCR-beta chain sequencing workflow - with DNA as starting material

This includes below steps and scripts

1) fastp - QC and pre-processing of fastq files/ multiqc to create a multisample report: `run_fastp_multiqc.sh`
2) mixcr - alignment and assembly of clonotypes from fastq files: `run_mixcr_v1.sh`, `fix_TRBfiles.R`
3) vdjtools - postprocessing/graphical and text file results for interpretation: `run_vdjtools_single_samples.sh`, `run_vdjtools_custom_samples.sh`, `vdjtools-patch.sh`

Currently fastp, multiqc, mixcr and vdjtools are installed on the galaxy server. But do install fastQC for your user.
`conda install -c bioconda fastqc`

INFO for a test run:
```
Test data:
s3://seqcore/fastqs/tcrseq/EXP21001376_FFPE

Input files:
~~schavan/projects/bulk_tcr_seq/inputs_trb/samplesheet_EXP21001376.tsv ## Mixcr + fastq only
~schavan/projects/bulk_tcr_seq/inputs/metadataToConvert_EXP21001376_FFPE.txt. ## VDJTools Only

Output files for Mixcr:
~schavan/projects/bulk_tcr_seq/inputs/

Output files for VDJTools:
~schavan/projects/bulk_tcr_seq/scripts/batch2.2

```

<img width="692" alt="image" src="https://user-images.githubusercontent.com/13784114/152161243-f1e5e77e-8f79-457c-9d98-cd6eabe4b3e9.png">


## Inputs

1) SAMPLSHEET1
create a tab delimited samplesheet per experiment for input to mixcr as below e.g.samplesheet_EXP21001293.tsv. No headers. Specifiy complete and *absolute* paths to the fastq files
```
DSCO28-MTC-1    /data/DSCO28-MTC-1_S7_L001_R1_001.fastq.gz    /data/DSCO28-MTC-1_S7_L001_R2_001.fastq.gz
DSCO28-MTC-2    /data/DSCO28-MTC-2_S1_L001_R1_001.fastq.gz    /data/DSCO28-MTC-2_S1_L001_R2_001.fastq.gz
DSCO28-MTC-3    /data/DSCO28-MTC-3_S3_L001_R1_001.fastq.gz    /data/DSCO28-MTC-3_S3_L001_R2_001.fastq.gz
DSCO28-TRF-1    /data/DSCO28-TRF-1_S6_L001_R1_001.fastq.gz    /data/DSCO28-TRF-1_S6_L001_R2_001.fastq.gz
DSCO28-TRF-2    /data/DSO28-TRF-2_S4_L001_R1_001.fastq.gz    /data/DSCO28-TRF-2_S4_L001_R2_001.fastq.gz
DSCO28-TRF-3    /data/DSCO28-TRF-3_S5_L001_R1_001.fastq.gz    /data/DSCO28-TRF-3_S5_L001_R2_001.fastq.gz
FFPE-9G7045 /data/FFPE-9G7045_S2_L001_R1_001.fastq.gz /data/FFPE-9G7045_S2_L001_R2_001.fastq.gz
```
2) SAMPELSHEET2
Create another tab delimited samplesheet for preovide mixcr outputs as input to VDJtools as below e.g. metadataToConvert_EXP21001293.txt. Header present. 
IMPORTANT: *Do not specify complete paths, but place the file in the same folder as the inputs folder because VDJtools expects the TRB files to be in the same folder as the inputs folder (Weird bug!) So if needed, create symbolic links in the inputs folder pointing to the output files. Names should be exactly same as the "file_name" in the below file.*

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

1) Logon to Galaxy server and then issue the below commands:
```
conda create --name tcrbeta
conda activate tcrbeta
```
The above creates and activates a conda environment called "tcrbeta" for you, then you can install R libaries using conda install commands for specific R libraries like ggplot etc inside this "tcrbeta" so that this setup remains specific to tcrseq only and does not ever conflict with anything else you might use your bash for.

2) Install R/The version that I've is R 4.0.5
```
conda install -c conda-forge r-base
```
3) Install R libraries
```
conda install -c conda-forge r-ggplot2
conda install -c conda-forge r-gplots
conda install -c conda-forge r-rcolorbrewer
conda install -c conda-forge r-VennDiagram
conda install -c conda-forge r-reshape2
conda install -c conda-forge r-ape
conda install -c conda-forge r-plotrix
```

Install any missing R library in the above way. And, if you cannot find any library with channel conda-forge, try channel "-c bioconda" instead of "-c conda-forge"

For more understadning read:
Overall for more understanding read 
1) [https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/](https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/) 

2) [https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands)

## Extra Info
https://[milaboratory.com](http://milaboratory.com) Pirogov Russian National Research Medical University, Moscow, Russia

1. **MiXCR** [https://mixcr.readthedocs.io/en/master/](https://mixcr.readthedocs.io/en/master/) Java
a. Align raw sequencing reads to reference V, D, J, and C genes of TCRs
b. Assemble clonotypes using alignments based on the region of interest (CDR3)
c. Export alignments & clones to human-readable format

2. **VDJtools** (post-analysis) [https://vdjtools-doc.readthedocs.io/en/master/](https://vdjtools-doc.readthedocs.io/en/master/) Java/R
a. Computes a wide set of statistics
b. Perform various forms of cross-sample analysis

VDJtools clonotype specification
1. Count: Number of reads
2. Frequency: the share of clonotype in the sample
3. Complementarity determining region 3 nucleotide sequence (CDR3nt). 
	CDR3 starts with Variable region reference point (conserved Cys residue)
	and ends with Joining segment reference point (conserved PheTrp)
4. Translated CDR3 sequence (CDR3aa)
5. Variable (V) segment name.
6. Diversity (D) segment name for the receptor chains (TRB)
7. Joining (J) segment name.
8. Vend, Dstart, Dend, and Jstart
	marking V, D and J segment boundaries within CDR3 nucleotide sequence 
	(inclusive)

### **Analysis workflow setup**

1. Turn on VPN, Cisco AnyConnect
2. Log on to galaxy server ([10.0.31.135](mailto:schavan@10.0.31.135)), create directories in your home folder -
inputs, data, scripts
3. Check installations and versions
which mixcr
/usr/local/bin/mixcr
which vdjtools
/usr/local/bin/vdjtools
mixcr --version
MiXCR v3.0.13
vdjtools --version
VDJtools V1.2.1
4. Transfer fastq files for a given experiment e.g. EXP21001293 from Illumina → local machine (Install Illumina BaseSpace Downloader on your local machine). Then transfer from local machine → galaxy server (10.0.31.135)
rsync -r -e ssh <local-path-to-fastq> user@10.0.31.135:~/projects/bulk_tcr_seq/data/EXP21001293
