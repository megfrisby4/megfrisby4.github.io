
#code to assemble list of accessions 
#remember why you chose the families that you did 
filo <- readr::read_lines("./Data/Filoviridae.acc_lst")
art <- readr::read_lines("./Data/Artoviridae.acc_lst")
born <- readr::read_lines("./Data/Bornaviridae.acc_lst")
lisp <- readr::read_lines("./Data/Lispiviridae.acc_lst")
mym <- readr::read_lines("./Data/Mymonaviridae.acc_lst")
nyan <- readr::read_lines("./Data/Nyamiviridae.acc_lst")
para <- readr::read_lines("./Data/Paramyxoviridae.acc_lst")
pneu <- readr::read_lines("./Data/Pneumoviridae .acc_lst")
sun <- readr::read_lines("./Data/Sunshinevirus.acc_lst")
xin <- readr::read_lines("./Data/Xinmoviridae.acc_lst")
rhab <- readr::read_lines("./Data/rhabdovirus.acc_lst")
virus_list <- c(filo,art,born,lisp,mym,nyan,para,pneu,sun,xin,rhab)
virus_list