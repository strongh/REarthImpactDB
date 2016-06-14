library(ggplot2)
library(ggmap)

ggplot(map_data("world")) + geom_polygon(aes(x=long, y=lat, group = group), colour="white") +
  geom_point(data=impacts, aes(lon, lat, size=diameter), color="red")


ggmap(get_stamenmap(bbox, zoom = 3, maptype="toner"), extent = "device") +
  geom_point(data=impacts,
             aes(lon, lat, size=diameter,
                           alpha=0.2,
                           colour=factor(exposed,
                                         labels=c("Unexposed", "Exposed")))) +
  labs(size="Diameter (km)", colour="") +
  scale_colour_brewer(palette = "Set1")
