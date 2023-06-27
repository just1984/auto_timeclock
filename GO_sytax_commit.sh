#!/bin/bash

# Lese den Pfad aus der Konfigurationsdatei
script_path=$(cat xx_pfadzumprojekt.txt)

chmod +x $script_path/xx_sytax_commit.sh
$script_path/xx_sytax_commit.sh
