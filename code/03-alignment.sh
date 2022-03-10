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
TRIMMED=/scratch/02-trimgalore
INDICES=/naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel
SINGMAPPED=/scratch/03-mapping #Mapping directory within singularity container
STAT=/vortexfs1/scratch/yaamini.venkataraman/03-mapping/stat #Directory on host system for stat files
MERGED= #FIX THIS

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
  -q ${TRIMMED}/{f}_1_val_1.fq.gz \
  -p ${TRIMMED}/{f}_2_val_2.fq.gz \
  -i $INDICES  \
  -o ${SINGMAPPED}/${f} \
  -t 16 \
  -F 2
done

echo "Statistics Module"

#Create directories
mkdir $STAT

for f in $FASTQ
do
  singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
  BAT_mapping_stat \
  --bam ${SINGMAPPED}/${F}.bam \
  --excluded ${SINGMAPPED}/${F}.excluded.bam \
  --fastq ${TRIMMED}/{f}_1_val_1.fq.gz \
  > ${STAT}/${F}.stat
done

echo "Merging Module"

#Create directories
mkdir $MERGED

---

#RUNNING TO TEST THINGS

#Load the singularity module and bind directories so you can access them
module load singularity/3.7

# Mapping Statistics

# Test sample 1 (non-directional)

singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_mapping_stat \
--bam /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_nondirectional.bam \
--excluded /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_nondirectional.excluded.bam \
--fastq /scratch/02-directional/190626_I114_FCH7TVNBBXY_L2_20-N4_1_val_1.fq.gz \
> /vortexfs1/scratch/yaamini.venkataraman/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_nondirectional.stat

# Test sample 2 (non-directional)

singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_mapping_stat \
--bam /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L3_OC-S3_nondirectional.bam \
--excluded /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L3_OC-S3_nondirectional.excluded.bam \
--fastq /scratch/02-directional/190626_I114_FCH7TVNBBXY_L3_OC-S3_1_val_1.fq.gz \
> /vortexfs1/scratch/yaamini.venkataraman/03-mapping/190626_I114_FCH7TVNBBXY_L3_OC-S3_nondirectional.stat

# Test sample 1 (directional)

singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_mapping_stat \
--bam /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_directional.bam \
--excluded /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_directional.excluded.bam \
--fastq /scratch/02-directional/190626_I114_FCH7TVNBBXY_L2_20-N4_1_val_1.fq.gz \
> /vortexfs1/scratch/yaamini.venkataraman/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_directional.stat

# Test sample 2 (directional)

singularity exec --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_mapping_stat \
--bam /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L3_OC-S3_directional.bam \
--excluded /scratch/03-mapping/190626_I114_FCH7TVNBBXY_L3_OC-S3_directional.excluded.bam \
--fastq /scratch/02-directional/190626_I114_FCH7TVNBBXY_L3_OC-S3_1_val_1.fq.gz \
> /vortexfs1/scratch/yaamini.venkataraman/03-mapping/190626_I114_FCH7TVNBBXY_L3_OC-S3_directional.stat
