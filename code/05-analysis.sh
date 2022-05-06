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

#Load the singularity module for BAT
module load singularity/3.7

#Make scripts executable
chmod +x /vortexfs1/home/yaamini.venkataraman/05-BAT-summarize.sh

## THIS WAS DONE INTERACTIVELY IN THE FOLDER WHERE THE GENOME WAS ##
#Unzip genome
#Extract chromosome name and length information
#Remove extra characters from chromosome name/description
#Print two columns
#Remove empty line at the header
#Create file with chromosome lengths
#gzip -d Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa.gz
#awk '$0 ~ ">" {print c; c=0;printf substr($0,2,14) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' \
#Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna.toplevel.fa \
#| sed 's/dna//g' \
#| awk '{print $1"\t"$2}' \
#| tail -n +2 \
#> mummichog.chrom.length

## THIS WAS DONE INTERACTIVELY IN THE FOLDER WHERE THE BEDFILES WERE ##
#Sort bedGraphs
#for f in *bedgraph
#do
#/vortexfs1/home/yaamini.venkataraman/bedtools2/bin/sortBed \
#-i ${f} \
#> $(basename ${f%.bedgraph}).sort.bedgraph
#done

echo "Summarize Module"

#I will summarize methylation information for each population, irrespective of oxygen conditions. This will provide population-specific methylation information.

#Run BAT_summarize
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/05-analysis-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/05-BAT-summarize.sh

echo "Done with summarize"

## TO DO: FIGURE OUT WHY OVERVIEW IS NOT WORKING

#echo "Overview Module"

# echo "Population irrespective of oxygen"

#Remove extra columns from output bedGraph
#awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12"\t"$13"\t"$14"\t"$15"\t"$16"\t"$17}' \
#/scratch/05-analysis/summarize/all_pop_summary_N_S.bedgraph \
#> /scratch/05-analysis/summarize/all_pop_summary_N_S.bedgraph.fix

#Run BAT_overview
#i: input summary bedGraph
#o: output prefix
#groups: comma-separated list of gorup identifiers
#singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/05-analysis-envfile.txt \
#--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
#/vortexfs1/home/naluru/bat_latest.sif \
#BAT_overview.R  \
#-i /scratch/05-analysis/summarize/all_pop_summary_N_S.bedgraph.fix \
#-o /scratch/05-analysis/summarize/all_pop \
#--groups N,S

#echo "Done with overview"
