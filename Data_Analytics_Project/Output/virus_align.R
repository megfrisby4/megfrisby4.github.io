virus_vector_ss <- readRDS("./Data_Analytics_Project/Output/virus_string_set")
class(virus_vector_ss)
#rather than 
virus_align <- msa(virus_vector_ss,
                   method = "ClustalW")
#more noteable
virus_align <- DECIPHER::AlignSeqs(virus_vector_ss)
saveRDS(virus_align,"./Data_Analytics_Project/Output/virus_align")


virus_multiple_align <- DNAMultipleAlignment(virus_align)
saveRDS(virus_align2,"./Data_Analytics_Project/Output/virus_align2")

virus_align <- readRDS("./Data_Analytics_Project/Output/virus_align")
virus_phylo_tree <- DECIPHER::TreeLine(virus_align)


#phanghorn:: package 


#plotting phylogenies 
#ggtree::
#ape::


#CRAN task view

#chat gpt 
#curl "url"
#/> whatever.html
#wget - gets any file from the internet -- put in location to the file 
#can do recursive 2,3,4,5,6 links 
#recursive -r -l 2 http://whatevertheurlis
