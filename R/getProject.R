#' get radio-tracking project
#'
#' @description reads project file from projroot
#'
#'
#' @author Jannis Gottwald
#'
#' @param projroot string, project directory
#' @param plot logical, if TRUE a map with stations will be plottet
#' 
#'
#' @export
#'
#'




getProject = function(projroot = ".", plot=FALSE){
  
  project<-readRDS(paste0(projroot,basename(projroot) ,"_projectFile.rds"))
  
  if(plot==TRUE){
    stations<-project$stations
    epsg<-project$epsg
    sp::coordinates(stations) <- c("X", "Y")
    sp::proj4string(stations)<-sp::CRS(paste0("+init=epsg:",epsg))

    print(mapview::mapview(stations))
    
  }
  
  
  return(project)
  
}



