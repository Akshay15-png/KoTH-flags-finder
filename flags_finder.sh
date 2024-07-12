#!/bin/bash

echo -e "\n********* It may take time *********\n"
echo "Enter directory name: "
read dir
# Combine all find results into a single list, separated by newlines
cmd=$(find /$dir -type f -exec grep -l "THM{" {} + 2>/dev/null)
cmd+=$'\n'$(find /$dir -type f -name "*flag" 2>/dev/null)
cmd+=$'\n'$(find /$dir -type f -name "flag*" 2>/dev/null)
cmd+=$'\n'$(find /$dir -type f -name "*flag*" 2>/dev/null)

# Remove empty lines and duplicates
flags=$(echo "$cmd" | sort | uniq | grep -v '^$')

if [ -z "$flags" ]; then
    echo -e "\nNot Found Any Flag\n"
    exit
else
    echo -e "\n********* Done! possible files that may have flags*********\n"
    echo "$flags"
    exit
fi
