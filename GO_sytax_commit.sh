#!/bin/bash

# Lese den Pfad aus der Konfigurationsdatei
script_path=$(cat xx_pfadzumprojekt.txt)

chmod +x $script_path/commit_script.sh
$script_path/commit_script.sh