#!/usr/bin/env python3
from Bio import SeqIO
import sys

lastGene = None
longest = (None, None)
for rec in SeqIO.parse("csi.cDNA.fa", "fasta"):
    gene = ".".join(rec.id.split(".")[:-1])
    l = len(rec)
    if lastGene is not None:
        if gene == lastGene:
            if longest[0] < l:
                longest = (l, rec)
        else:
            lastGene = gene
            SeqIO.write(longest[1], sys.stdout, "fasta")
#            print(longest[1])
            
        
            longest = (l, rec)
    else:
        lastGene = gene
        longest = (l, rec)
SeqIO.write(longest[1], sys.stdout, "fasta")
#print(longest[1])