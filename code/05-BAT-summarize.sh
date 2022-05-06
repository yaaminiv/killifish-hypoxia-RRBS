#!/bin/bash

echo "Population irrespective of oxygen"

#in1: comma-separated bedGraphs from NBH
#in2: comma-separated bedGraphs from SC
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files

BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-N4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-N1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_20-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_5-N3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-N1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N5_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N4_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_5-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_5-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_OC-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_OC-S5_CG.sort.bedgraph \
--groups N,S \
--h1 20-N4,5-N1,5-N2,20-N2,5-N3,20-N1,OC-N5,OC-N1,OC-N2,OC-N4 \
--h2 20-S1,20-S3,20-S4,5-S3,5-S4,5-S2,20-S2,5-S1,OC-S1,OC-S2,OC-S3,OC-S5 \
--out ${SUMMARIZE}/all_pop \
--cs ${CHROMLENGTH}

#Move files to a new directory

mkdir ${SUMMARIZE}/all_pop
mv ${SUMMARIZE}/all_pop_* ${SUMMARIZE}/all_pop/.

echo "Oxygen by population: OC"

#Run BAT_summarize
#in1: comma-separated bedGraphs from NBH
#in2: comma-separated bedGraphs from SC
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files

BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N5_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N4_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_OC-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_OC-S5_CG.sort.bedgraph \
--groups N,S \
--h1 OC-N5,OC-N1,OC-N2,OC-N4 \
--h2 OC-S1,OC-S2,OC-S3,OC-S5 \
--out ${SUMMARIZE}/pop_diff \
--cs ${CHROMLENGTH}

#Move files to a new directory

mkdir ${SUMMARIZE}/pop_diff_OC
mv ${SUMMARIZE}/pop_diff_* ${SUMMARIZE}/pop_diff_OC/.

echo "Oxygen by population: Normoxia"

#Run BAT_summarize
#in1: comma-separated bedGraphs from NBH
#in2: comma-separated bedGraphs from SC
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files

BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-N4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_20-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-N1_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-S2_CG.sort.bedgraph \
--groups N,S \
--h1 20-N4,20-N2,20-N1 \
--h2 20-S1,20-S3,20-S4,20-S2 \
--out ${SUMMARIZE}/pop_diff \
--cs ${CHROMLENGTH}

#Move files to a new directory

mkdir ${SUMMARIZE}/pop_diff_20
mv ${SUMMARIZE}/pop_diff_* ${SUMMARIZE}/pop_diff_20/.

echo "Oxygen by population: Hypoxia"

#Run BAT_summarize
#in1: comma-separated bedGraphs from NBH
#in2: comma-separated bedGraphs from SC
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files

BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-N1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_5-N3_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_5-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_5-S1_CG.sort.bedgraph \
--groups N,S \
--h1 5-N1,5-N2,5-N3 \
--h2 5-S3,5-S4,5-S2,5-S1 \
--out ${SUMMARIZE}/pop_diff \
--cs ${CHROMLENGTH}

#Move files to a new directory

mkdir ${SUMMARIZE}/pop_diff_5
mv ${SUMMARIZE}/pop_diff_* ${SUMMARIZE}/pop_diff_5/.

echo "Oxygen within NB: Normoxia vs. Hypoxia"

#Run BAT_summarize
#in1: comma-separated bedGraphs from NBH normoxia
#in2: comma-separated bedGraphs from NBH hypoxia
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files

BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-N4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_20-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-N1_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-N1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_5-N3_CG.sort.bedgraph \
--groups 20,5 \
--h1 20-N4,20-N2,20-N1 \
--h2 5-N1,5-N2,5-N3 \
--out ${SUMMARIZE}/N \
--cs ${CHROMLENGTH}

#Move files to a new directory

mkdir ${SUMMARIZE}/N_20_5
mv ${SUMMARIZE}/N_* ${SUMMARIZE}/N_20_5/.

echo "Oxygen within NB: Normoxia vs. OC"

#Run BAT_summarize
#in1: comma-separated bedGraphs from NBH normoxia
#in2: comma-separated bedGraphs from NBH OC
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files

BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-N4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_20-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-N1_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N5_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-N4_CG.sort.bedgraph \
--groups 20,OC \
--h1 20-N4,20-N2,20-N1 \
--h2 OC-N5,OC-N1,OC-N2,OC-N4 \
--out ${SUMMARIZE}/N \
--cs ${CHROMLENGTH}

#Move files to a new directory

mkdir ${SUMMARIZE}/N_20_OC
mv ${SUMMARIZE}/N_* ${SUMMARIZE}/N_20_OC/.

echo "Oxygen within SC: Normoxia vs. Hypoxia"

#Run BAT_summarize
#in1: comma-separated bedGraphs from SC normoxia
#in2: comma-separated bedGraphs from SC hypoxia
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files

BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-S2_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_5-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_5-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_5-S1_CG.sort.bedgraph \
--groups 20,5 \
--h1 20-S1,20-S3,20-S4,20-S2 \
--h2 5-S3,5-S4,5-S2,5-S1 \
--out ${SUMMARIZE}/S \
--cs ${CHROMLENGTH}

#Move files to a new directory

mkdir ${SUMMARIZE}/S_20_5
mv ${SUMMARIZE}/S_* ${SUMMARIZE}/S_20_5/.

echo "Oxygen within SC: Normoxia vs. OC"

#Run BAT_summarize
#in1: comma-separated bedGraphs from SC normoxia
#in2: comma-separated bedGraphs from SC OC
#groups: comma-separated list of gorup identifiers
#h1: comma-separated list of sample identifiers for group 1
#h2: comma-seaprated list of sample identifiers for group 2
#out: prefix for output files

BAT_summarize \
--in1 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L2_20-S4_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_20-S2_CG.sort.bedgraph \
--in2 ${FILTERED}/190626_I114_FCH7TVNBBXY_L2_OC-S1_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-S2_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L3_OC-S3_CG.sort.bedgraph,${FILTERED}/190626_I114_FCH7TVNBBXY_L4_OC-S5_CG.sort.bedgraph \
--groups 20,OC \
--h1 20-S1,20-S3,20-S4,20-S2 \
--h2 OC-S1,OC-S2,OC-S3,OC-S5 \
--out ${SUMMARIZE}/S \
--cs ${CHROMLENGTH}

#Move files to a new directory

mkdir ${SUMMARIZE}/S_20_OC
mv ${SUMMARIZE}/S_* ${SUMMARIZE}/S_20_OC/.
