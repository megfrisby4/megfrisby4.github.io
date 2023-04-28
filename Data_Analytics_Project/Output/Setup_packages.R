knitr::opts_chunk$set(echo = TRUE, warning=FALSE, error = FALSE)
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
library(ggtree)

#github packages
library(compbio4all)
library(ggmsa)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DECIPHER")