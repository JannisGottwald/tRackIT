#' Init radio-tracking project
#'
#' @description Creates directories and a R list with all the needed tRackIT-Project information. R list is stored as .rds in projroot directory-projroot/projID_idFile.rds
#'
#'
#' @author Jannis Gottwald
#'
#' @param projroot string, project directory
#' @param tags data.frame, table containing all relevant information of tagged individuals
#' @param id_col string, name of the column in tags data.frame containing the name (ID) of the tagged individual 
#' @param spec_col string, name of the column in tags data.fram containing the species of the tagged individual 
#' @param sex_col string, name of the column in tags data.frame containing the sex of the tagged individual 
#' @param age_col string, name of the column in tags data.frame containing the age of the tagged individual 
#' @param weight_col string, name of the column in tags data.frame containing the weight of the tagged individual
#' @param rep_col string, name of the column in tags data.frame containing the reproductive state of the tagged individual 
#' @param start_col string, name of the column in tags data.frame containing the species of the tagged individual
#' @param start_col string, name of the column in tags data.frame containing the date of the tagging (yy-mm-dd)
#' @param end_col string, name of the column in tags data.frame containing the end of the transmitter lifetime (yy-mm-dd)
#' @param freq_col string, name of the column in tags data.frame containing the frequency of the transmitter in kHz
#' @param dmin_col string, name of the column in tags data.frame containing the min duration of the transmitter signal in seconds (10ms=0.01 sec)
#' @param dmax_col string, name of the column in tags data.frame containing the max duration of the transmitter signal in seconds (10ms=0.01 sec)
#' @param logger_data_raw string, path to the full RTS dataset
#' @param stations data.frame, with station coordinates, station name, receiver name and antenna orientation
#' @param s_col string, name of the column in tags data.frame containing the name of each station
#' @param r_col string, name of the column in tags data.frame containing the name of each receiver
#' @param x_col string, name of the column in tags data.frame containing the X Coordinates
#' @param y_col string, name of the column in tags data.frame containing the Y Coordinates
#' @param o_col string, name of the column in tags data.frame containing the orientation of antennas
#' @param epsg numeric, epsg code of the coordinate system of stations coordinates- will be transformed to latlon
#' @param tz string, timezone of project
#' @param dmax_col string, name of the column in tags data.frame containing the max duration of the transmitter signal in seconds (10ms=0.01 sec)
#' 
#'
#' @export
#'
#'




initProject = function(projroot = ".",
                       logger_data_raw,
                       tags,
                       id_col=NULL,
                       spec_col=NULL,
                       sex_col=NULL,
                       age_col=NULL,
                       weight_col=NULL,
                       rep_col=NULL,
                       start_col=NULL, 
                       end_col=NULL,
                       freq_col=NULL,
                       dmin_col=NULL,
                       dmax_col=NULL,
                       stations,
                       s_col,
                       x_col,
                       y_col,
                       r_col,
                       o_col,
                       epsg,
                       tz){

  rtRoot(projroot)
  # create project sturture
  dir.create(paste0(projroot, "data/catalogues/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "data/logger_data_csv/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/data/reference_data/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/data/calibration_curves/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/data/correction_values/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/data/individuals/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/data/batch_awk"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/data/param_lst"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/data/models"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/R/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "/results/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "R/scripts/"), showWarnings = FALSE)
  dir.create(paste0(projroot, "R/fun/"), showWarnings = FALSE)
  # save meta data
 
  # get paths
  path = list(raw= logger_data_raw,
              catalogues = paste0(projroot, "data/catalogues/"),
              csv = paste0(projroot, "data/logger_data_csv/"),
              ref= paste0(projroot, "/data/reference_data/"),
              c_Curves= paste0(projroot, "/data/calibration_curves/"),
              correction = paste0(projroot, "/data/correction_values/"),
              ids= paste0(projroot, "/data/individuals/"),
              awk=paste0(projroot, "/data/batch_awk/"),
              param_lst=paste0(projroot, "/data/param_lst"),
              models=paste0(projroot, "/data/models/"),
              fun=paste0(projroot, "/R/fun/"),
              results=paste0(projroot, "/results/")
              )
  
  tags<-as.data.frame(tags)

  tag_data=data.frame(ID=tags[,id_col], species=tags[, spec_col], sex=tags[, sex_col], age=tags[,age_col], weight=tags[, weight_col], rep.state=tags[, rep_col], start=tags[, start_col], end=tags[, end_col], frequency=tags[,freq_col], duration_min=tags[, dmin_col],duration_max=tags[,dmax_col])
  
  
  nms<-c("ID","species","sex" ,"age","weight","rep.state","start","end","frequency" ,"duration_min", "duration_max")
  nms_missing<-nms[which(!(nms%in%names(tag_data)))]
  
  for(n in nms_missing){
    
    tag_data[,n]<-NA
  }
  
  stations<-as.data.frame(stations)
  
                  
  
  stations<-data.frame(station=stations[, s_col], X=stations[, x_col], Y=stations[, y_col], receiver=stations[, r_col],orientation=stations[, o_col])
  
  sp::coordinates(stations) <- c("X", "Y")
  sp::proj4string(stations)<-sp::CRS(paste0("+init=epsg:",epsg))
  
  stations<-sp::spTransform(stations,sp::CRS(paste0("+init=epsg:",4326)))
  
  print(mapview::mapview(stations))
  
  stations<-as.data.frame(stations)
  

  
  for(n in nms_missing){
    
    tags[,n]<-NA
  }
  

  project = list(path = path,tags=tag_data, stations=stations, epsg=epsg, tz=tz)
  
  
  
  
  
  saveRDS(project, paste0(projroot, "/", basename(projroot), "_projectFile.rds"))
  
 
  
  

  return(project)

}



