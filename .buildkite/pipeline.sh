#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eu

packages=()
declare -A repositories
declare -A organisations

# read a commma separated table of packages, three columns
# package_name, repository, organiaisation
# (github packages require an organisaition to install)

OLD_IFS=$IFS
IFS=","
while read -r name repo org 
do
    packages+=("${name}")
    repositories[${name}]=${repo}
    organisations[${name}]=${org}
done < packages.csv
IFS=${OLD_IFS}

# begin the pipeline.yml file
echo "steps:"

for queue in isambard catalyst
do
    case $queue in
    isambard)
        export MODULESHOME=/opt/cray/pe/modules/3.2.11.2
        export RMODULE=cray-R/3.4.2
        ;;
    catalyst)
        export MODULESHOME=/usr/share/Modules/3.2.10
        export RMODULE=lang/r/3.6.0-gcc
        ;;
    esac
    for pkg in "${packages[@]}"
    do
        # for the meantime only do CRAN
        if [ "${repositories[${pkg}]}" == "CRAN" ]; then
            echo "  - label: ${pkg}"
            echo "    commands:"
            echo "        - source ${MODULESHOME}/init/bash"
            echo "        - module load ${RMODULE}"
            echo "        - echo \"if (!require('${pkg}')) { install.packages('${pkg}', repos='https://www.stats.bris.ac.uk/R/') }; library('${pkg}')\" | nice R --vanilla --quiet"
            echo "    agents:"
            echo "      queue: ${queue}"
            echo "    soft_fail:"
            echo "        - exit_status: 1"
        fi
    done
done
