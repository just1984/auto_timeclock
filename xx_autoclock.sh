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

echo "Executing initial git command..."
git add .
let "laufnummer++"
git commit --allow-empty -m "Initial Commit, sequence number $laufnummer"
git push
if [ $? -eq 0 ]; then
    echo "The initial git command was successfully executed"
else
    echo "An error occurred when executing the initial git command"
    exit 1
fi

# Change permissions of log files (commented out)
# sudo chmod -R 777 .git/logs

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
    hour=$(date +%H)

    echo "Current time: $(date)"

    # Execute the commands at the beginning of each hour
    echo "Executing hourly git command..."
    git pull
    git add .
    let "laufnummer++"
    git commit --allow-empty -m "Commit at $hour, Run number $laufnummer"
    git push
    if [ $? -ne 0 ]; then
        echo "An error occurred when executing the hourly git command"
        exit 1
    fi

    # Wait for the specified time and display a countdown timer
    while [ $secs -gt 0 ]; do
        echo -ne "Waiting until next commit: $secs\033[0K\r"
        sleep 1
        : $((secs--))
    done
done
