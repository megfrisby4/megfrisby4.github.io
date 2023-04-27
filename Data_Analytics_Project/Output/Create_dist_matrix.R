#creating genetic distance matrix using decipher
virus_string_set <- readRDS("./Data_Analytics_Project/Output/virus_string_set")
virus_dist <- DECIPHER::DistanceMatrix(virus_string_set,
 type = "matrix")
virus_dist <- as.dist(virus_dist)
saveRDS(virus_dist, "./Data_Analytics_Project/Output/virus_dist")
#round the distances 
virus_dist <- readRDS("./Data_Analytics_Project/Output/virus_dist")
virus_dist_rounded <- round(virus_dist, digits=3)
virus_dist_rounded

#use neignbor join method to make tree 
#not rounded 
treeNJ <- nj(virus_dist)
saveRDS(treeNJ, "./Data_Analytics_Project/Output/treeNJ")


