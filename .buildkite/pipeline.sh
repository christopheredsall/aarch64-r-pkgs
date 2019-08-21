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
echo "    command: ./driver.sh dplyr.r"
