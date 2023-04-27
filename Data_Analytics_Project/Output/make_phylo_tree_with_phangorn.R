#reading in an alignment 
library(dplyr)
library(plotly)
library(ape)
library(phangorn)

#read in the Decipher nucleotide alignment
viruses <- read.phyDat(file = "./Data_Analytics_Project/Data/virus_align.FASTA",
                        format = "fasta")

#building the first tree with distance based methods 
dm  <- dist.ml(viruses)
saveRDS(dm, "./Data_Analytics_Project/Output/dm")
dm <- readRDS("./Data_Analytics_Project/Output/dm")
treeUPGMA  <- upgma(dm)
treeNJ  <- NJ(dm)
saveRDS(treeUPGMA, "./Data_Analytics_Project/Output/treeUPGMA")
saveRDS(treeNJ, "./Data_Analytics_Project/Output/treeNJ")
treeNJ <- readRDS("./Data_Analytics_Project/Output/treeNJ")
#plotting distance based tre
#rooted tree 
plot(treeUPGMA, main="UPGMA")
#unrooted tree 
plot(treeNJ, "unrooted", main="NJ")

#need to be cleaned up 

#plot a tree with bootstrap values 
#write a function that first makes a distance matrix and then a tree 
fun <- function(x) upgma(dist.ml(x))
bs_upgma <- bootstrap.phyDat(viruses,  fun)
saveRDS(bs_upgma, "./Data_Analytics_Project/Output/bs_upgma")
bs_upgma <- readRDS("./Data_Analytics_Project/Output/bs_upgma")
treeUPGMA <- readRDS("./Data_Analytics_Project/Output/treeUPGMA")
boot_plot_messy <- plotBS(treeUPGMA, bs_upgma, main="UPGMA")
saveRDS(boot_plot_messy, "./Data_Analytics_Project/Output/boot_plot_messy")
#seeing lots of bootstrap values of 100 which is really good!

#Parsimony 
parsimony(treeUPGMA, viruses)
#minimum number of changes required to describe the data for the UPGMA rooted tree

parsimony(treeNJ, viruses)

#find better trees to use 
treeRatchet  <- pratchet(viruses, trace = 0, minit=100)
saveRDS(treeRatchet, "./Data_Analytics_Project/Output/treeRatchet")
treeRatchet <- readRDS("./Data_Analytics_Project/Output/treeRatchet")
parsimony(treeRatchet, viruses)

treeRatchet  <- acctran(treeRatchet, viruses)
#trees can contain multifurcations
treeRatchet  <- di2multi(treeRatchet)

if(inherits(treeRatchet, "multiPhylo")){
  treeRatchet <- unique(treeRatchet)
}

scale_tree_messy <- plotBS(midpoint(treeRatchet), type="phylogram")
add.scale.bar()

#random addition tree 
treeRA <- random.addition(viruses)
#finds the optimum parsimony
treeSPR  <- optim.parsimony(treeRA, viruses)
parsimony(c(treeRA, treeSPR), viruses)


#maximum likelihood
#find best fitting model
mt <- modelTest(viruses)
saveRDS(mt, "./Data_Analytics_Project/Output/mt")

#use an optimized model to make a tree 
fit_mt <- pml_bb(mt, control = pml.control(trace = 0))
fit_mt


#task view phylogeny plotly tree thing 
#fig margins, color by taxon 


library(ggtree)
plot <- ggtree::ggtree(treeRatchet, aes(type="phylogram"))+geom_tiplab(size=1, align = F)+
  theme(plot.margin = unit(c(0,0,0,0),'mm'))+coord_cartesian(clip="on")

ggsave(filename = "./Data_Analytics_Project/Output/ggtree.png", width = 12, height=10)


table <- readr::read_csv("./Data_Analytics_Project/Data/Virus_species_and_accession_data.csv")
filo
library(dplyr)
Filos <- table %>% filter(virus_family =="Filoviridae")
Filos[,"virus_species"]
ape::zoom(treeRatchet, focus = Filos[,"virus_species"], no.margin=T, cex=.8)


library(idendr0)




plots <- ggtree(treeRatchet, aes(type='phylogram'))+
  theme(plot.margin = unit(c(0,0,0,0),'mm'))+geom_tiplab(size=1)
ggsave(gplot, filename="./Data_Analytics_Project/Output/treeattempt.png", height = 12, width = 15)



p3 <- plotly::ggplotly(plots)
p2 <- ggplotify::as.grob(plots)
p4 <- ggplotify::as.ggplot(p2)
plotly::add_annotations(p3, text = labels)

p <- ggtree(treeRatchet,color='#f2059b')

interactive_ratchet <- plotly::ggplotly(p) %>%  plotly::add_text(data = p$data[p$data$isTip, ], 
                                          x = ~x,  y = ~y,  text = ~label,  textposition = 'right')
base::saveRDS(interactive_ratchet, "./Data_Analytics_Project/Output/interactive_ratchet")









#interactive phylo trees

library(magrittr)
library(phylocanvas)
ape::write.tree(treeRatchet, file = "./Data_Analytics_Project/Output/better_tree")
better_tree <- ape::read.tree(file = "./Data_Analytics_Project/Output/better_tree")
circ_tree <- phylocanvas(better_tree, treetype='circular',
                       nodesize= 5, linewidth=1.5, 
                       textsize = 25, alignlabels = T)
circ_tree
saveRDS(circ_tree, "./Data_Analytics_Project/Output/better_circ_tree")

rect_tree <- phylocanvas(better_tree, treetype='rectangular',
                         nodesize= 5, linewidth=1.5, 
                     textsize = 13, alignlabels = F, height=2500, width=1500
                     )
rect_tree
saveRDS(rect_tree, "./Data_Analytics_Project/Output/rect_tree")
library(ggtree)

ggtree(treeRatchet) + geom_treescale()+ geom_tiplab()
write.tree()
