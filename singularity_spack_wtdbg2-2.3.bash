#!/bin/bash

spack env create    gcc4-8-5_py2-7-16
spack env activate  gcc4-8-5_py2-7-16
spack env view disable

spack install wtdbg2@2.3     %gcc@4.8.5


## add "spack load ..." in environment
echo "spack env activate  gcc4-8-5_py2-7-16 "  >>  /.singularity.d/env/90-environment.sh
echo "spack load wtdbg2@2.3 "                  >>  /.singularity.d/env/90-environment.sh

