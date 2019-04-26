# singularity.spack.NGS

Pack SPACK modules into a singularity container using SPACK virtual Env in 3 steps

1. Build a CentOS7.6.1810 base container with SPACK installed\
Download the singularity script singularity.spack.base to your current working directory:\
$ sudo singularity build -s centos-spack.sandbox ./singularity.spack.base

2. Install SPACK packages into the base container\
Example: install canu 1.8 and its dependent packages. Download singularity_spack_canu1.8.bash to your current working directory:\
$ sudo singularity shell -w -B $PWD:/mnt centos-spack.sandbox /mnt/singularity_spack_canu1.8.bash 

3. Convert the singularity sandbox to an image\
$ sudo singularity build canu1.8.simg centos-spack.sandbox\
$ sudo rm -rf ./centos-spack.sandbox

To list the installed and loaded modules in the container canu1.8.simg\
$ singularity run canu1.8.simg

To run installed modules like canu in the container canu1.8.simg\
$ singularity exec canu1.8.simg canu --help
