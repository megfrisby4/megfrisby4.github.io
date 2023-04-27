```{r}
s1 <- rep("Filoviridae", 12)
s2 <- rep("Artoviridae",7 )
s3 <- rep("Bornaviridae",18)
s4 <- rep("Lispiviridae", 6)
s5 <- rep("Mymonaviridae", 4)
s6 <- rep("Nyamiviridae", 13)
s7 <- rep("Paramyxoviridae",72)
s8 <- rep("Pneumoviridae", 9)
s9 <- rep("Sunshinevirus", 1)
s10 <- rep("Xinmoviridae",8)
s11 <- rep("Rhabdoviridae", 70)
fam <- c(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11)
length(fam)

df <- base::data.frame(accession_number=virus_list, virus_family=fam)
#write.csv(df, file="./Data/virus_acc_fam.csv")



```{r}
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
#write.csv(df, "./Data/Virus_species_and_accession_data.csv")