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
db = "nucleotide"
rettype = "fasta"

#try it with just one virus at first to get it figured out 
#I can recall viruses in the NCBI database by accession number
#ebola viruses are a member of the family filoviridae
#luckily I have my data (accession numbers) saved by family 

#Im going to get my filoviridae accession list really quick

filo <- readr:: read_lines(file="./Data_Analytics_Project/Data/Filoviridae.acc_lst")
filo

#here it is 
retmax_set=1

#ok then I am just going to select an accession number Ill choose the first one 
#its for Lloviu cuevavirus but we dont really need to know that yet 
#just going to copy and paste in the accession
#Lloviu_cuevavirus1 <- rentrez::entrez_fetch(db = "protein", 
 #                                 id = "NC_016144", 
  #                                rettype = "fasta")
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

Bundibugyo_ebolavirus <- fasta_cleaner(Bundibugyo_ebolavirus, parse=F)

Reston_ebolavirus <- fasta_cleaner(Reston_ebolavirus, parse=F)

#I know I can do this witha forloop later but I first want to do it all the long way
#so I know that it is working right 

Sudan_ebolavirus <- fasta_cleaner(Sudan_ebolavirus, parse=F)


Tai_Forest_ebolavirus <- fasta_cleaner(Tai_Forest_ebolavirus, parse=F)



Zaire_ebolavirus <- fasta_cleaner(Zaire_ebolavirus, parse=F)



Marburg_marburgvirus_1 <- fasta_cleaner(Marburg_marburgvirus_1 , parse=F)



Marburg_marburgvirus_2 <- fasta_cleaner(Marburg_marburgvirus_2, parse=F)



Wenling_frogfish_filovirus <- fasta_cleaner(Wenling_frogfish_filovirus, parse=F)

Wenling_thamnaconus_septentrionalis <- fasta_cleaner(Wenling_thamnaconus_septentrionalis, parse=F)
#bam header is removed and it is just sequence data 


#in the future i will make these into a named list so i have the sequence data 
#and name all in one place that i can have fun with 

#a peek at my sequence data 

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

filo_list


#now I can access the sequences like this 
filo_list$Bombali_ebolavirus



#pretty cool 



#do a pairwise alignment of the sequences using biostrings
align_bundi_reston <- Biostrings::pairwiseAlignment(
 Bundibugyo_ebolavirus,
 Reston_ebolavirus)


#lets have a look at the alignment
align_bundi_reston 

#the score is negative... this means in general 
#that the sequences are not very similar 
#but we can look farther into this 
#we would want to use percent sequence identity (PID)
#also from the biostrings package 

#pid 
Biostrings::pid(align_bundi_reston)

#so bundibugyo and reston ebolavirues have 63% nucleotide sequence identity


#lets have a look at more similar viruses... how about the marburg viruses
align_marburg_marburg <- Biostrings::pairwiseAlignment(
 Marburg_marburgvirus_1,
  Marburg_marburgvirus_2)

align_marburg_marburg

#a much higher score means have a higher percent of their genomes 
#in common 

#use pid 
Biostrings::pid(align_marburg_marburg)

#it appears they share 79 percent of their genome 

#if we just want the score of the alignment without all the other crap
#and having to run such a heavy program we can use 
#score 


score(align_marburg_marburg)
score(align_bundi_reston)


#I can do multiple sequences at once as well (or at least read them into r)
#and make them into a list with a function in combio4all

#luckily for me I have files of all the accession numbers I just need to read 
#them in and make them a single vector which is basically all of the 
#cleaning i need to do!

#remember how my filoviruse accession numbers were contained in this variable....
filo
#its a character vector which is what I want 

#so if i did 
filos <- entrez_fetch(db = "nucleotide", 
             id = filo, 
             rettype = "fasta")
cat(filos)
#I get all the genomes for the filoviruses 

#now we have a single very long set of data
#this isn't super useable for R and coding 
#lets try a new function 

#this function allows me to download a bunch of fasta files and put them in
#a list 

filo_fasta_list <- entrez_fetch_list(db = "nucleotide", 
                                  id = filo, 
                                  rettype = "fasta")
#if we have a look at it 
filo_fasta_list


#pretty amazing right!!
#i just did that in like 5 minutes (thank you sucky computer)

#so this means if I wanted allllll the genomes for allllll my viruses of interest....


art <- readr::read_lines("./Data_Analytics_Project/Data/Artoviridae.acc_lst")
list1 <- c(art, filo)

born <- readr::read_lines("./Data_Analytics_Project/Data/Bornaviridae.acc_lst")
list2 <- c(list1,born)

lisp <- readr::read_lines("./Data_Analytics_Project/Data/Lispiviridae.acc_lst")
list3 <- c(list2,lisp)

mym <- readr::read_lines("./Data_Analytics_Project/Data/Mymonaviridae.acc_lst")


nyan <- readr::read_lines("./Data_Analytics_Project/Data/Nyamiviridae.acc_lst")


para <- readr::read_lines("./Data_Analytics_Project/Data/Paramyxoviridae.acc_lst")

pneu <- readr::read_lines("./Data_Analytics_Project/Data/Pneumoviridae .acc_lst")
sun <- readr::read_lines("./Data_Analytics_Project/Data/Sunshinevirus.acc_lst")
xin <- readr::read_lines("./Data_Analytics_Project/Data/Xinmoviridae.acc_lst")


virus_list <- c(mym,list3,nyan,para,pneu,sun,xin)
write.table(virus_list, file="./Data_Analytics_Project/Data/virus_accessions.csv", row.names = FALSE, col.names = "accession number")


#and so we make a list of sequences with all of my accessions 
library(biomaRt)

virus_fasta_list <- entrez_fetch_list(db = "nucleotide", 
                                     id =virus_list, 
                                     rettype = "fasta")


write.fasta(sequences = virus_fasta_list, names = names(virus_fasta_list), file.out = "./Data_Analytics_Project/Data/virus_genomes.FASTA")
#boom here is my fasta of all my virus genomes 
