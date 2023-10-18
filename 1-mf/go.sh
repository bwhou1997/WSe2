#!/bin/bash
#SBATCH -J WSe2       # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p development          # Queue (partition) name
#SBATCH -N 40              # Total # of nodes
#SBATCH -n 2240           # Total # of mpi tasks
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

cd 1-scf
#ibrun $QEPATH/pw.x -nk 16 -input scf.in > scf.out
cd ../2.1-wfn
ibrun $QEPATH/pw.x -nk 16 -input in > in.out
ibrun $QEPATH/pw2bgw.x -nk 16 -input pp_in > pp_out

cd ../2.2-wfnq
#ibrun $QEPATH/pw.x -nk 16 -input in > in.out
#ibrun $QEPATH/pw2bgw.x -nk 16 -input pp_in > pp_out

cd ../4-path
#ibrun $QEPATH/pw.x -nk 16 -input band.in > band.out
#ibrun $QEPATH/pw2bgw.x -nk 16 -input pp_in > pp_out
#ibrun $QEPATH/bands.x -nk 16 -input bands.in > bands.out

