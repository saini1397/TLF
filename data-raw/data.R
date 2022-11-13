rm(list = ls())

file=list.files(path="data/",pattern = ".xpt")

len <- length(file)

for (i in 1:len){
  assign(str_remove(file[i],".xpt"),read.xport(paste0("data/",file[i])))
}

# Keep all ADaM into one vector.

adam_list=ls(pattern="ad")

# Get Datasets for Figure which contains PARAM/AVAL variable.
adam_listf=c()
for (i in 1:length(adam_list)){
  if ( (length( names(get(adam_list[i]))[names(get(adam_list[i])) %in% c("PARAM")]) !=0)
       )
    adam_listf[i]=adam_list[i]
}

adam_listf[!is.na(adam_listf)]


tot <- adsl  %>% group_by(TRT01A) %>% 
             summarise(tot=n_distinct(USUBJID)) 

