#!/bin/bash

#SBATCH --partition=compute          								 				    			# Queue selection
#SBATCH --job-name=yrv_mapping          							 							  # Job name
#SBATCH --mail-type=ALL              							   				     			# Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    			# Where to send mail
#SBATCH --ntasks=1                 								  				    		  # Run a single task
#SBATCH --cpus-per-task=8      								       				    			# Number of CPU cores per task
#SBATCH --mem=100gb                  								 						    	# Job memory request
#SBATCH --qos=unlim                                                   # QOS selection
#SBATCH --output=yrv_mapping%j.log  								   					  		# Standard output/error
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/03-mapping  	# Working directory for this script

#Exit script if any command fails
set -e

#Set some variable to directories and genome files
GENOME=/naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa.gz
TRIMMED=/scratch/02-trimgalore
INDICES=/naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel
SINGMAPPED=/scratch/03-mapping/mapped #Mapping directory within singularity container
STAT=/vortexfs1/scratch/yaamini.venkataraman/03-mapping/stat #Directory on host system for stat files
SINGMERGED=/scratch/03-mapping/merged #Merged file directory within singularity container

#Get list of files which should be processed
#Reverse the string
#Remove the last 15 characters
#Reverse the string
#Sort and pull unique basenames
FASTQ=`ls /vortexfs1/scratch/yaamini.venkataraman/02-trimgalore/*gz  | rev | cut -c15- | rev | sort | uniq`

#Load the singularity module for BAT
module load singularity/3.7

echo "Mapping Module"

for f in $FASTQ
do
  singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
  BAT_mapping \
  -g $GENOME \
  -q ${TRIMMED}/${f}_1_val_1.fq.gz \
  -p ${TRIMMED}/${f}_2_val_2.fq.gz \
  -i $INDICES \
  -o ${SINGMAPPED}/${f} \
  -t 16 \
  -F 2
done

echo "Statistics Module"

for f in $FASTQ
do
  singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
  BAT_mapping_stat \
  --bam ${SINGMAPPED}/${f}.bam \
  --excluded ${SINGMAPPED}/${f}.excluded.bam \
  --fastq ${TRIMMED}/${f}_1_val_1.fq.gz \
  > ${STAT}/${f}.stat
done

echo "Merging Module"

#New Bedford Harbor, hypoxia
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/05-N.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-N1.bam,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-N2.bam,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-N3.bam

#Scorton Creek, hypoxia
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/05-S.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_5-S1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_5-S2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-S3_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-S4_1.fq.gz  

#New Bedford Harbor, normoxia
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/20-N.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_20-N1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_20-N2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_20-N4_1.fq.gz 

#Scorton Creek, normoxia
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/20-S.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_20-S1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_20-S2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_20-S3_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_20-S4_1.fq.gz 

#New Bedford Harbor, outside
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/OC-N.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-N1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-N2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_OC-N3_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-N4_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-N5_1.fq.gz

#Scorton Creek, outside
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/OC-S.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_OC-S1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-S2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_OC-S5_1.fq.gz

echo "Done with mapping"
