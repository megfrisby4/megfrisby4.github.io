library(dplyr)
library(tidyverse)
library(ape)
library(seqinr)
library(rentrez)
library(devtools)
library(stringr)



#Bioconductor packages 
library(msa)
library(Biostrings)


#github packages
library(compbio4all)
library(ggmsa)

filo <- readr::read_lines("./Data_Analytics_Project/Data/Filoviridae.acc_lst")
art <- readr::read_lines("./Data_Analytics_Project/Data/Artoviridae.acc_lst")
born <- readr::read_lines("./Data_Analytics_Project/Data/Bornaviridae.acc_lst")
lisp <- readr::read_lines("./Data_Analytics_Project/Data/Lispiviridae.acc_lst")
mym <- readr::read_lines("./Data_Analytics_Project/Data/Mymonaviridae.acc_lst")
nyan <- readr::read_lines("./Data_Analytics_Project/Data/Nyamiviridae.acc_lst")
para <- readr::read_lines("./Data_Analytics_Project/Data/Paramyxoviridae.acc_lst")
pneu <- readr::read_lines("./Data_Analytics_Project/Data/Pneumoviridae .acc_lst")
sun <- readr::read_lines("./Data_Analytics_Project/Data/Sunshinevirus.acc_lst")
xin <- readr::read_lines("./Data_Analytics_Project/Data/Xinmoviridae.acc_lst")
rhab <- readr::read_lines("./Data_Analytics_Project/Data/rhabdovirus.acc_lst")
virus_list <- c(filo,art,born,lisp,mym,nyan,para,pneu,sun,xin,rhab)
virus_list

library(biomaRt)
virus_fasta_list <- entrez_fetch_list(db = "nucleotide", 
                                      id =virus_list, 
                                      rettype = "fasta")
saveRDS(virus_fasta_list, "./Data_Analytics_Project/OUtput/virus_fasta_list")
