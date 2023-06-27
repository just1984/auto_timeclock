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
    minute=$(date +%M)

    echo "Aktuelle Uhrzeit: $(date)"

    # Führe die Befehle aus, wenn die Minute kleiner als 10 ist (also zu Beginn jeder Stunde)
    if [ $minute -lt 10 ]; then
        echo "Ausführung des stündlichen git-Befehls..."
        git add .
        let "laufnummer++"
        git commit --allow-empty -m "Commit um $hour Uhr, Laufnummer $laufnummer"
        git push
        if [ $? -ne 0 ]; then
            echo "Ein Fehler ist aufgetreten bei der Ausführung des stündlichen git-Befehls"
            exit 1
        fi
        # Warte 10 Minuten nach dem Commit, um mehrfache Commits innerhalb des 10-Minuten-Fensters zu vermeiden
        sleep 600
    else
        echo "Keine Aktion, warte auf den nächsten Zeitfenster..."
    fi

    # Warte 1 Minute
    sleep 60
done
