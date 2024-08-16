#!/bin/bash

#SBATCH --partition=compute          								 				    			# Queue selection
#SBATCH --job-name=yrv_DMR                 							 							# Job name
#SBATCH --mail-type=ALL              							   				     			# Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    			# Where to send mail
#SBATCH --nodes=1                                                     # One node
#SBATCH --exclusive                                                   # All 36 procs on the one node
#SBATCH --mem=100gb                                                   # Job memory request
#SBATCH --output=yrv_DMR%j.log  								   			      		  	# Standard output
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/06-DMR        # Working directory for this script

#Load the singularity module for BAT
module load singularity/3.7

#Make scripts executable
chmod +x /vortexfs1/home/yaamini.venkataraman/06-BAT-DMRcalling.sh

echo "DMR Calling Module"

#Run BAT_DMRcalling
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/06-DMR-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/06-BAT-DMRcalling.sh

echo "Done with DMR calling"
