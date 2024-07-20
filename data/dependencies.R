if (require(pacman) == FALSE) {
  install.packages("pacman")
} else{
  library(pacman)
}

p_load(shiny, shinyMobile, tidyverse, rvest, httr, jsonlite, janitor, apexcharter, modeltime)
