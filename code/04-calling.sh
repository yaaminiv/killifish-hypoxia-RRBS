#!/bin/bash

#SBATCH --partition=compute          								 				    		           	# Queue selection
#SBATCH --job-name=yrv_calling          							 							            # Job name
#SBATCH --mail-type=ALL              							   				     		           	# Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    		           	# Where to send mail
#SBATCH --nodes=1                                                               # One node
#SBATCH --exclusive                                                             # All 36 procs on the one node
#SBATCH --mem=100gb                                                             # Job memory request
#SBATCH --output=yrv_calling%j.log  								   					  	           	# Standard output
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/04-calling/new-genome  	# Working directory for this script

#Exit script if any command fails
set -e

#Make scripts executable
chmod +x /vortexfs1/home/yaamini.venkataraman/04-BAT-calling.sh
chmod +x /vortexfs1/home/yaamini.venkataraman/04-BAT-calling-filtering.sh

#Load the singularity module for BAT
module load singularity/3.7

echo "Calling Module"

#Run BAT_mapping script
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/04-calling-envfile.txt \
--bind /vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/04-BAT-calling.sh

echo "Done with calling"

echo "Filtering Module"

#Run BAT_mapping_stat script
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/04-calling-envfile.txt \
--bind /vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/04-BAT-calling-filtering.sh

echo "Done with filtering"
