#creating msa alignment 
virus_align_seqinr <- msaConvert(virus_align,
type = "seqinr::alignment")

#ggmsa sequence alignment 
ggmsa::ggmsa(virus_align, start = 100, end = 200)