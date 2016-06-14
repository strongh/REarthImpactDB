library(stringr)
raw.impacts <- read.csv("raw.csv")


impacts <- data.frame(crater.name=raw.impacts$Crater.Name)


clean.coord <- function(coord, pos.char){
  coord.info <- str_split_fixed(coord, " |°", 3) 
  coords <- coord.info[, 2:3] %>% 
    str_replace_all("'|\"", "") %>% str_trim() %>% 
    str_extract( "[0-9]*")  %>% as.numeric() %>% matrix(nrow=nrow(coord.info))
  ifelse(coord.info[,1]==pos.char, 1, -1)*(coords[,1] + coords[,2]/60)
}

impacts$lat <- clean.coord(raw.impacts$Latitude, "N")
impacts$lon <- clean.coord(raw.impacts$Longitude, "E")
impacts$diameter <- raw.impacts$Diameter..km. %>%
  str_extract( "[0-9][.0-9]*") %>% as.numeric()

impacts$exposed <- raw.impacts$Exposed=="Y"
head(impacts)

## TODO add other columns
write.csv(impacts, "impacts.csv", row.names = FALSE)