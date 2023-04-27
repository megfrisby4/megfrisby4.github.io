library(dplyr)
library(plotly)
library(ape)
library(phangorn)
library(ggtree)
library(magrittr)
library(phylocanvas)

#read in the Decipher nucleotide alignment
virus_align<- read.phyDat(file = "./Data_Analytics_Project/Data/virus_align.FASTA",
                       format = "fasta")
treeRatchet <- readRDS("./Data_Analytics_Project/Output/treeRatchet")
parsimony(treeRatchet, virus_align)

treeRatchet  <- acctran(treeRatchet, virus_align)
#trees can contain multifurcations
treeRatchet  <- di2multi(treeRatchet)

if(inherits(treeRatchet, "multiPhylo")){
  treeRatchet <- unique(treeRatchet)
}

saveRDS(treeRatchet, "./Data_Analytics_Project/Output/treeRatchet")

scale_tree_messy <- plotBS(midpoint(treeRatchet), type="phylogram")
add.scale.bar()

#tree Ratchet is a list of trees 
#changed viruses to virus_align 

#random addition tree 
treeRA <- random.addition(virus_align)
treeSPR  <- optim.parsimony(treeRA, virus_align)
parsimony(c(treeRA, treeSPR), virus_align)
#it appears treeSPR is slightly better 


#maximum likelihood approach 
#select the best fitting model 

#mt <- modelTest(viruses)
mt <- readRDS("./Data_Analytics_Project/Output/mt")
mt


#use the model to make a tree 
#the function pml_bb optimizes the parameters by selecting the best model
#generated with the function modelTest
#bootstrapping is conducted by default 

fit_mt <- pml_bb(mt, control = pml.control(trace = 0))
fit_mt
saveRDS(fit_mt, "./Data_Analytics_Project/Output/fit_mt")
fit_mt <- readRDS("./Data_Analytics_Project/Output/fit_mt")

plotBS(midpoint(fit_mt$tree), p = .5, type="p", digits=2, main="Ultrafast bootstrap")
ggtree::ggtree(midpoint(fit_mt$tree))+geom_tiplab()

#fit_mt$tree most representative tree
#ultrafast bootstrapping 
write.tree(fit_mt$tree, file = "./Data_Analytics_Project/Output/fit_mt_tree")
 boot_fit_mt_tree <- ggtree(fit_mt$tree) + 
  geom_tiplab(align=F, color='#609ECF', linesize=.5) + 
  hexpand(.3) +
  labs(title = 'x') + 
   geom_nodelab(label=fit_mt$tree$node.label, color = '#609ECF' )
ggsave("./Data_Analytics_Project/Output/boot_fit_mt_tree.png", height= 15, width = 20)

