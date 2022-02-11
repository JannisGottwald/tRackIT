#' get Animal
#'
#' @description reads anmimal file from animal root
#'
#'
#' @author Jannis Gottwald
#'
#' @param projList list, generatet by initProject function
#' @param animalID string, label of the tagged individual
#' 
#'
#' @export
#'
#'




getAnimal = function(projList = ".", animalID){
  
  animal<-readRDS(paste0(projList$path$ids, "/",animalID, "/", animalID, "_idFile.rds"))
  return(animal)
  
}