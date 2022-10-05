#name : Smitesh Patil
#student id : 22223696

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


get_film_info <- function(name){
  out <- lapply(sw_films, function(x){
                          if(x$director == name) list("Director" = x$director, 
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

