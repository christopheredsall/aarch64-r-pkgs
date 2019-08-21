#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
# set -eu

# file     = "packages.txt"
# packages = `cat $file`

# begin the pipeline.yml file
echo "steps:"

# add a new test for every package in packages.txt
# for pkg in $packages do
#     cat > ${pkg}.r << EOT
#     install.packages('${pkg}', repos="https://www.stats.bris.ac.uk/R/")
#     library('${pkg}')
#     EOT
#     echo "  - label: ${pkg}"
#     echo "    command: ./driver.sh ${pkg}.r"
#     echo "    soft_fail:"
#     echo "      - exit_status: 1"
# done

echo "  - label: test"
echo "    command: echo TEST"
