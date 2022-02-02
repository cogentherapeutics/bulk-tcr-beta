#!/bin/bash
#conda init bash
#conda activate tcrseq
metadataToConvert='/home/schavan/projects/bulk_tcr_seq/inputs/metadataToConvert_EXP21001376_FFPE.txt'
metadata='metadata.txt'

sample_name1="HNSCC-15396-1"
sample_name2="HNSCC-15396-2"
sample_name3="HNSCC-15396-3"
output_prefix="HNSCC-15396"

##Edit block above to point to appropriate paths
#---------------------------------------------------------------------------

## Repertoire Overlap - replicates/pairs e.g. Comparing 3 samples with all permuations

       vdjtools OverlapPair -p -t 15 VDJtools.${sample_name1}.txt VDJtools.${sample_name2}.txt ${output_prefix}
       vdjtools OverlapPair -p -t 15 VDJtools.${sample_name2}.txt VDJtools.${sample_name3}.txt ${output_prefix}
       vdjtools OverlapPair -p -t 15 VDJtools.${sample_name1}.txt VDJtools.${sample_name3}.txt ${output_prefix}

       vdjtools JoinSamples -p VDJtools.${sample_name1}.txt VDJtools.${sample_name2}.txt VDJtools.${sample_name3}.txt ${output_prefix}
    
    
