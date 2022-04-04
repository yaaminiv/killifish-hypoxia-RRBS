#!/bin/bash

#SBATCH --partition=compute          								 				    			# Queue selection
#SBATCH --job-name=yrv_mapping          							 							  # Job name
#SBATCH --mail-type=ALL              							   				     			# Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    			# Where to send mail
#SBATCH --nodes=1                                                     # One node
#SBATCH --exclusive                                                   # All 36 procs on the one node
#SBATCH --mem=100gb                                                   # Job memory request
#SBATCH --qos=unlim                                                   # QOS selection
#SBATCH --output=yrv_mapping%j.log  								   					  		# Standard output
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/03-mapping  	# Working directory for this script

#Exit script if any command fails
set -e

#Make scripts executable
chmod +x /vortexfs1/home/yaamini.venkataraman/03-BAT-mapping.sh
chmod +x /vortexfs1/home/yaamini.venkataraman/03-BAT-mapping-stat.sh

#Load the singularity module for BAT
module load singularity/3.7

echo "Mapping Module"

#Run BAT_mapping script
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/03-alignment-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/03-BAT-mapping.sh

echo "Done with mapping"

echo "Statistics Module"

#Run BAT_mapping_stat script
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/03-alignment-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/03-BAT-mapping-stat.sh

echo "Done with statistics"

echo "Merging Module"

#New Bedford Harbor, hypoxia
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/03-alignment-envfile.txt --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/05-N.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-N1.bam,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-N2.bam,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-N3.bam

#Scorton Creek, hypoxia
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/03-alignment-envfile.txt --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/05-S.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_5-S1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_5-S2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-S3_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_5-S4_1.fq.gz  

#New Bedford Harbor, normoxia
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/03-alignment-envfile.txt --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/20-N.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_20-N1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_20-N2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_20-N4_1.fq.gz 

#Scorton Creek, normoxia
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/03-alignment-envfile.txt --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/20-S.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_20-S1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_20-S2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_20-S3_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_20-S4_1.fq.gz 

#New Bedford Harbor, outside
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/03-alignment-envfile.txt --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/OC-N.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-N1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-N2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_OC-N3_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-N4_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-N5_1.fq.gz

#Scorton Creek, outside
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/03-alignment-envfile.txt --bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch /vortexfs1/home/naluru/bat_latest.sif \
BAT_merging \
-o ${SINGMERGED}/OC-S.bam \
--bam ${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L2_OC-S1_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L3_OC-S2_1.fq.gz,${SINGMAPPED}/190626_I114_FCH7TVNBBXY_L4_OC-S5_1.fq.gz

echo "Done with merging"
