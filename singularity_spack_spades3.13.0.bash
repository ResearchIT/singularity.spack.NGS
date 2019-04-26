#!/bin/bash

#install gcc@7.4.0 to meet dependency
spack install gcc@7.4.0
source /etc/profile.d/modules.sh
source $SPACK_ROOT/share/spack/setup-env.sh

#setup compilers.yaml for gcc@7.4.0 installed by SPACK
spack load gcc@7.4.0
spack compiler find --scope site

spack env create    gcc7-4-0_py3-7-2
spack env activate  gcc7-4-0_py3-7-2 
spack env view disable

spack install python@3.7.2   %gcc@7.4.0
spack install spades@3.13.0  %gcc@7.4.0 ^python@3.7.2


## add "spack load ..."  in environment
echo "spack env activate  gcc7-4-0_py3-7-2 "  >>  /.singularity.d/env/90-environment.sh
echo "spack load spades@3.13.0  "             >>  /.singularity.d/env/90-environment.sh

