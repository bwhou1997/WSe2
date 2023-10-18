#!/bin/bash
#SBATCH -J WSe2
#SBATCH -o myjob.o\%j
#SBATCH -e myjob.e\%j
#SBATCH -p development
#SBATCH -N 40
#SBATCH -n 2240
#SBATCH -t 2:00:00
#SBATCH -A PHY20032

#QEPATH='/global/homes/b/bwhou/software/qe-6.7/bin'
BGWPATH1='/home1/08237/bwhou/software/BerkeleyGW-3.0.1/bin/'


ibrun $BGWPATH1/sigma.cplx.x > sigma.out

