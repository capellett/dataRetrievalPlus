## North Carolina Stream gauges in the Pee Dee basin
## Name, Location, Period of Record
library(tidyverse)


NCPD_sites <- surfaceSites %>%
  dplyr::filter(state_nm=='NC' & stringr::str_sub(huc_cd, 1, 4)=='0304')

flow_and_stage_sites <- site_catalog %>%
  dplyr::filter(parameter_group_nm=='Physical') %>%
  dplyr::semi_join(NCPD_sites, 'site_no') %>%
  dplyr::filter(parameter_nm %in% c("Stream water level elevation above NAVD 1988, in feet",
                                    "Gage height, above datum, meters",
                                    "Discharge, instantaneous, cubic feet per second",
                                    "Discharge, cubic feet per second")) %>%
  dplyr::filter(stat_name=='MEAN') %>%
  dplyr::select(site_no, station_nm, lat, lng, begin_date, end_date,
                parameter_nm, parm_cd, stat_cd, stat_name, huc_cd,  dec_coord_datum_cd)

write.csv(flow_and_stage_sites, 'NC PeeDee Streamflow Sites.csv')
