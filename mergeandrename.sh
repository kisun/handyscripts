#!/bin/bash

# Directory where files are located (adjust if needed)
dir="."

# Get unique prefixes (everything before _L001 or _L002)
prefixes=$(ls "$dir"/*_L00[1-2]_R1_001.fastq.gz | sed 's/_L00[1-2]_R1_001.fastq.gz$//' | sort -u)

# Loop through each unique prefix
for prefix in $prefixes; do
    # Extract the first two sections (e.g., FR10_MCRP)
    new_name=$(basename "$prefix" | cut -d'_' -f1-2).fastq.gz
    l001_file="${prefix}_L001_R1_001.fastq.gz"
    l002_file="${prefix}_L002_R1_001.fastq.gz"
    
    # Check if both files exist
    if [ -f "$l001_file" ] && [ -f "$l002_file" ]; then
        echo "Merging $l001_file and $l002_file into $new_name"
        # Merge the two files and remove originals
        cat "$l001_file" "$l002_file" > "$new_name" && rm "$l001_file" "$l002_file"
    elif [ -f "$l001_file" ]; then
        echo "Only $l001_file exists, renaming to $new_name"
        mv "$l001_file" "$new_name"
    elif [ -f "$l002_file" ]; then
        echo "Only $l002_file exists, renaming to $new_name"
        mv "$l002_file" "$new_name"
    fi
done