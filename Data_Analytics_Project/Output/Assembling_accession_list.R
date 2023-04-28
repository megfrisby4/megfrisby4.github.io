
#code to assemble list of accessions 
#remember why you chose the families that you did 
filo <- readr::read_lines("./Data_Analytics_Project/Data/Filoviridae.acc_lst")
art <- readr::read_lines("./Data_Analytics_Project/Data/Artoviridae.acc_lst")
born <- readr::read_lines("./Data_Analytics_Project/Data/Bornaviridae.acc_lst")
lisp <- readr::read_lines("./Data_Analytics_Project/Data/Lispiviridae.acc_lst")
mym <- readr::read_lines("./Data_Analytics_Project/Data/Mymonaviridae.acc_lst")
nyan <- readr::read_lines("./Data_Analytics_Project/Data/Nyamiviridae.acc_lst")
para <- readr::read_lines("./Data_Analytics_Project/Data/Paramyxoviridae.acc_lst")
pneu <- readr::read_lines("./Data_Analytics_Project/Data/Pneumoviridae .acc_lst")
sun <- readr::read_lines("./Data_Analytics_Project/Data/Sunshinevirus.acc_lst")
xin <- readr::read_lines("./Data_Analytics_Project/Data/Xinmoviridae.acc_lst")
rhab <- readr::read_lines("./Data_Analytics_Project/Data/rhabdovirus.acc_lst")
virus_list <- c(filo,art,born,lisp,mym,nyan,para,pneu,sun,xin,rhab)
virus_list
saveRDS(virus_list, './Data_Analytics_Project/Output/virus_accession_vector')
