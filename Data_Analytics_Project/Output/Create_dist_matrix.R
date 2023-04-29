#creating genetic distance matrix using decipher
virus_ss <- readRDS("./Data_Analytics_Project/Output/virus_string_set")
virus_dist <- DECIPHER::DistanceMatrix(virus_string_set,
 type = "matrix")
virus_dist <- as.dist(virus_dist)
saveRDS(virus_dist, "./Data_Analytics_Project/Output/virus_dist")
#round the distances 
virus_dist <- readRDS("./Data_Analytics_Project/Output/virus_dist")
virus_dist_rounded <- round(virus_dist, digits=3)
virus_dist_rounded
saveRDS(virus_dist_rounded, "./Data_Analytics_Project/Output/virus_dist_rounded")
#use neignbor join method to make tree 
#not rounded 
treeNJ <- nj(virus_dist)
saveRDS(treeNJ, "./Data_Analytics_Project/Output/treeNJ")


virus_dist <- DECIPHER::DistanceMatrix(virus_align, type='matrix')
saveRDS(virus_dist, "./Data_Analytics_Project/Output/virus_dist")
library(phylocanvas)
treenj_canvas <- phylocanvas(treeNJ, treetype = "rectangular", nodesize = 5, 
                         linewidth = 0.3, textsize = 15, alignlabels = T, , height=800, width = 1000) 
saveRDS(treenj_canvas,"./Data_Analytics_Project/Output/treenj_canvas")


ggtree_treenj <- ggtree(treeNJ, layout="rectangular")+geom_tiplab(size = 1)+xlim(0,.4)
ggsave(filename="./Data_Analytics_Project/plot_nj.png", height = 12, width = 8)

ggtree(treeNJ) +
  theme_tree2() + geom_tiplab(size=2)

ggtree(treeNJ) +
  geom_tiplab(align=TRUE, linesize=.5, size = 2) + xlim(0,1)
ggsave(filename="./Data_Analytics_Project/plot_nj.png", height = 14, width = 8)
