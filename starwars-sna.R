library("rjson")
library("igraph")

json_file <- "C:/Users/M/Desktop/SNA/sw.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

nodes <- data.frame()
for(i in 1:length(json_data$nodes)) {
  nodes[i,"name"] <- json_data$nodes[[i]]$name
  nodes[i,"value"] <- json_data$nodes[[i]]$value
}

edges <- data.frame()
for(i in 1:length(json_data$links)) {
  edges[i,"source"] <- nodes$name[json_data$links[[i]]$source+1]
  edges[i,"target"] <- nodes$name[json_data$links[[i]]$target+1]
  edges[i,"weight"] <- json_data$links[[i]]$value
}

g <- graph_from_data_frame(d=edges, vertices=nodes, directed=FALSE)

graph.density(g)

transitivity(g)

first_order <- c("SNOKE", "COLONEL DATOO", "GENERAL HUX", 
                 "LIEUTENANT MITAKA", "KYLO REN", "CAPTAIN PHASMA",
                 "COLONEL DATOO")

neutral <- c("UNKAR PLUTT", "BALA-TIK")

V(g)$color <- ifelse(V(g)$name %in% first_order, "red", 
              ifelse(V(g)$name %in% neutral, "gray", "#4cbee8"))

set.seed(27)
plot(g, asp=0.45, vertex.size = 6, vertex.label.color="black", vertex.label.font=1)

legend("bottomright", c("First order","Resistance", "Neutral"), pch=21,
       col="#777777", pt.bg=c("red", "#4cbee8", "gray"), pt.cex=2, cex=0.8)

degree(g, mode="all")
closeness(g, mode="all", weights=NA, normalized=T)
betweenness(g, directed=F, weights=NA, normalized=T)
eigen_centrality(g)
