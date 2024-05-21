#!/bin/bash

#SBATCH --partition=compute          								 				    			# Queue selection
#SBATCH --job-name=yrv_analysis         							 							  # Job name
#SBATCH --mail-type=ALL              							   				     			# Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    			# Where to send mail
#SBATCH --nodes=1                                                     # One node
#SBATCH --exclusive                                                   # All 36 procs on the one node
#SBATCH --mem=100gb                                                   # Job memory request
#SBATCH --output=yrv_analysis%j.log  								   					  		# Standard output
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/05-analysis  	# Working directory for this script

echo "Prepare for analysis"

echo "Create chromosome length file"

#Navigate to genome directory
#cd /vortexfs1/home/yaamini.venkataraman/killifish-hypoxia-RRBS/data

#Unzip genome
#Extract chromosome name and length information
#Remove extra characters from chromosome name/description
#Print two columns
#Remove empty line at the header
#Create file with chromosome lengths
#gzip -d GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna.gz
#awk '$0 ~ ">" {print c; c=0;printf substr($0,2,14) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' \
#GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna \
#| sed 's/Fu//g' \
#| awk '{print $1"\t"$2}' \
#| tail -n +2 \
#> mummichog.chrom.length
#head mummichog.chrom.length

echo "Done creating chromosome file"

echo "Revise bedGraphs"

#The bedGraphs are filtered, but they have extraneous columns (from genome annotation) and need to be sorted for downstream applications

#Navigate to bedGraph directory
#cd /vortexfs1/home/yaamini.venkataraman/killifish-hypoxia-RRBS/output/04-calling/new-genome/filtered

#Sort bedGraphs
#for f in *bedgraph
#do
#/vortexfs1/home/yaamini.venkataraman/bedtools2/bin/sortBed \
#-i ${f} | \
#awk 'NF{print $1,$(NF-2),$(NF-1),$NF}'  OFS="\t" \
#> $(basename ${f%.bedgraph}).sort.bedgraph
#done
#head *sort.bedgraph

echo "Done revising bedGraphs"

echo "Done preparing for analysis"

echo "Summarize Module"

#Load the singularity module for BAT
module load singularity/3.7

#Make scripts executable
chmod +x /vortexfs1/home/yaamini.venkataraman/05-BAT-summarize.sh
chmod +x /vortexfs1/home/yaamini.venkataraman/05-BAT-overview.sh

#I will summarize methylation information for each population, irrespective of oxygen conditions. This will provide population-specific methylation information.

#Run BAT_summarize
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/05-analysis-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/05-BAT-summarize.sh

echo "Done with summarize"

echo "Overview Module"

#Run BAT_overview
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/05-analysis-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/05-BAT-overview.sh

echo "Done with overview"
