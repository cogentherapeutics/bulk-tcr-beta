#!/bin/bash
#conda init bash
#conda activate tcrseq

metadataToConvert='/home/schavan/projects/bulk_tcr_seq/inputs/metadataToConvert_EXP21001376_FFPE.txt'
metadata='metadata.txt' #automatically created by vdjtools by below code

##Edit block above to point to appropriate paths
#---------------------------------------------------------------------------

while read -r file_name sample_name REST; do

     echo "Working on --> "$counter $sample_name
     #mkdir -p /home/schavan/projects/bulk_tcr_seq/outputs/vdjtools.out/${sample_name}

 ## Basic Stats using metadata file
     vdjtools Convert -S mixcr -m ${metadataToConvert} VDJtools
     ##Step2 after metdata file is created
     vdjtools CalcBasicStats -m ${metadata} ${sample_name}
     vdjtools CalcSegmentUsage -p -m ${metadata} ${sample_name}
     vdjtools CalcSpectratype -m ${metadata} ${sample_name}

 ## Basic plots without using metadata file
     ./vdjtools-patch.sh vdjtools PlotFancySpectratype VDJtools.${sample_name}.txt ${sample_name}
     ./vdjtools-patch.sh vdjtools PlotFancyVJUsage VDJtools.${sample_name}.txt ${sample_name}
     vdjtools PlotSpectratypeV VDJtools.${sample_name}.txt ${sample_name}

 ## Diversity Estimation
     vdjtools PlotQuantileStats VDJtools.${sample_name}.txt ${sample_name}

 done < <(tail -n +2 $metadataToConvert)

## Diversity Estimation - all samples - runs outside the loop
     vdjtools RarefactionPlot -m ${metadata} Rarefaction

 ## Repertoire Overlap - all samples - runs outside the loop
     vdjtools CalcPairwiseDistances -p -m ${metadata} PairDist
     vdjtools ClusterSamples -p Pairwise Cluster
     vdjtools TestClusters Cluster TestClusters
     vdjtools TrackClonotypes -p -m ${metadata} TrackCl
     vdjtools JoinSamples -p -m ${metadata} JoinSmp
