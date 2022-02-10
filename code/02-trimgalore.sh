#!/bin/bash

#SBATCH --partition=compute          								 				    			# Queue selection
#SBATCH --job-name=yrv_trimgalore         							 							# Job name
#SBATCH --mail-type=ALL              							   				     			# Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    			# Where to send mail
#SBATCH --ntasks=1                 								  				    		  # Run a single task
#SBATCH --cpus-per-task=8      								       				    			# Number of CPU cores per task
#SBATCH --mem=100gb                  								 						    	# Job memory request
#SBATCH --time=10:00:00            								   							    # Time limit hrs:min:sec
#SBATCH --output=yrv_trimgalore%j.log  								   							# Standard output/error
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/02-trimgalore	# Working directory for this script

#Exit script if any command fails
set -e

#TrimGalore: Remove most abundant sequences and hard trim 10 bp from each end
/vortexfs1/home/yaamini.venkataraman/TrimGalore-0.6.6/trim_galore \
--output_dir /vortexfs1/scratch/yaamini.venkataraman/02-trimgalore \
--paired \
--fastqc_args \
"--outdir /vortexfs1/scratch/yaamini.venkataraman/02-trimgalore \
--threads 28" \
--non_directional \
--rrbs \
--paired \
--path_to_cutadapt /vortexfs1/scratch/yaamini.venkataraman/miniconda3/bin/cutadapt \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_20-N4_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_20-N4_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_20-S1_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_20-S1_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_20-S3_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_20-S3_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_20-S4_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_20-S4_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_5-N1_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_5-N1_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_5-N2_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_5-N2_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_5-S3_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_5-S3_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_5-S4_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_5-S4_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_OC-S1_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L2_OC-S1_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_20-N2_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_20-N2_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_5-N3_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_5-N3_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_5-S2_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_5-S2_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-N1_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-N1_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-N2_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-N2_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-N4_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-N4_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-N5_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-N5_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-S2_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-S2_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-S3_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L3_OC-S3_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_20-N1_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_20-N1_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_20-S2_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_20-S2_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_5-S1_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_5-S1_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_OC-N3_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_OC-N3_2.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_OC-S5_1.fq.gz \
/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/190626_I114_FCH7TVNBBXY_L4_OC-S5_2.fq.gz

echo TrimGalore complete

#MultiQC
/vortexfs1/scratch/yaamini.venkataraman/miniconda3/bin/multiqc \
/vortexfs1/scratch/yaamini.venkataraman/02-trimgalore/.

echo MultiQC complete
