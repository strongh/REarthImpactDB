library(ggplot2)
library(ggmap)

ggplot(map_data("world")) + geom_polygon(aes(x=long, y=lat, group = group), colour="white") +
  geom_point(data=impacts, aes(lon, lat, size=diameter), color="red")


impacts$exposed <- factor(impacts$exposed,
                          labels=c("Unexposed", "Exposed"))

ggmap(get_stamenmap(bbox, zoom = 3, maptype="toner"), extent = "device") +
  geom_point(data=impacts,
             alpha=0.5,
             aes(lon, lat, size=diameter, colour=exposed)) +
  geom_point(data=impacts,
             aes(lon, lat, colour=exposed), size=1/2) +
  labs(size="Diameter (km)", colour="") +
  scale_colour_brewer(palette = "Set1")
