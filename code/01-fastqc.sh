#!/bin/bash

#SBATCH --partition=compute          								 # Queue selection
#SBATCH --job-name=yrv_fastqc         							 # Job name
#SBATCH --mail-type=ALL              							   # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    # Where to send mail
#SBATCH --ntasks=1                 								   # Run a single task
#SBATCH --cpus-per-task=8      								       # Number of CPU cores per task
#SBATCH --mem=100gb                  								 # Job memory request
#SBATCH --time=03:00:00            								   # Time limit hrs:min:sec
#SBATCH --output=yrv_fastqc%j.log  								   # Standard output/error

# Script adapted from one used by Sam White: https://robertslab.github.io/sams-notebook/2020/11/10/FastQC-MultiQC-C.gigas-Ploidy-WGBS-Raw-Sequence-Data-from-Ronits-Project-on-Mox.html

###################################################################################

# These variables need to be set by user

# FastQC output directory
output_dir=/vortexfs1/home/naluru/Killifish/output/01-fastqc/

# Input/output files
checksums=fastq_checksums.md5
fastq_list=fastq_list.txt
raw_reads_dir=/vortexfs1/home/naluru/Killifish/WHOI-Mummichog_RRBS/

# Programs associative array
declare -A programs_array
programs_array=(
[fastqc]="${fastqc}" \
[multiqc]="${multiqc}"
)

###################################################################################

# Exit script if any command fails
set -e

# Load Python module on Poseidon for Python module availability
module load python3/intel

# Sync raw FastQ files to working directory
rsync --archive --verbose \
"${raw_reads_dir}"zr3616*.fq.gz .

# Populate array with FastQ files
fastq_array=(*.fq.gz)

# Pass array contents to new variable
fastqc_list=$(echo "${fastq_array[*]}")

# Run FastQC
# NOTE: Do NOT quote ${fastqc_list}
${programs_array[fastqc]} \
--threads ${threads} \
--outdir ${output_dir} \
${fastqc_list}

# Create list of fastq files used in analysis
echo "${fastqc_list}" | tr " " "\n" >> ${fastq_list}

# Generate checksums for reference
while read -r line
do

	# Generate MD5 checksums for each input FastQ file
	echo "Generating MD5 checksum for ${line}."
	md5sum "${line}" >> "${checksums}"
	echo "Completed: MD5 checksum for ${line}."
	echo ""

	# Remove fastq files from working directory
	echo "Removing ${line} from directory"
	rm "${line}"
	echo "Removed ${line} from directory"
	echo ""
done < ${fastq_list}

# Run MultiQC
${programs_array[multiqc]} .


# Capture program options
for program in "${!programs_array[@]}"
do
	{
  echo "Program options for ${program}: "
	echo ""
  # Handle samtools help menus
  if [[ "${program}" == "samtools_index" ]] \
  || [[ "${program}" == "samtools_sort" ]] \
  || [[ "${program}" == "samtools_view" ]]
  then
    ${programs_array[$program]}
  fi
	${programs_array[$program]} -h
	echo ""
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo ""
} &>> program_options.log || true

  # If MultiQC is in programs_array, copy the config file to this directory.
  if [[ "${program}" == "multiqc" ]]; then
  	cp --preserve ~/.multiqc_config.yaml .
  fi
done


# Document programs in PATH (primarily for program version ID)
{
date
echo ""
echo "System PATH for $SLURM_JOB_ID"
echo ""
printf "%0.s-" {1..10}
echo "${PATH}" | tr : \\n
} >> system_path.log
