#!/usr/bin/env python
#
# Post-processing script QE --> EPW
# 14/07/2015 - Samuel Ponce
#

from builtins import input
import numpy as np
import os
import sys


if len(sys.argv) < 3:
    print("Usage: prefix nqpt")
    print('Enter the prefix used for PH calculations (e.g. diam)')
    print('Enter the number of irreducible q-points')
    sys.exit(1)

prefix = sys.argv[1]
nqpt = int(sys.argv[2])


# Enter the number of irr. q-points
#prefix = input('Enter the prefix used for PH calculations (e.g. diam)\n')

# Enter the number of irr. q-points
#nqpt = input('Enter the number of irreducible q-points\n')
try:
  nqpt = int(nqpt)
except ValueError:
  raise Exception('The value you enter is not an integer!')

os.system('mkdir save')

for iqpt in np.arange(1,nqpt+1):
  label = str(iqpt)

  os.system('cp '+prefix+'.dyn'+str(iqpt)+' save/'+prefix+'.dyn_q'+label)
  if (iqpt == 1):
    os.system('cp _ph0/'+prefix+'.dvscf1 save/'+prefix+'.dvscf_q'+label)
    os.system('cp -r _ph0/'+prefix+'.phsave save/')
  else:
    os.system('cp _ph0/'+prefix+'.q_'+str(iqpt)+'/'+prefix+'.dvscf1 save/'+prefix+'.dvscf_q'+label)
    os.system('rm _ph0/'+prefix+'.q_'+str(iqpt)+'/*wfc*' )
