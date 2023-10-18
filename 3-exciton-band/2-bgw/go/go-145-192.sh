#!/bin/bash
#SBATCH -J 145-192
#SBATCH -o myjob.o\%j
#SBATCH -e myjob.e\%j
#SBATCH -p normal
#SBATCH -N 10
#SBATCH -n 560
#SBATCH -t 48:00:00
#SBATCH -A PHY20032

#QEPATH='/global/homes/b/bwhou/software/qe-6.7/bin'
BGWPATH1='/home1/08237/bwhou/software/BerkeleyGW-3.0.1/bin/'


cd inteqp
#ibrun $BGWPATH1/inteqp.cplx.x > inteqp.out
cd ../
for ((i=145;i<=192;i++));
do
cd ./Q-$i
cd ./5.1-kernel-Q
ibrun   $BGWPATH1/kernel.cplx.x > kernel.out
cd ../5.2-absorp-Q
ibrun  $BGWPATH1/absorption.cplx.x > absorption.out
cd ../../
done
