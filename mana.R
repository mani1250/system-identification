idfrme <- function(output=NULL,input=NULL,Ts = 1,start=0,end=NULL, 
                    unit = c("seconds","minutes","hours",
                             "days")[1]){
  l <- list(output,input)
  l2 <- lapply(l,data.frame)
  n <- dim(l2[[1]])
  
  if(!is.null(end)){
    start <- end - Ts*(n-1)
  } 
  
  l3 <- lapply(l2,ts,start=start,deltat=Ts)
  
  # Object Constructor
  dat <- list(output=l3[[1]],input=l3[[2]],unit=unit)
  class(dat) <- "idframe"
  return(dat)}