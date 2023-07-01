#!/bin/bash

if [ ! -f xx_pfadzumprojekt.txt ]; then
    echo "Error: Configuration file xx_pfadzumprojekt.txt not found."
    exit 1
fi

project_path=$(cat xx_pfadzumprojekt.txt)

if [ -z "$project_path" ]; then
    echo "Error: No path specified in xx_pfadzumprojekt.txt."
    exit 1
fi

if [ ! -d "$project_path" ]; then
    echo "Error: Directory $project_path does not exist."
    exit 1
fi

cd $project_path

sudo chmod -R 777 .git

if [ ! -d ".git" ]; then
    echo "Error: Directory $project_path is not a Git repository."
    exit 1
fi

laufnummer=0

# Configure the wait time in seconds between commits.
# You can uncomment one of the following options:

# Option 1: Commit every hour
# secs=3600

# Option 2: Commit every 2 hours
# secs=$((2 * 3600))

# Option 3: Commit every 6 hours
# secs=$((6 * 3600))

# Option 4: Commit every 12 hours
# secs=$((12 * 3600))

# Option 5: Random commit time within 120 minutes
secs=$((RANDOM % 7200))

while true; do
    echo "Executing git commands.."
    git pull
    git add .
    let "laufnummer++"
    git commit --allow-empty -m "Commit at $(date), sequence number $laufnummer"
    git push
    if [ $? -ne 0 ]; then
        echo "An error occurred when executing the git command"
        exit 1
    fi

    while [ $secs -gt 0 ]; do
        echo -ne "Waiting until next commit: $secs\033[0K\r"
        sleep 1
        : $((secs--))
    done

    secs=$((RANDOM % 7200))
done
