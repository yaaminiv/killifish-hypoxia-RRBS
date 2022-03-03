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

#Load the singularity module for BAT
module load singularity/3.7
singularity run /vortexfs1/home/naluru/bat_latest.sif

#Alignment (non-directional)

#Test sample 1
BAT_mapping \
-g /vortexfs1/home/naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa.gz \
-q /vortexfs1/scratch/yaamini.venkataraman/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_20-N4_1_val_1.fq.gz \
-p /vortexfs1/scratch/yaamini.venkataraman/02-trimgalore/190626_I114_FCH7TVNBBXY_L2_20-N4_2_val_2.fq.gz \
-i /vortexfs1/home/naluru/Killifish/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel \
-o /vortexfs1/scratch/yaamini.venkataraman/03-mapping/190626_I114_FCH7TVNBBXY_L2_20-N4_nondirectional \
-t 4 \
-F 2
