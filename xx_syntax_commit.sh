#!/bin/bash

# Lese den Pfad aus der Konfigurationsdatei
project_path=$(cat xx_pfadzumprojekt.txt)

cd $project_path

# Initialisiere die Laufnummer
laufnummer=0

# Führe den ersten Commit aus, wenn das Skript gestartet wird
echo "Ausführung des initialen git-Befehls..."
git add .
let "laufnummer++"
git commit --allow-empty -m "Initialer Commit, Laufnummer $laufnummer"
git push
if [ $? -eq 0 ]; then
    echo "Der initiale git-Befehl wurde erfolgreich ausgeführt"
else
    echo "Ein Fehler ist aufgetreten bei der Ausführung des initialen git-Befehls"
    exit 1
fi

while true; do
    hour=$(date +%H)

    echo "Aktuelle Uhrzeit: $(date)"

    # Führe die Befehle zu Beginn jeder Stunde aus
    echo "Ausführung des stündlichen git-Befehls..."
    git add .
    let "laufnummer++"
    git commit --allow-empty -m "Commit um $hour Uhr, Laufnummer $laufnummer"
    git push
    if [ $? -ne 0 ]; then
        echo "Ein Fehler ist aufgetreten bei der Ausführung des stündlichen git-Befehls"
        exit 1
    fi

    # Warte 1 Stunde und zeige einen Countdown-Timer an
    secs=3600
    while [ $secs -gt 0 ]; do
        echo -ne "Wartezeit bis zum nächsten Commit: $secs\033[0K\r"
        sleep 1
        : $((secs--))
    done
done
