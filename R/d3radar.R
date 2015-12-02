#' <Add Title>
#'
#' <Add Description>
#'
#' @example inst/examples/examples.R
#' 
#' @import htmlwidgets
#'
#' @export
d3radar <- function(data = NULL, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    data = data
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'd3radar',
    x,
    width = width,
    height = height,
    package = 'd3radarR'
  )
}

#' Shiny bindings for d3radar
#'
#' Output and render functions for using d3radar within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a d3radar
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name d3radar-shiny
#'
#' @export
d3radarOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'd3radar', width, height, package = 'd3radarR')
}

#' @rdname d3radar-shiny
#' @export
renderD3radar <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, d3radarOutput, env, quoted = TRUE)
}
