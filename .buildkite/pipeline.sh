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
        # for the meantime only do CRAN and GitHub
        # TODO refactor with remotes - https://github.com/r-lib/remotes
        RSCRIPT=""
        case "${repositories[${pkg}]}" in
        CRAN)
            RSCRIPT="if ("'!'"require('${pkg}')) { install.packages('${pkg}', repos='https://www.stats.bris.ac.uk/R/') }; library('${pkg}')"
            ;;
        github)
            RSCRIPT="if ("'!'"require('${pkg}')) { devtools::install_github('${organisations[${pkg}]}/${pkg}')  }; library('${pkg}')"
            ;;
        bioconductor)
            RSCRIPT="if ("'!'"require('${pkg}')) { BiocManager::install('${pkg}')  }; library('${pkg}')"
            ;;
        rforge)
            RSCRIPT="if ("'!'"require('${pkg}')) { install.packages('${pkg}', repos='http://rforge.net/') }; library('${pkg}')"
            ;;
        *)
            # unsupported, skip
            ;;
        esac
        if [ -n "${RSCRIPT}" ] ; then
            echo "  - label: ${pkg}"
            echo "    commands:"
            echo "        - source ${MODULESHOME}/init/bash"
            echo "        - module load ${RMODULE}"
            echo "        - echo \" $RSCRIPT \" | nice R --vanilla --quiet"
            echo "    agents:"
            echo "      queue: ${queue}"
            echo "    soft_fail:"
            echo "        - exit_status: 1"
        fi
    done
done
