#!/bin/bash
#  Batch script for mpirun YANK job on cbio cluster.
#
#
# walltime : maximum wall clock time (hh:mm:ss)
#PBS -l walltime=48:00:00
#
# join stdout and stderr
#PBS -j oe
#
# spool output immediately
#PBS -k oe
#
# specify queue
#PBS -q gpu
#
# nodes: number of nodes
#   ppn: how many cores per node to use
#PBS -l nodes=1:ppn=4:gpus=4:shared
#
# export all my environment variables to the job
##PBS -V
#
# job name (default = name of script file)
#PBS -N hsa

if [ -n "$PBS_O_WORKDIR" ]; then 
    cd $PBS_O_WORKDIR
fi

cat $PBS_GPUFILE

export SCHRODINGER="/cbio/jclab/share/schrodinger/schrodinger2016-1/"

# Run the simulation with verbose output:
echo "Running simulation via MPI..."
build_mpirun_configfile "yank script --yaml=yank.yaml"
mpirun -configfile configfile
date

