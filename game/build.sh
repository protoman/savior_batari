#!/bin/bash
set -e

# Compile bB game (level code already injected by convert_levels.py)
export bB=/mnt/ExtraData/programas/bB
export PATH=$PATH:$bB
$bB/2600basic.sh hero.bas
