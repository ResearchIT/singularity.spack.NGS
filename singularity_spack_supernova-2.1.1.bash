#!/bin/bash

# Assuming:
#  supernova-2.1.1.tar.gz is pre-downloaded to $PWD for normal installation.
#  for a singularity container, it should be pre-downloaded to /root.
#
#  To check the expected path for the tar file:
#  $ spack info supernova 
#  or
#  $ sudo singularity exec singularity-spack-base-container spack info supernova
#   
# Dependency:
#   supernova depends on bcl2fastq2. As of May 2019, the latest version 2.20.0.422 of bcl2fastq2 
# depdends on boost@1.54,  libxslt@1.1.26, and libxml2-2.7.8. 
#
#   gcc@4.8.5 can compile libxml2@2.7.8, libxslt@1.1.26 and boost@1.54 without issues.
# So, we create an env of gcc4-8-5_boost1-54-0_libxslt1-1-26_libxml2-2-7-8.

SINGULARITY_SPACK_INSTALL=true
TAR_FILE=supernova-2.1.1.tar.gz
 
# for normal spack supernova installation, the tar file is expected to be in $PWD. 
# os.getwd() is called to return the path for the downloaded file in package.py

PRE_DOWNLOAD_PATH=$PWD

# for singularity spack supernova installation, os.getwd() returns /root as 
# using "sudo singularity" to do "spack install supernova"

if [ "${SINGULARITY_SPACK_INSTALL}" = true  ]; then
  PRE_DOWNLOAD_PATH="/root"
fi

# if not find the tar file, echo message, continue installation. 
# let users put the download file to the right location based on the SPACK message

pre_download_file=${PRE_DOWNLOAD_PATH}/${TAR_FILE}
if  ! [ -e ${pre_download_file} ]; then
  msg_lines="\n"
  msg_lines="${msg_lines} ${TAR_FILE} needs to be pre-downloaded.\n"  
  msg_lines="${msg_lines} The expected location is the current working directory for normal spack installation, and /root for singularity spack installation.\n"
  msg_lines="${msg_lines} Run the following command to find the SPACk-expected path for ${TAR_FILE}:\n" 
  msg_lines="${msg_lines} $ spack info supernova  ## normal spack installation, or\n" 
  msg_lines="${msg_lines} $ sudo singularity exec your-singularity-spack-container spack info supernova\n"
  echo -e  ${msg_lines}
fi

spack env create    gcc4-8-5_boost1-54-0_libxslt1-1-26_libxml2-2-7-8
spack env activate  gcc4-8-5_boost1-54-0_libxslt1-1-26_libxml2-2-7-8
spack env view disable

spack install libxml2@2.7.8           %gcc@4.8.5
spack install libxslt@1.1.26          %gcc@4.8.5  ^libxml2@2.7.8 
spack install boost@1.54.0            %gcc@4.8.5  ^libxml2@2.7.8 ^libxslt@1.1.26 

spack install python@2.7.16           %gcc@4.8.5

spack install bcl2fastq2@2.20.0.422   %gcc@4.8.5  ^boost@1.54.0  ^libxml2@2.7.8 ^libxslt@1.1.26 
spack install supernova@2.1.1         %gcc@4.8.5  ^bcl2fastq2@2.20.0.422


# add "module load ...  "  in environment 
echo "spack env activate  gcc4-8-5_boost1-54-0_libxslt1-1-26_libxml2-2-7-8"  >>  /.singularity.d/env/90-environment.sh
echo "spack load supernova@2.1.1"                                            >>  /.singularity.d/env/90-environment.sh
