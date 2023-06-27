#!/bin/bash

# Lese den Pfad aus der Konfigurationsdatei
project_path=$(cat xx_pfadzumprojekt.txt)

cd $project_path

while true; do
    hour=$(date +%H)
    minute=$(date +%M)

    # Führe die Befehle aus, wenn es 9 Uhr morgens ist
    if [ $hour -eq 9 ] && [ $minute -lt 10 ]; then
        git add .
        git commit -m "morgens"
        git push
        if [ $? -ne 0 ]; then
            echo "Ein Fehler ist aufgetreten bei der Ausführung des morgendlichen git-Befehls"
            exit 1
        fi
    fi

    # Führe die Befehle aus, wenn es 16 Uhr nachmittags ist
    if [ $hour -eq 16 ] && [ $minute -lt 10 ]; then
        git add .
        git commit -m "nachmittags"
        git push
        if [ $? -ne 0 ]; then
            echo "Ein Fehler ist aufgetreten bei der Ausführung des nachmittäglichen git-Befehls"
            exit 1
        fi
    fi

    # Warte 10 Minuten
    sleep 600
done
