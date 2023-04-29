
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
virus_ss <- readRDS("./Data_Analytics_Project/Output/virus_string_set")
virus_align <- readRDS("./Data_Analytics_Project/Output/virus_align")
virus_align <- readRDS("./Data_Analytics_Project/Output/virus_align")
