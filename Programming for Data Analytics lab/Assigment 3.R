library(repurrrsive)

str(sw_films)

get_directors <- function(){
  out <- lapply(sw_films, function(x){
    x$director
  })
  
  return(unlist(unique(out)))
}

dirs <- get_directors()
dirs


get_film_info <- function(x){
  x <- "George Lucas"
  out <- lapply(sw_films, function(y){
                          if(y$director==x) list(y$director, 
                                                      y$title,
                                                      y$episode,
                                                      y$opening,
                                                      y$release_date)
                          }
                        )
  
  out <- target_list[lengths(out) != 0]
  
  return(out)
}

movies <- get_film_info("George Lucas")
str(movies)