```{r, message=FALSE, results='hide'}
Lloviu_cuevavirus<- rentrez::entrez_fetch(db = "nucleotide",
                                          id = "NC_016144", 
                                          rettype = "fasta")

cat(Lloviu_cuevavirus)
```


#making a list of filovirus genomes 
Mengla_dianlovirus <- rentrez::entrez_fetch(db = "nucleotide",
                                            id = "NC_055510", 
                                            rettype = "fasta")

Bombali_ebolavirus <- rentrez::entrez_fetch(db = "nucleotide",
                                            id = "NC_039345", 
                                            rettype = "fasta")

Bundibugyo_ebolavirus <- rentrez::entrez_fetch(db = "nucleotide",
                                               id = "NC_014373", 
                                               rettype = "fasta")

Reston_ebolavirus <- rentrez::entrez_fetch(db = "nucleotide",
                                           id = "NC_004161", 
                                           rettype = "fasta")

Sudan_ebolavirus <- rentrez::entrez_fetch(db = "nucleotide",
                                          id = "NC_006432", 
                                          rettype = "fasta")

Tai_Forest_ebolavirus <- rentrez::entrez_fetch(db = "nucleotide",
                                               id = "NC_014372", 
                                               rettype = "fasta")


Zaire_ebolavirus <- rentrez::entrez_fetch(db = "nucleotide",
                                          id = "NC_002549", 
                                          rettype = "fasta")


Marburg_marburgvirus_1 <- rentrez::entrez_fetch(db = "nucleotide",
                                                id = "NC_001608", 
                                                rettype = "fasta")

Marburg_marburgvirus_2 <- rentrez::entrez_fetch(db = "nucleotide",
                                                id = "NC_024781", 
                                                rettype = "fasta")


Wenling_frogfish_filovirus <- rentrez::entrez_fetch(db = "nucleotide",
                                                    id = "NC_055175", 
                                                    rettype = "fasta")

Wenling_thamnaconus_septentrionalis <- rentrez::entrez_fetch(db = "nucleotide",
                                                             id = "NC_055176", 
                                                             rettype = "fasta")

Bombali_ebolavirus <- fasta_cleaner(Bombali_ebolavirus, parse=F)

Bundibugyo_ebolavirus <- fasta_cleaner(Bundibugyo_ebolavirus, parse=F)

Reston_ebolavirus <- fasta_cleaner(Reston_ebolavirus, parse=F)

Sudan_ebolavirus <- fasta_cleaner(Sudan_ebolavirus, parse=F)

Tai_Forest_ebolavirus <- fasta_cleaner(Tai_Forest_ebolavirus, parse=F)

Zaire_ebolavirus <- fasta_cleaner(Zaire_ebolavirus, parse=F)

Marburg_marburgvirus_1 <- fasta_cleaner(Marburg_marburgvirus_1 , parse=F)

Marburg_marburgvirus_2 <- fasta_cleaner(Marburg_marburgvirus_2, parse=F)

Wenling_frogfish_filovirus <- fasta_cleaner(Wenling_frogfish_filovirus, parse=F)

Wenling_thamnaconus_septentrionalis <- fasta_cleaner(Wenling_thamnaconus_septentrionalis, parse=F)

filo_list <- list(Bombali_ebolavirus=Bombali_ebolavirus,
                  Bundibugyo_ebolavirus=Bundibugyo_ebolavirus,
                  Reston_ebolavirus=Reston_ebolavirus,
                  Sudan_ebolavirus=Sudan_ebolavirus,
                  Tai_Forest_ebolavirus=Tai_Forest_ebolavirus,
                  Zaire_ebolavirus=Zaire_ebolavirus,
                  Marburg_marburgvirus_1=Marburg_marburgvirus_1,
                  Marburg_marburgvirus_2=Marburg_marburgvirus_2,
                  Wenling_frogfish_filovirus=Wenling_frogfish_filovirus,
                  Wenling_thamnaconus_septentrionalis=Wenling_thamnaconus_septentrionalis)


#pairwise alignment 
```{r}
align_bundi_reston <- Biostrings::pairwiseAlignment(
  Bundibugyo_ebolavirus,
  Reston_ebolavirus)

align_bundi_reston

```


#pairwise sequence identity 
```{r}
Biostrings::pid(align_bundi_reston)
```

#more pairwise alignment 
```{r}
align_marburg_marburg <- Biostrings::pairwiseAlignment(
  Marburg_marburgvirus_1,
  Marburg_marburgvirus_2)

align_marburg_marburg

```
#alignment score 
score(align_marburg_marburg)

#another alignment score 
```{r}
Biostrings::pid(align_marburg_marburg)
```
a
