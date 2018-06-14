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

