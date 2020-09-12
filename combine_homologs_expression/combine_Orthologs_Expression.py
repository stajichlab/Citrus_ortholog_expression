#!/usr/bin/env python3
# Author: Talieh Ostovar

import re, sys, csv

singlecopy="Orthogroups_SingleCopyOrthologues.txt"
orthogroups="Orthogroups.txt"

TPMfiles = ['TPM_reticulata_embryo_r1.tsv','TPM_sinensis_embryo_r1.tsv']

singlecopyOG = set() #  a set is like a list but it is only a unique set of items

# read in the names of the single copy orthologs to keep
with open(singlecopy,"r") as sc:
    for line in sc:
        singlecopyOG.add(line.strip())

# read in the orthogroups
OGdata = {}

TPMs = {} # can assume that gene names are unique so put them all in one place
# this structure needs to change when you want to incorporate multiple
# expression timepoints/replicates
# loop through the names of the files
for TPMfile in TPMfiles:
    # open the file
    with open(TPMfile,"r") as tsvfile:
        # if they really were tab delimited use this
        #exprdr = csv.reader(tsvfile, delimiter='\t')
        # parse file with csv module in python
        exprdr = csv.reader(tsvfile, delimiter=' ')
        header=next(exprdr)
        for row in exprdr:
            (gene_name,TPM) = row
            TPMs[gene_name] = TPM


print("\t".join(["Orthogroup",'Cr','Cr.expr','Cs','Cs.expr']))

with open(orthogroups,"r") as og:
    for line in og:
        # split the Orthogroups line by whitespace (space)
        gene_names = line.split()
        # take first item off this is Orthogroup ID
        # remove the ':' in the name at same time
        orthogroupID = re.sub(":","",gene_names.pop(0))

        if orthogroupID in singlecopyOG:
            og = dict()
            for gene in gene_names:
                if gene in TPMs:
                    if gene.startswith("MSY"):
                        og['Cr'] = [gene,TPMs[gene]]
                    elif gene.startswith("Cs") or gene.startswith("orange"):
                        og['Cs'] = [gene,TPMs[gene]]
                    else:
                        sys.stderr.write("Unknown gene pattern for '%s' cannot guess Species"%(gene))

            OGdata[orthogroupID] = og
            if 'Cr' in og and 'Cs' in og:
                print("\t".join([orthogroupID,
                                og['Cr'][0],
                                og['Cr'][1],
                                og['Cs'][0],
                                og['Cs'][1] ]))
