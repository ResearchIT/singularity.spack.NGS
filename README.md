# singularity.spack.NGS

Pack SPACK modules into a singularity container using SPACK virtual Env in 3 steps\

1. Build a cento7.6 base container with SPACK installed\
Download the singularity script singularity.spack.base to your current working directory:\
$ sudo singularity build -s centos7-spack.sandbox ./singularity.spack.base\

2. Install SPACK packages into the base container\
Example: install canu 1.8 and its dependent packages. Download singularity_spack_canu1.8.bash to your current working directory:\
$ sudo singularity shell -w -B $PWD:/mnt centos7-spack.sandbox /mnt/singularity_spack_canu1.8.bash \

3. Convert the singularity sandbox to an image\
$ sudo singularity build canu1.8.simg centos7-spack.sandbox\
$ sudo rm -rf ./centos7-spack.sandbox\
