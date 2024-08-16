#!/bin/bash

echo "Oxygen within NB: Outside Control vs. Normoxia"

#Create BAT_correlating input

mkdir ${CORR}/20_OC_N

echo "Create BEDfile with DMR and gene coordinates"

cat ${ANNOT}/20_OC_N_DMR.closestGene.bed \
| cut -f1-3,14 \
| tr ";" "\t" \
| cut -f1-4 \
| sed 's/ID=gene-//g' \
> ${CORR}/20_OC_N/20_OC_N_DMR_gene.bed

echo "Create methylation bigWig file list"

ls ${BIGWIG}/20_OC_N/*bw \
| grep -v "mean" \
| grep -v "diff" \
| sed 's/\t/\n/' \
> ${CORR}/20_OC_N/20_OC_N_methylation_files.list

echo "Create gene expression file list"

ls ${RNA}/*threeCol.txt \
| grep -e "20-N" -e "OC-N" \
| sed 's/\t/\n/' \
> ${CORR}/20_OC_N/20_OC_N_expression_files.list

echo "Create sample identifier list"

echo -e '20-N1\tNO\n20-N2\tNO\n20-N4\tNO\nOC-N1\tOC\nOC-N2\tOC\nOC-N3\tOC\nOC-N4\tOC\nOC-N5\tOC' > ${CORR}/20_OC_N/20_OC_N_sample_to_group.txt

#Create output directory
mkdir ${CORR}/20_OC_N/correlation_output

#Run BAT_DMRcalling
#-b: BED file with coordinates of methylation region and name of identifier: chr <tab> start <tab> end <tab> identifier
#-e: List of expression files, one per sample. Each sample's file: identifier <tab> something <tab> expression_value
#-m: File containing a list of methylation bigWig files (one per sample).
#-g: File containing the association of sample identifiers to groups. The list of samples in the file must be ordered analogously as in the list of files given with options -e and -m.: sample <tab> group
#-i: Comma-separated list of group1 and group2
#-o Path/prefix for output

BAT_correlating \
-b ${CORR}/20_OC_N/20_OC_N_DMR_gene.bed \
-e ${CORR}/20_OC_N/20_OC_N_expression_files.list \
-m ${CORR}/20_OC_N/20_OC_N_methylation_files.list \
-g ${CORR}/20_OC_N/20_OC_N_sample_to_group.txt \
-i NO,OC \
-o ${CORR}/20_OC_N/correlation_output/

echo "Oxygen within NB: Outside Control vs. Hypoxia"

#Create BAT_correlating input

mkdir ${CORR}/5_OC_N

echo "Create BEDfile with DMR and gene coordinates"

cat ${ANNOT}/5_OC_N_DMR.closestGene.bed \
| cut -f1-3,14 \
| tr ";" "\t" \
| cut -f1-4 \
| sed 's/ID=gene-//g' \
> ${CORR}/5_OC_N/5_OC_N_DMR_gene.bed

echo "Create methylation bigWig file list"

ls ${BIGWIG}/5_OC_N/*bw \
| grep -v "mean" \
| grep -v "diff" \
| sed 's/\t/\n/' \
> ${CORR}/5_OC_N/5_OC_N_methylation_files.list

echo "Create gene expression file list"

ls ${RNA}/*threeCol.txt \
| grep -e "5-N" -e "OC-N" \
| sed 's/\t/\n/' \
> ${CORR}/5_OC_N/5_OC_N_expression_files.list

echo "Create sample identifier list"

echo -e '5-N1\tHY\n5-N2\tHY\n5-N3\tHY\n5-N4\tHY\nOC-N1\tOC\nOC-N2\tOC\nOC-N3\tOC\nOC-N4\tOC\nOC-N5\tOC' > ${CORR}/5_OC_N/5_OC_N_sample_to_group.txt

#Create output directory
mkdir ${CORR}/5_OC_N/correlation_output

#Run BAT_DMRcalling
#-b: BED file with coordinates of methylation region and name of identifier: chr <tab> start <tab> end <tab> identifier
#-e: List of expression files, one per sample. Each sample's file: identifier <tab> something <tab> expression_value
#-m: File containing a list of methylation bigWig files (one per sample).
#-g: File containing the association of sample identifiers to groups. The list of samples in the file must be ordered analogously as in the list of files given with options -e and -m.: sample <tab> group
#-i: Comma-separated list of group1 and group2
#-o Path/prefix for output

BAT_correlating \
-b ${CORR}/5_OC_N/5_OC_N_DMR_gene.bed \
-e ${CORR}/5_OC_N/5_OC_N_expression_files.list \
-m ${CORR}/5_OC_N/5_OC_N_methylation_files.list \
-g ${CORR}/5_OC_N/5_OC_N_sample_to_group.txt \
-i HY,OC \
-o ${CORR}/5_OC_N/correlation_output/

echo "Done with BAT_correlating"
