#!/bin/bash

echo "Population irrespective of oxygen"

#Run BAT_overview
#-i: Input bedGraph from BAT_summarize
#-o: Output prefix
#--groups: comma-separated list of group identifiers

BAT_overview.R  \
-i ${SUMMARIZE}/all_pop/all_pop_summary_N_S.bedgraph \
-o ${OVERVIEW}/all_pop \
--groups N,S

echo "Oxygen by population: OC"

#Run BAT_overview
#-i: Input bedGraph from BAT_summarize
#-o: Output prefix
#--groups: comma-separated list of group identifiers

BAT_overview.R  \
-i ${SUMMARIZE}/OC_pop_diff/pop_diff_summary_N_S.bedgraph \
-o ${OVERVIEW}/OC_pop_diff \
--groups N,S

echo "Oxygen by population: Normoxia"

#Run BAT_overview
#-i: Input bedGraph from BAT_summarize
#-o: Output prefix
#--groups: comma-separated list of group identifiers

BAT_overview.R  \
-i ${SUMMARIZE}/20_pop_diff/pop_diff_summary_N_S.bedgraph \
-o ${OVERVIEW}/20_pop_diff \
--groups N,S

echo "Oxygen by population: Hypoxia"

#Run BAT_overview
#-i: Input bedGraph from BAT_summarize
#-o: Output prefix
#--groups: comma-separated list of group identifiers

BAT_overview.R  \
-i ${SUMMARIZE}/5_pop_diff/pop_diff_summary_N_S.bedgraph \
-o ${OVERVIEW}/5_pop_diff \
--groups N,S

echo "Oxygen within NB: Normoxia vs. Hypoxia"

#Run BAT_overview
#-i: Input bedGraph from BAT_summarize
#-o: Output prefix
#--groups: comma-separated list of group identifiers

BAT_overview.R  \
-i ${SUMMARIZE}/20_5_N/N_summary_20_5.bedgraph \
-o ${OVERVIEW}/20_5_N \
--groups NO,HY

echo "Oxygen within NB: Normoxia vs. OC"

#Run BAT_overview
#-i: Input bedGraph from BAT_summarize
#-o: Output prefix
#--groups: comma-separated list of group identifiers

BAT_overview.R  \
-i ${SUMMARIZE}/20_OC_N/N_summary_20_OC.bedgraph \
-o ${OVERVIEW}/20_OC_N \
--groups NO,OC

echo "Oxygen within SC: Normoxia vs. Hypoxia"

#Run BAT_overview
#-i: Input bedGraph from BAT_summarize
#-o: Output prefix
#--groups: comma-separated list of group identifiers

BAT_overview.R  \
-i ${SUMMARIZE}/20_5_S/S_summary_20_5.bedgraph \
-o ${OVERVIEW}/20_5_S \
--groups NO,HY

echo "Oxygen within SC: Normoxia vs. OC"

#Run BAT_overview
#-i: Input bedGraph from BAT_summarize
#-o: Output prefix
#--groups: comma-separated list of group identifiers

BAT_overview.R  \
-i ${SUMMARIZE}/20_OC_S/S_summary_20_OC.bedgraph \
-o ${OVERVIEW}/20_OC_S \
--groups NO,OC
