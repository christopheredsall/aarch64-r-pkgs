#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eu

# begin the pipeline.yml file
echo "steps:"

# add a new test for every package in packages.txt
#     echo "  - label: ${pkg}"
#     echo "    command: ./driver.sh ${pkg}.r"
#     echo "    soft_fail:"
#     echo "      - exit_status: 1"

echo "  - label: dplyr"
echo "    commands:"
echo "        - MODULESHOME=/usr/share/Modules/3.2.10"
echo "        - source ${MODULESHOME}/init/bash"
echo "        - module load lang/r/3.6.0-gcc"
echo "        - echo 'install.packages(dplyr, repos=\"https://www.stats.bris.ac.uk/R/\"); library(dplyr)' | R --vanilla --quiet"
