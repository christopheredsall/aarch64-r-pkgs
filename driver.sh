#!/bin/bash

MODULESHOME=/usr/share/Modules/3.2.10
source ${MODULESHOME}/init/bash
module load lang/r/3.6.0-gcc
R --vanilla --quiet --file=$1

