import numpy as np


class eqp():
    """
    These object decompose eqp.dat into data_LDA, data_GW, klist and spin_list
    """
    def __init__(self,fname):
        print('Reading eqp')
        self.fname = fname
        self.read_eqp()
        # These variables are initialized
        # (1) nbnd, nk
        # (2) data_GW, data_LDA -> (nk, nbnd)
        # (3) band_index, spin ->(nband,); klist -> (nk,)

        #self.write()

    def read_eqp(self):
        f = open(self.fname, 'r')
        lines = f.readlines()
        f.close()

        self.nbnd = int(lines[0].split()[-1])
        self.nk = int(len(lines) / (self.nbnd + 1))

        print('number of bands:', self.nbnd)
        print('number of kpoints:', self.nk)

        self.data_GW = np.zeros((self.nk, self.nbnd))
        self.data_LDA = np.zeros((self.nk, self.nbnd))
        self.band_index = np.zeros((self.nbnd),dtype=int)
        self.spin_index = np.zeros((self.nbnd),dtype=int)
        self.klist = []

        # get
        line = 0
        for i in range(self.nk):
            temp_k = lines[line]
            self.klist.append("  ".join(temp_k.split()[:3]))
            # print(" ".join(temp_k.split()[:3]))
            line += 1
            for j in range(self.nbnd):
                if i == 0:
                    self.band_index[j] = int(lines[line].split()[1])
                    self.spin_index[j] = int(lines[line].split()[0])
                self.data_LDA[i, j ] = lines[line].split()[-2]
                self.data_GW[i, j ] = lines[line].split()[-1]
                line += 1
        self.data_LDA = np.around(self.data_LDA,9)


    def write(self):
        f_new = open('eqp_new.dat','w')
        line = 0
        for i in range(self.nk):
            f_new.write('  '+self.klist[i]+'      %s'%self.nbnd+'\n')
            line += 1
            for j in range(self.nbnd):

                f_new.write('       %s     %s    %.9f    %.9f\n' % (self.spin_index[j], self.band_index[j], self.data_LDA[i,j], self.data_GW[i,j]))
                # print('%s %s %s %s' % (self.spin_index[j], self.band_index[j], self.data_LDA[i,j], self.data_GW[i,j]))
                line += 1


if __name__ == "__main__":
    fname = "eqp.dat"
    nvalence = 8
    eqp1 = eqp(fname=fname)
    scissor_shift = -0.5 # [eV]

    # do cv apart
    eqp1.data_LDA[:,nvalence:] = eqp1.data_LDA[:,nvalence:] + scissor_shift
    eqp1.data_GW[:,nvalence:]  = eqp1.data_GW[:,nvalence:] + scissor_shift

    eqp1.write()





