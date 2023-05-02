library(dplyr)
library(plotly)
library(ape)
library(phangorn)
library(ggtree)
library(magrittr)
library(phylocanvas)

#read in the Decipher nucleotide alignment
viruses<- read.phyDat(file = "./Data_Analytics_Project/Data/virus_align.FASTA",
                       format = "fasta")
treeRatchet <- readRDS("./Data_Analytics_Project/Output/treeRatchet")
parsimony(treeRatchet, viruses)

treeRatchet  <- acctran(treeRatchet, viruses)
#trees can contain multifurcations
treeRatchet  <- di2multi(treeRatchet)

if(inherits(treeRatchet, "multiPhylo")){
  treeRatchet <- unique(treeRatchet)
}

saveRDS(treeRatchet, "./Data_Analytics_Project/Output/treeRatchet")

scale_tree_messy <- plotBS(midpoint(treeRatchet), type="phylogram")
add.scale.bar()

#tree Ratchet is a list of trees 
#changed viruses to viruses 

#random addition tree 
treeRA <- random.addition(viruses)
treeSPR  <- optim.parsimony(treeRA, viruses)
parsimony(c(treeRA, treeSPR), viruses)
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
 boot_fit_mt_tree <- ggtree(fit_mt$tree, linewidth=.5) + 
  geom_tiplab(align=F, color="#f2059b", linesize=.5) + 
  hexpand(.3) +
  labs(title = 'Phylogenetic Tree With Ultrafast Bootstrapping',element_text(size=15)) + 
   geom_nodelab(label=fit_mt$tree$node.label, color = 'blue', size =5)
ggsave("./Data_Analytics_Project/Output/boot_fit_mt_tree.png", height=25 , width = 20)
ggsave("./Data_Analytics_Project/boot_fit_mt_tree.jpg", height=28, width=20)

ggtree(fit_mt$tree, right=TRUE) +
  geom_tippoint(aes(color=df$virus_family), size=3, alpha=.75) +
  scale_color_brewer("virus_family", palette="Spectral") +
  theme_tree2(legend.position='right')

fit_mt$tree

phylocanvas_circular <- phylocanvas::phylocanvas(fit_mt$tree, treetype = "circular", linewidth = 1,
                         nodesize = 5, alignlabels = F, textsize = 15, 
                         width = 1000, height = 850)
saveRDS(phylocanvas_circular, "./Data_Analytics_Project/Output/phylocanvas_circular")
phylo_diagonal <- phylocanvas::phylocanvas(fit_mt$tree, treetype = "diagonal", linewidth = 0.5,
                         nodesize = 3, alignlabels = TRUE, textsize = 10, height = 800, width=800)
saveRDS(phylo_diagonal, "./Data_Analytics_Project/Output/phylo_diagonal")
phylo_radial <- phylocanvas::phylocanvas(fit_mt$tree, treetype = "radial", linewidth = 0.33,
                         nodesize = 3, alignlabels = TRUE, textsize = 12, height = 800, width=800)
saveRDS(phylo_radial, "./Data_Analytics_Project/Output/phylo_radial")
library(idendr0)
idendr0::idendro()
?idendro
idendro(fit_mt$tree)
library(phytools)
phangorn::nnls.phylo(fit_mt$tree, )

idendro(ultra_tree)
dendro <- chronos(tree)
dendro <- root(dendro, outgroup = 1)
dendro
root_tree <- ape::root.phylo(fit_mt$tree, outgroup = fit_mt$tree$tip.label, node = 221)
idendro(root_tree)
ultra_tree <- nnls.phylo(root_tree, dm=dm)
root_tree <- ultra_tree %>% root(outgroup=fit_mt$tree$tip.label, node = 222, resolve.root = T)


library(Biostrings)
        library(ggmsa)
virus_seq <- virus_align2

ggmsa(virus_seq, start = 2060, end = 3000)
ggsave("./Data_Analytics_Project/Output/align_plot", height = 2000, width = 500)





