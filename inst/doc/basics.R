## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(htmlwidgets)
library(slickR)

## ------------------------------------------------------------------------
slickR(obj = nba_team_logo$uri, height = 100, width = "95%", slideId = 'ex1')

## ------------------------------------------------------------------------

slickR(obj = nba_team_logo$uri, 
       slideId = 'ex2', 
       slickOpts = list(dots = FALSE), 
       height = 100, 
       width = "95%")


## ------------------------------------------------------------------------

slickR(
  obj = nba_team_logo$uri,
  slideId = 'ex3',
  slickOpts = list(dots = TRUE,autoplay = TRUE),
  height = 100, 
  width = "95%"
)


## ------------------------------------------------------------------------

opts <- list(initialSlide = 0, 
     slidesToShow = 5, 
     slidesToScroll = 5,
     focusOnSelect = TRUE, 
     dots = TRUE)

slickR(nba_player_logo$uri,
       slideId = 'ex4',
       slickOpts = opts,
       height = 100, 
       width = "95%")


## ------------------------------------------------------------------------
slickR(nba_player_logo$uri,
       slideId = 'ex5',
       objLinks = list(nba_player_logo$player_home), 
       slickOpts = opts,
       height = 100, 
       width = "95%")

## ------------------------------------------------------------------------

cP1 <- htmlwidgets::JS("function(slick,index) {
                            return '<a>'+(index+1)+'</a>';
                       }")

opts <- list(
    initialSlide = 0,
    slidesToShow = 5,
    slidesToScroll = 5,
    focusOnSelect = TRUE,
    dots = TRUE,
    customPaging = cP1
    )

slickR(
  obj = nba_player_logo$uri,
  dotObj = nba_team_logo$uri,
  slideId = 'ex6',
  slickOpts = opts,
  height = 100,
  width = "95%"
) 


## ------------------------------------------------------------------------

cP2 <- JS("function(slick,index) {
          return '<a><img src= ' + dotObj[index] + '  width=100% height=100%></a>';
          }")

opts <- 
  list(
    initialSlide = 0,
    slidesToShow = 5,
    slidesToScroll = 5,
    focusOnSelect = TRUE,
    dots = TRUE,
    customPaging = cP2
  )

slick <- slickR(
  obj = nba_player_logo$uri,
  dotObj = nba_team_logo$uri,
  slideId = 'ex7',
  slickOpts = opts,
  height = 100,
  width = "95%"
) 


# Putting it all together in one slickR call
s2 <- htmltools::tags$script(
  sprintf("var dotObj = %s", jsonlite::toJSON(nba_team_logo$uri))
)

htmltools::browsable(htmltools::tagList(s2, slick))

## ------------------------------------------------------------------------
opts <- list(
  # 'up' options
    list(slidesToShow = 1, slidesToScroll = 1),
  # 'down' options
    list(dots = FALSE, 
         slidesToScroll = 1, 
         slidesToShow = 5,
         centerMode = TRUE, 
         focusOnSelect = TRUE)
)

synch_map <- expand.grid(list('up','down'),stringsAsFactors = FALSE)

slickR(rep(nba_player_logo$uri,2),
       slideIdx = replicate(2,seq_along(nba_player_logo$uri),simplify = FALSE),
       slideId =  c('up','down'),
       objLinks = list(up = nba_player_logo$player_home,down = NULL),
       synchSlides = synch_map,
       slideType = rep('img',2),
       slickOpts = opts,
       height = 100, 
       width = "90%")

## ------------------------------------------------------------------------

slickR(
  obj         = c(nba_player_logo$uri[1:2],
                  glue::glue('<p>{nba_player_logo$name[1:2]}</p>')),
  slideType   = c('img','p'),
  slideId     = c('img','cap'),
  slideIdx    = list(c(1,2),c(3,4)),
  synchSlides = expand.grid(list('img','cap'),stringsAsFactors = FALSE),
  height      = 100,
  slickOpts   = list(list(dots=FALSE),list(dots=TRUE,arrows=FALSE))
)

