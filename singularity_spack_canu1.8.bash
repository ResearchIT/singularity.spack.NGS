#!/bin/bash

spack env create    gcc4-8-5_py2-7-16
spack env activate  gcc4-8-5_py2-7-16
spack env view disable

spack install python@2.7.16  %gcc@4.8.5
spack install canu@1.8       %gcc@4.8.5

## add "spack load ......" in environment
echo "spack env activate  gcc4-8-5_py2-7-16 "  >>  /.singularity.d/env/90-environment.sh
echo "spack load  canu@1.8 "                   >>  /.singularity.d/env/90-environment.sh
