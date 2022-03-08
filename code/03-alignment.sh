#!/bin/bash

#SBATCH --partition=compute          								 				    			# Queue selection
#SBATCH --job-name=yrv_mapping          							 							  # Job name
#SBATCH --mail-type=ALL              							   				     			# Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    			# Where to send mail
#SBATCH --ntasks=1                 								  				    		  # Run a single task
#SBATCH --cpus-per-task=8      								       				    			# Number of CPU cores per task
#SBATCH --mem=100gb                  								 						    	# Job memory request
#SBATCH --time=10:00:00            								   							    # Time limit hrs:min:sec
#SBATCH --output=yrv_mapping%j.log  								   					  		# Standard output/error
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/03-mapping  	# Working directory for this script

#Exit script if any command fails
set -e

#Set some variable to directories and genome files
GENOME=/naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa.gz
INDICES=/naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel
MAPPED=/scratch/03-mapping/mapped/

#Get list of files which should be processed
#This assumes you call the script from the directory where the gzipped
#fastq-files (*.fastq.gz) are located
FASTQ=`ls /vortexfs1/scratch/yaamini.venkataraman/02-trimgalore/*gz  | rev | cut -c15- | rev | sort | uniq`

#Create directories
mkdir $MAPPED

#Load the singularity module for BAT
module load singularity/3.7

echo "Mapping Module"

for f in $FASTQ
do
  singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
  BAT_mapping \
  -g $GENOME \
  -q ${f}_1_val_1.fq.gz \
  -p ${f}_2_val_2.fq.gz \
  -i $INDICES  \
  -o ${MAPPED}/${f} \
  -t 16 \
  -F 2 #FIX THIS
done

echo "Statistics Module"

for f in $FASTQ
do
  singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
  BAT_mapping_stat \
  --bam ${MAPPED}/${F}.bam \
  --excluded ${MAPPED}/${F}.excluded.bam \
  --fastq ${f}_1_val_1.fq.gz \
  > ${MAPPED}/${F}.stat;
done

---

#RUNNING TO TEST THINGS

#Load the singularity module and bind directories so you can access them
module load singularity/3.7

#Alignment (non-directional)

#Test sample 1
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_mapping \
-g /naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa.gz \
-q /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_20-N4_1_val_1.fq.gz \
-p /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_20-N4_2_val_2.fq.gz \
-i /naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel \
-o /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_nondirectional \
-t 16 \
-F 2

#Test sample 2
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_mapping \
-g /naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa.gz \
-q /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_OC-S3_1_val_1.fq.gz \
-p /scratch/02-trimgalore/190626_I114_FCH7TVNBBXY_L3_OC-S3_2_val_2.fq.gz \
-i /naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel \
-o /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L3_OC-S3_nondirectional \
-t 4 \
-F 2

#Alignment (directional)

#Test sample 1
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_mapping \
-g /naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa.gz \
-q /scratch/02-directional/190626_I114_FCH7TVNBBXY_L2_20-N4_1_val_1.fq.gz \
-p /scratch/02-directional/190626_I114_FCH7TVNBBXY_L2_20-N4_2_val_2.fq.gz \
-i /naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel \
-o /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_1_directional \
-t 4 \
-F 1

#Test sample 2
singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_mapping \
-g /naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa.gz \
-q /scratch/02-directional/190626_I114_FCH7TVNBBXY_L3_OC-S3_1_val_1.fq.gz \
-p /scratch/02-directional/190626_I114_FCH7TVNBBXY_L3_OC-S3_2_val_2.fq.gz \
-i /naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel \
-o /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L3_OC-S3_1_directional \
-t 4 \
-F 1
