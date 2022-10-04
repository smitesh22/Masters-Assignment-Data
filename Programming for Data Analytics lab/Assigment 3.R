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
  out <- lapply(sw_films, function(x){
                          if(x$director=="George Lucas") list("Director" = x$director, 
                                                  "Title" = x$title,
                                                  "Episode" = x$episode,
                                                  "Opening" = x$opening,
                                                  "Date" = x$release_date)
                          }
                        )
  
  out <- out[lengths(out) != 0]
  
  return(out)
}

movies <- get_film_info("George Lucas")
str(movies)

