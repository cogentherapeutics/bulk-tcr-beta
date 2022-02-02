DIR_OF_TRB_FILES="~/projects/bulk_tcr_seq/scripts/"

##Edit block above to point to appropriate paths
#---------------------------------------------------------------------------

##### Load libraries

library(data.table)
library(dplyr)
library(stringr)

##### Load data

 trb.files = list.files(path=DIR_OF_TRB_FILES, pattern="TRB\\.txt$", recursive = TRUE, full.names=TRUE)
 N=length(trb.files);N

##### Process data

for(i in 1:N)
 {
   trb_curr = fread(trb.files[i]); head(trb_curr); dim(trb_curr)
   trb_curr_fixed = paste0(gsub("txt","",(trb.files[i])),"fixed.txt"); trb_curr_fixed
   write.table(trb_curr,file=trb_curr_fixed,sep="\t",quote=F,row.names = F,append=F)
   print(paste("File ready -->",i,"-->",trb_curr_fixed))
   trb_curr = NA
 }
