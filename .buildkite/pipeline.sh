#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eu

mapfile -t packages < packages.txt

# begin the pipeline.yml file
echo "steps:"

# Isambard
#MODULESHOME=/usr/share/Modules/3.2.10
#RMODULE=cray-R/3.4.2

# Catalyst
export MODULESHOME=/opt/cray/pe/modules/3.2.11.2
export RMODULE=lang/r/3.6.0-gcc


for pkg in ${packages[@]}
do
echo "  - label: ${pkg}"
echo "    commands:"
echo "        - source ${MODULESHOME}/init/bash"
echo "        - module load ${RMODULE}"
echo "        - echo \"if (!require('${pkg}')) { install.packages('${pkg}', repos='https://www.stats.bris.ac.uk/R/') }; library('${pkg}')\" | R --vanilla --quiet"
echo "    agents:"
echo "      queue: 'isambard'"
echo "    soft_fail:"
echo "        - exit_status: 1"
done
