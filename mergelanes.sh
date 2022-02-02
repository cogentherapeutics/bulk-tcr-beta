#Helper script to merge lanes when delimiter is the first '_', change accordingly for your files

ls *R1* | cut -d _ -f 1 | sort | uniq \
    | while read id; do \
        cat $id*R1*.fastq.gz > $id.R1.fastq.gz;
        cat $id*R2*.fastq.gz > $id.R2.fastq.gz;
done
