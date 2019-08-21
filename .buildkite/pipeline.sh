#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eu

mapfile -t packages < packages.txt

# begin the pipeline.yml file
echo "steps:"

for pkg in ${packages[@]}
do
echo "  - label: ${pkg}"
echo "    commands:"
echo "        - MODULESHOME=/usr/share/Modules/3.2.10"
echo "        - source ${MODULESHOME}/init/bash"
echo "        - module load lang/r/3.6.0-gcc"
echo "        - echo \"if (!require('${pkg}')) { install.packages('${pkg}', repos='https://www.stats.bris.ac.uk/R/') } library('${pkg}')\" | R --vanilla --quiet"
echo "    soft_fail:"
echo "        - exit_status: 1"
done
