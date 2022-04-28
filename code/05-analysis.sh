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

#Exit script if any command fails
set -e

#Make scripts executable
chmod +x /vortexfs1/home/yaamini.venkataraman/04-BAT-calling.sh
chmod +x /vortexfs1/home/yaamini.venkataraman/04-BAT-calling-filtering.sh

#Load the singularity module for BAT
module load singularity/3.7

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

echo "Population irrespective of oxygen"

#I will summarize methylation information for each population, irrespective of oxygen conditions. This will provide population-specific methylation information. I will exclude OC samples.

mkdir all_pop

#Run BAT_summarize
#in1: comma-separated bedGraphs from NBH
#in2: comma-separated bedGraphs from SC
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/05-analysis-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-N4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-N1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_20-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_5-N3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-N1_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_5-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_5-S1_CG.sort.bedgraph \
--groups N,S \
--h1 20-N4,5-N1,5-N2,20-N2,5-N3,20-N1 \
--h2 20-S1,20-S3,20-S4,5-S3,5-S4,5-S2,20-S2,5-S1 \
--out ${ALL_POP} \
--cs ${CHROM_LENGTH} \
-bgbw /yaaminiv/miniconda3/bin/bedGraphToBigWig

echo "Oxygen irrespective of population"

echo "Oxygen within population"

echo "Normoxia vs. OC"




echo "Done with summarize"

echo "Overview Module"

echo "Population irrespective of oxygen"

#Remove extra columns from output bedGraph
awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12"\t"$13"\t"$14"\t"$15"\t"$16"\t"$17}' \
${ALL_POP}_summary_N_S.bedgraph \
> ${ALL_POP}_summary_N_S.bedgraph.fix

#Run BAT_overview
#i: input summary bedGraph
#o: output prefix
#groups: comma-separated list of gorup identifiers
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/05-analysis-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
BAT_overview.R  \
-i ${ALL_POP}_summary_N_S.bedgraph.fix \
-o ${ALL_POP} \
--groups N,S

BAT_overview.R  -i data/P10/${dataset}_summary_treatment_control.bedgraph -o data/P10/${dataset}_overview --groups treatment,control


echo "Done with overview"
