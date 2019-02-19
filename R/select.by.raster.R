### Select value using date raster
select.by.raster <- function(x, d_v) {
  
  if(is.na(x[1])|is.na(x[length(x)])) {
    
    rep(NA, 18)
    
  } else {
    
    j <- x[length(x)]
    n <- (length(x)-1)
    i <- n/18
    
    out <- x[(18*(j-1)+1):(18*(j))]
    
    if(sum(is.na(out))!=0) {
      
      return(rep(NA, 18))
      
    } else {
      
      return(out)
      
    }
    
  }
  
}