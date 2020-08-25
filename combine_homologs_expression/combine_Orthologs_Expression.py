#!/usr/bin/env python3
import numpy as np

data1 = np.genfromtxt('Orthogroups.txt', delimiter=' ', deletechars=":", usecols=(0), dtype=str)

data2 = np.genfromtxt('Orthogroups_SingleCopyOrthologues.txt', delimiter=' ', usecols=(0), dtype=str, deletechars='OG')
data3 = [d.replace('OG', '') for d in data2]
data3 = [int(d) for d in data3]
data4 = [d.replace('OG', '').replace(':', '') for d in data1]
data4 = [int(d) for d in data4]

with open('Orthogroups.txt', 'r') as f:
    lines = f.readlines()
with open('res.txt', 'w') as outFile:
    for i in data3:
        outFile.write(lines[i].replace(':', ''))

fromRes = np.genfromtxt('res.txt', delimiter=' ', dtype=str)

tpm4reticualta = np.genfromtxt('TPM_reticulata_embryo_r1.tsv', delimiter=' ', dtype=str)
tpm4sinesis = np.genfromtxt('TPM_sinensis_embryo_r1.tsv', delimiter=' ', dtype=str)

secCol = fromRes[:, 1]
thirdCol = fromRes[:, 2]
tpmCol2 = np.zeros(9357)
tpmCol3 = np.zeros(9357)
counter = 0

for item2 in secCol:
    if "MSY" in item2:
        # go check the file for ms
        for i in tpm4reticualta:
            if item2 == i[0]:
                tpmCol2[counter] = i[1]
                break

    if "Cs" in item2:
        for i in tpm4sinesis:
            if item2 == i[0]:
                tpmCol2[counter] = i[1]
                break

    if "orange" in item2:
        for i in tpm4sinesis:
            if item2 == i[0]:
                tpmCol2[counter] = i[1]
                break
    counter = counter + 1
counter = 0
for item3 in thirdCol:
    if "MSY" in item3:
        # go check the file for ms
        for i in tpm4reticualta:
            if item3 == i[0]:
                # this is tpm
                tpmCol3[counter] = i[1]
                break

    if "Cs" in item3:
        for i in tpm4sinesis:
            if item3 == i[0]:
                # this is tpm
                tpmCol3[counter] = i[1]
                break

    if "orange" in item3:
        for i in tpm4sinesis:
            if item3 == i[0]:
                tpmCol3[counter] = i[1]
                break
    counter = counter + 1

tpmCat = np.concatenate((tpmCol2.reshape(-1, 1), tpmCol3.reshape(-1, 1)), axis=1)
finalResult = np.concatenate((fromRes, tpmCat), axis=1)
