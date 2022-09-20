library(repurrrsive)

logi <- vector(mode = "logical", length = length(sw_films))


for(i in seq_along(sw_films)){
  logi[i] <- sw_films[[i]]$director == "George Lucas"
}


sw_films <- sw_films[logi]

for (i in seq_along(sw_films)){
  print(sw_films[[i]]$title)
}

#function

evens <- function(v){
  v[v %% 2 == 0]
}

tc = c(1,2,3,4,6)

evens(tc)