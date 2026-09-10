#!/bin/bash
set -e

# Convert level JSON and inject into hero.bas
python3 convert_levels.py

# Compile bB game
export bB=/mnt/ExtraData/programas/bB
export PATH=$PATH:$bB
$bB/2600basic.sh hero.bas
