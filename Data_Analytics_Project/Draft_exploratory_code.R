#making a phylogenetic tree with viral genome sequences from NCBI

#phylogenies are very important for viral studies especially concerning viral
#evolution of potentially life threatening diseases. 

#a few packages I need to construct my phylogeny
#(and acquire the correct data from NCBI)

#CRAN Packages
library(ape)
library(seqinr)
library(rentrez)
library(devtools)

#Bioconductor packages 
library(msa)
library(Biostrings)

#github packages
library(compbio4all)
library(ggmsa)



#use entrez to explore sequences from NCBI database
#protein database first 

#i am also going to do nucleotide and genome later
#proteins are good because you can run BLAST etc on them
#viral proteins are very important to understand because they are the means
#of how the virus effects the host, replicates, etc. 
#without proteins viruses would just be sitting ducks 
#literally they would do nothing 
#viruses exist to make proteins
#the proteins they create are what make viruses royally suck
#the whole point of a viral genome is to make protein!!

#set up some settings
db = "protein"
rettype = "fasta"

#try it with just one virus at first to get it figured out 
#I can recall viruses in the NCBI database by accession number
#ebola viruses are a member of the family filoviridae
#luckily I have my data (accession numbers) saved by family 

#Im going to get my filoviridae accession list really quick

filo <- read_lines(file="./Data_Analytics_Project/Data/Filoviridae.acc_lst")
filo
#here it is 
retmax_set=1

#ok then I am just going to select an accession number Ill choose the first one 
#its for Lloviu cuevavirus but we dont really need to know that yet 
#just going to copy and paste in the accession
#Lloviu_cuevavirus <- rentrez::entrez_fetch(db = "protein", 
                                 # id = "NC_016144.", 
                                  #rettype = "fasta")
#hmmm giving me an error grumble

#how about genome 
Lloviu_cuevavirus<- rentrez::entrez_fetch(db = "nucleotide",
                            id = "NC_016144", 
                             rettype = "fasta")
#ok so nucleotide works!
#dont know what the deal is with protein, 
#some people say come back and rerun later

#cat function does formatting 
cat(Lloviu_cuevavirus)

#beautiful and the complete genome 

#do this for the rest of the filoviruses 
Mengla_dianlovirus <- rentrez::entrez_fetch(db = "nucleotide",
                                          id = "NC_055510", 
                                          rettype = "fasta")
filo

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
filo

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

#use function to make the fastas useable

Bombali_ebolavirus <- fasta_cleaner(Bombali_ebolavirus, parse=F)

#bam header is removed and it is just sequence data 
