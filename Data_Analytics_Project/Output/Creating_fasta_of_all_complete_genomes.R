```{r, message=FALSE, results='hide'}
library(biomaRt)
virus_fasta_list <- entrez_fetch_list(db = "nucleotide", 
id =virus_list, 
rettype = "fasta")
write.fasta(sequences = virus_fasta_list, names = names(virus_fasta_list), 
            file.out = "./Data_Analytics_Project/Data/virus_genomes.FASTA")

virus_fasta_list <- readRDS("./Data_Analytics_Project/Output/virus_fasta_list")
virus_fasta_list %>% glimpse()
```

#cleaning the sequences 
genome_list <- list()
for(i in 1:length(virus_fasta_list)){
  genome_list[[i]] <- fasta_cleaner(virus_fasta_list[[i]], parse = F)
}
glimpse(genome_list)
```

#making the fasta into a vector 
#blank vector first 
virus_vector <- rep(NA, length(genome_list))
virus_vector

#filling it with the genomes 
for(i in 1:length(virus_vector)){
  virus_vector[i] <- genome_list[[i]]}
glimpse(virus_vector)

#adding the organism names 
names(virus_vector) <- virus_species

saveRDS(virus_vector, "./Data_Analytics_Project/Output/virus_vector")
converting to a biostrings stringset 
virus_vector_ss <- Biostrings::DNAStringSet(virus_vector)
virus_vector_ss <- readRDS("./Output/virus_string_set")
virus_vector_ss 

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("msa")
n
devtools::install_github("brouwern/compbio4all")
devtools::install_github("YuLab-SMU/ggmsa")
