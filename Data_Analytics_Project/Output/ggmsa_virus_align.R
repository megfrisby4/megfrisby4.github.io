

library(ggmsa)
virus_align2 <- readRDS("./Data_Analytics_Project/Output/virus_align2")
virus_align2
seq_plot <- ggmsa(virus_align2, start = 490, end = 550, char_width = 0.5, seq_name = F) + geom_seqlogo() + geom_msaBar()



