#' Init Animal Tracking
#'
#' @description Creates directories and a R list with all the needed tRackIT information for one animal. R list is stored as .rds in animals directory-projroot/data/individuals/animalID/animalID_idFile.rds
#'
#'
#' @author Marvin Ludwig & Jannis Gottwald
#'
#'
#' @param projList list, generatet by initProject function
#' @param animalID string, label of the tagged individual
#' @param species string, species of the tagged individual
#' @param sex string, sex of the tagged individual
#' @param age string, age of the tagged individual
#' @param weight string, weight of the tagged individual
#' @param rep.state string, reproductive state of the tagged individual
#' @param freq num, tag frequency (khz)
#' @param start string, start of tracking YYYY-MM-DD
#' @param end string, end of tracking YYYY-MM-DD
#' @param duration_min numeric, minimum duration of single signal
#' @param duration_max numeric, maximum duration of single signal
#'
#' @export
#'
#'




initAnimal = function(projList,
                      saveAnml=FALSE,
                      animalID,
                      species=NA,
                      sex=NA,
                      age=NA,
                      weight=NA,
                      rep.state=NA,
                      freq=NA,
                      start=NA,
                      end=NA, 
                      duration_min=NA,
                      duration_max=NA
){

  # create project sturture
  dir.create(paste0(projList$path$ids, animalID), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/filtered_awk"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/filtered"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/logger_timematch"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/station_timematch"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/imputed"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/calibrated"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/gps_timematch"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/bearings"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/triangulations"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/variables"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/bearings_filtered"), showWarnings = FALSE)
  dir.create(paste0(projList$path$ids, animalID, "/classification"), showWarnings = FALSE)

  # save meta data
        meta = list(animalID = as.character(animalID),
                    species=as.character(species),
                    sex=as.character(sex),
                    age=as.character(age),
                    weight=as.character(weight),
                    rep.state=as.character(rep.state),
                    freq = as.character(freq),
                    start = as.character(start),
                    end = as.character(end),
                    duration_min=as.character(duration_min),
                    duration_max=as.character(duration_max)
                    )
  

  
  
  # get paths
  path = list(raw = projList$path$csv,
              root = paste0(projList$path$ids, "/",animalID),
              filtered_awk=paste0(projList$path$ids, animalID, "/filtered_awk/"),
              filtered=paste0(projList$path$ids, animalID, "/filtered/"),
              logger_timematch=paste0(projList$path$ids, animalID, "/logger_timematch/"),
              station_timematch=paste0(projList$path$ids, animalID, "/station_timematch/"),
              imputed=paste0(projList$path$ids, animalID, "/imputed/"),
              calibrated=paste0(projList$path$ids, animalID, "/calibrated/"),
              gps_matched=paste0(projList$path$ids, animalID, "/gps_timematch/"),
              bearings=paste0(projList$path$ids, animalID, "/bearings/"),
              triangulations=paste0(projList$path$ids, animalID, "/triangulations/"),
              vars=paste0(projList$path$ids, animalID, "/variables/"),
              bearings_filtered=paste0(projList$path$ids, animalID, "/bearings_filtered/"),
              classification=paste0(projList$path$ids, animalID, "/classification/")
              )

  animal = list(meta = meta,
                path = path)
  
  if(saveAnml==TRUE){
  saveRDS(animal, paste0(projList$path$ids, "/",animalID, "/", animalID, "_idFile.rds"))}

  return(animal)

}



