#CRAN Packages
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
list_split <- list()
for (i in 1:length(virus_fasta_list)){list_split[[i]] <- str_split(virus_fasta_list[[i]],pattern = ',')
}

virus_names <- list()
for (i in 1:length(list_split)) {virus_names[[i]] <- purrr::map(list_split[[i]],1)

}


virus_species <- list()
virus_1 <- str_split(virus_names, "\\\\")
for (i in 1:length(virus_1)) {virus_species[[i]] <- purrr::map(virus_1[[i]][[1]],1)

}

virus_species <- unlist(virus_species)
virus_species <- str_remove(virus_species, "^...................")
virus_species <- str_remove(virus_species, "..$")

df <- data.frame(df, virus_species=virus_species)
genome_list <- list()
for(i in 1:length(virus_fasta_list)){
  genome_list[[i]] <- fasta_cleaner(virus_fasta_list[[i]], parse = F)
}

virus_vector <- rep(NA, length(genome_list))

for(i in 1:length(virus_vector)){
  virus_vector[i] <- genome_list[[i]]}

names(virus_vector) <- virus_species

virus_vector_ss <- Biostrings::DNAStringSet(virus_vector)

saveRDS(virus_vector_ss, "./Data_Analytics_Project/Output/virus_string_set")
