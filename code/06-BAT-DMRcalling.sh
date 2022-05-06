#!/bin/bash

echo "Population irrespective of oxygen"

#Run BAT_DMRcalling
#q: metilene output from BAT_summarize
#o: prefix for output files
#a: group 1
#b: group 2
BAT_DMRcalling \
-q ${SUMMARIZE}/all_pop/all_pop_metilene_N_S.txt  \
-o ${DMR}/all_pop \
-a N \
-b S

#Move files to a new directory

mkdir ${DMR}/all_pop
mv ${DMR}/all_pop_* ${DMR}/all_pop/.

echo "Oxygen by population: OC"

#Run BAT_DMRcalling

BAT_DMRcalling \
-q ${SUMMARIZE}/OC_pop_diff/OC_pop_diff_metilene_N_S.txt  \
-o ${DMR}/OC_pop_diff \
-a N \
-b S

#Move files to a new directory

mkdir ${DMR}/OC_pop_diff
mv ${DMR}/pop_diff_* ${DMR}/OC_pop_diff/.

echo "Oxygen by population: Normoxia"

#Run BAT_DMRcalling

BAT_DMRcalling \
-q ${SUMMARIZE}/20_pop_diff/20_pop_diff_metilene_N_S.txt  \
-o ${DMR}/20_pop_diff \
-a N \
-b S

#Move files to a new directory

mkdir ${DMR}/20_pop_diff
mv ${DMR}/pop_diff_* ${DMR}/20_pop_diff/.

echo "Oxygen by population: Hypoxia"

#Run BAT_DMRcalling

BAT_DMRcalling \
-q ${SUMMARIZE}/5_pop_diff/5_pop_diff_metilene_N_S.txt  \
-o ${DMR}/5_pop_diff \
-a N \
-b S

#Move files to a new directory

mkdir ${DMR}/5_pop_diff
mv ${DMR}/pop_diff_* ${DMR}/5_pop_diff/.

echo "Oxygen within NB: Normoxia vs. Hypoxia"

#Run BAT_DMRcalling

BAT_DMRcalling \
-q ${SUMMARIZE}/20_5_N/20_5_N_metilene_N_S.txt  \
-o ${DMR}/20_5_N \
-a N \
-b S

#Move files to a new directory

mkdir ${DMR}/20_5_N
mv ${DMR}/N_* ${DMR}/20_5_N/.

echo "Oxygen within NB: Normoxia vs. OC"

#Run BAT_DMRcalling

BAT_DMRcalling \
-q ${SUMMARIZE}/20_OC_N/20_OC_N_metilene_N_S.txt  \
-o ${DMR}/20_OC_N \
-a N \
-b S

#Move files to a new directory

mkdir ${DMR}/20_OC_N
mv ${DMR}/N_* ${DMR}/20_OC_N/.

echo "Oxygen within SC: Normoxia vs. Hypoxia"

#Run BAT_DMRcalling

BAT_DMRcalling \
-q ${SUMMARIZE}/20_5_S/20_5_S_metilene_N_S.txt  \
-o ${DMR}/20_5_S \
-a N \
-b S

#Move files to a new directory

mkdir ${DMR}/20_5_S
mv ${DMR}/S_* ${DMR}/20_5_S/.

echo "Oxygen within SC: Normoxia vs. OC"

#Run BAT_DMRcalling

BAT_DMRcalling \
-q ${SUMMARIZE}/20_OC_S/20_OC_S_metilene_N_S.txt  \
-o ${DMR}/20_OC_S \
-a N \
-b S

#Move files to a new directory

mkdir ${DMR}/20_OC_S
mv /scratch/05-analysis/summarize/S_* ${DMR}/20_OC_S/.
