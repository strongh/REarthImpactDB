library(rvest)

db.base <- "http://www.passc.net/EarthImpactDatabase/"
db.url <- "http://www.passc.net/EarthImpactDatabase/Namesort.html"

db.page <- read_html(db.url)

impact.anchors <- db.page %>% 
  html_nodes("table") %>% .[[3]] %>% html_nodes("a") %>%  html_attr("href")

anchors <- c()

for (i in strsplit(impact.anchors, "/")){
  anchors <- c(anchors, i[length(i)])
}

## sleep so that we don't both the impact servers
impact.page <- NULL

impact.df <- impact.page %>% html_table(fill=TRUE, header=TRUE) %>% .[[3]]

for (p in anchors[(nrow(impact.df)+1):length(anchors)]){
  Sys.sleep(1)
  page.url <- paste0(db.base, "/", p)
  impact.page <- read_html(page.url)  
  p.impact <- impact.page %>% html_table(fill=TRUE, header=TRUE) %>% .[[3]]
  names(p.impact) <- names(impact.df)
  impact.df <- rbind(impact.df, p.impact)
}

write.csv(impact.df, "raw.csv", row.names = FALSE)

