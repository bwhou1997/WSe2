#!/bin/bash
#SBATCH -J WSe2       # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p development          # Queue (partition) name
#SBATCH -N 3              # Total # of nodes
#SBATCH -n 168           # Total # of mpi tasks
#SBATCH -t 02:00:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A PHY20032       # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=username@tacc.utexas.edu

# Any other commands must follow all #SBATCH directives...
module list
pwd
date

# Path setting
BGWPATH="/home1/08237/bwhou/software/BGW-tolsmall/BerkeleyGW/bin/"
QEPATH="/home1/08237/bwhou/software/qe-6.7/bin"
# Start mpi running for 1-mf

pwd
date

ibrun $QEPATH/pw.x -input in > in.out
ibrun $QEPATH/pw2bgw.x -input pp_in > pp_out

