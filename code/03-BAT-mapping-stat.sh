#Populate FASTQ array with prefixes of files to process
FASTQ=(/scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_20-N4 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_20-S1 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_20-S3 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_20-S4 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_5-N1 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_5-N2 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_5-S3 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_5-S4 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_OC-S1 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_20-N2 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_5-N3 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_5-S2 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_OC-N1 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_OC-N2 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_OC-N4 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_OC-N5 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_OC-S2 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_OC-S3 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L4_20-N1 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L4_20-S2 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L4_5-S1 /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L4_OC-S5)

#Run BAT_mapping_stat script
STAT=/vortexfs1/scratch/yaamini.venkataraman/03-mapping/stat #Directory on host system for stat files

#Get alignment statistics
for f in "${FASTQ[@]}"
do
  BAT_mapping_stat \
  --bam ${SINGMAPPED}/${f}.bam \
  --excluded ${SINGMAPPED}/${f}.excluded.bam \
  --fastq ${TRIMMED}/${f}_1_val_1.fq.gz \
  > ${STAT}/${f}.stat
done
