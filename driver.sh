#!/bin/bash

MODULESHOME=/opt/cray/pe/modules/3.2.11.2
source ${MODULESHOME}/init/bash
module load  cray-R/3.4.2
R --vanilla --quiet --file=$1

