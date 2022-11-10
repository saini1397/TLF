rm(list = ls())



file=list.files(path="data/",pattern = ".xpt")

len <- length(file)

for (i in 1:len){
  assign(str_remove(file[i],".xpt"),read.xport(paste0("data/",file[i])))
}

# Keep all ADaM into one vector.

adam_list=ls(pattern="ad")
