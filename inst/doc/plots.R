## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(svglite)
library(slickR)

## ----eval=FALSE----------------------------------------------------------
#  
#  # Standard Plot
#    xmlSVG({
#      plot(1:10)
#    }, standalone = TRUE)
#  
#  # ggplot
#    xmlSVG({
#      show(ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
#        geom_point())
#    }, standalone = TRUE)
#  
#  # lattice xyplot
#    xmlSVG({
#      print(xyplot(x ~ x, data.frame(x = 1:10), type = "l"))
#    }, standalone = TRUE)
#  
#  # lattice dotplot
#    xmlSVG({
#      print(dotplot(variety ~ yield | site,
#        data = barley, groups = year,
#        key = simpleKey(levels(barley$year), space = "right"),
#        xlab = "Barley Yield (bushels/acre) ",
#        aspect = 0.5, layout = c(1, 6), ylab = NULL
#      ))
#    }, standalone = TRUE)
#  

## ------------------------------------------------------------------------
plotsToSVG <- lapply(1:5,
                     function(x){
                       svglite::xmlSVG(
                         code = {plot(stats::density(stats::rnorm(10*x,sd=x)))},
                         standalone = TRUE)
                       }
                     )

## ------------------------------------------------------------------------
SVGtoChr <- sapply(plotsToSVG, function(sv) {
  paste0("data:image/svg+xml;utf8,", as.character(sv))
})

## ------------------------------------------------------------------------

SVGtoChr <- gsub("#", "%23", SVGtoChr)


## ------------------------------------------------------------------------
slickR(SVGtoChr, 
       slideId = 'ex8',
       height = 200, 
       width = "95%"
      )

## ------------------------------------------------------------------------

opts <- list(
  # 'up' options
    list(slidesToShow = 1, slidesToScroll = 1),
  # 'down' options
    list(dots = FALSE, 
         slidesToScroll = 1, 
         slidesToShow = 3,
         centerMode = TRUE, 
         focusOnSelect = TRUE)
)

synch_map <- expand.grid(list('up','down'),stringsAsFactors = FALSE)

slickR(SVGtoChr,
       slideIdx = replicate(2,seq_along(SVGtoChr),simplify = FALSE),
       slideId =  c('up','down'),
       synchSlides = synch_map,
       slideType = rep('img',length(SVGtoChr)),
       slickOpts = opts,
       height = 100, 
       width = "95%")


