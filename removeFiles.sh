#!/bin/bash

# Check if at least one file name is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 file1 [file2 ...]"
  exit 1
fi

# Loop through all arguments (file names) provided to the script
for file in "$@"
do
  # Check if the file exists in the repository
  if [ -f "$file" ]; then
    # Remove the file from the repository and stage the removal for commit
    git rm "$file"
  else
    echo "File $file does not exist in the repository."
  fi
done

# Commit the removal of the files
git commit -m "Removed files via script"

# Push the changes to GitHub
git push origin main

echo "Files removed and changes pushed to GitHub."

