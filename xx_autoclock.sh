#!/bin/bash

function read_project_path() {
    if [ ! -f xx_pfadzumprojekt.txt ]; then
        echo "Error: Configuration file xx_pfadzumprojekt.txt not found."
        exit 1
    fi

    local project_path=$(cat xx_pfadzumprojekt.txt)

    if [ -z "$project_path" ]; then
        echo "Error: No path specified in xx_pfadzumprojekt.txt."
        exit 1
    fi

    if [ ! -d "$project_path" ]; then
        echo "Error: Directory $project_path does not exist."
        exit 1
    fi

    echo $project_path
}

function check_git_repo() {
    local project_path=$1

    if [ ! -d "$project_path/.git" ]; then
        echo "Error: Directory $project_path is not a Git repository."
        exit 1
    fi
}

function execute_git_commands() {
    local laufnummer=$1

    git pull
    git add .
    let "laufnummer++"
    git commit --allow-empty -m "Commit at $(date), sequence number $laufnummer"
    git push

    if [ $? -ne 0 ]; then
        echo "An error occurred when executing the git command"
        exit 1
    fi

    echo $laufnummer
}

function calculate_secs() {
    # Random-Option (voreingestellt)
    local secs=$((RANDOM % 7200))

    # Entfernen Sie die Ausklammerung, um eine andere Option zu wählen:

    # Option für 1 Stunde
    #secs=3600

    # Option für 2 Stunden
    #secs=7200

    # Option für 4 Stunden
    #secs=14400

    # Option für 12 Stunden
    #secs=43200

    echo $secs
}

project_path=$(read_project_path)
check_git_repo $project_path
cd $project_path
sudo chmod -R 777 .git
laufnummer=0
secs=$(calculate_secs)

while true; do
    echo "Executing git commands.."
    laufnummer=$(execute_git_commands $laufnummer)

    while [ $secs -gt 0 ]; do
        echo -ne "Waiting until next commit: $secs\033[0K\r"
        sleep 1
        : $((secs--))
    done

    secs=$(calculate_secs)
done
