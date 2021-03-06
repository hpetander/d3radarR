# devtools::install_github("timelyportfolio/d3radarR")

library(d3radarR)

# use data from demo
#   https://github.com/TennisVisuals/updating-radar-chart/blob/master/radarDemo.js
json_data = jsonlite::fromJSON(
'
  [  
    {  
      "key":"Nokia Smartphone",
      "values":[  
        {  "axis":"Battery Life", "value":0.26 }, {  "axis":"Brand", "value":0.10 },
        {  "axis":"Contract Cost", "value":0.30 }, {  "axis":"Design And Quality", "value":0.14 },
        {  "axis":"Have Internet Connectivity", "value":0.22 }, {  "axis":"Large Screen", "value":0.04 },
        {  "axis":"Price Of Device", "value":0.41 }, {  "axis":"To Be A Smartphone", "value":0.30 }
        ]
    },
    {  
      "key":"Samsung",
      "values":[  
        {  "axis":"Battery Life", "value":0.27 }, {  "axis":"Brand", "value":0.16 },
        {  "axis":"Contract Cost", "value":0.35 }, {  "axis":"Design And Quality", "value":0.13 },
        {  "axis":"Have Internet Connectivity", "value":0.20 }, {  "axis":"Large Screen", "value":0.13 },
        {  "axis":"Price Of Device", "value":0.35 }, {  "axis":"To Be A Smartphone", "value":0.38 }
        ]
    },
    {  
      "key":"iPhone",
      "values":[  
        {  "axis":"Battery Life", "value":0.22 }, {  "axis":"Brand", "value":0.28 },
        {  "axis":"Contract Cost", "value":0.29 }, {  "axis":"Design And Quality", "value":0.17 },
        {  "axis":"Have Internet Connectivity", "value":0.22 }, {  "axis":"Large Screen", "value":0.02 },
        {  "axis":"Price Of Device", "value":0.21 }, {  "axis":"To Be A Smartphone", "value":0.50 }
        ]
    }
  ]
',
  simplifyDataFrame = FALSE
)

d3radar(json_data)

# let's see if more than one can exist on a page
library(htmltools)
browsable(tagList(d3radar(json_data),d3radar(json_data)))

# use example from ?stars
library(d3radarR)
library(scales)
library(dplyr)
library(purrr)

# this is ugly
#  should probably include some conversion helpers
mtcars %>%
  add_rownames( var = "key" ) %>%
  mutate_each(funs(rescale), -key) %>%
  #limit to 8 rows for manageability
  head(8) %>%
  by_row(
    function(row){
      list(
        key = row[["key"]],
        values = lapply(
          names(row)[-match("key",names(row))],
          function(nm){
            list(
              "axis" = nm,
              "value" = row[[nm]]
            )
          }
        )
      )
    }
  ) %>%
  {
    d3radar( .$.out )
  }
