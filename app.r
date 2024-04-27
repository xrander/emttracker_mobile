source("data/dependencies.R")
source("helper.r")

ui <- f7Page(
  options = app_opts,
  title = "EMT Greenhouse EmissionTracker",
  
  f7TabLayout(
    panels = tagList(
      left_panel,
      right_panel
    ),
    navbar = nav_bar,
    

# Main content ------------------------------------------------------------

    f7Tabs(
      animated = TRUE,
      
      # First Tab ----------------
      f7Tab(
        title = "Dashboard",
        tabName = "Dashboard",
        icon = f7Icon("speedometer"),
        # f7Shadow(
        #   intensity = 10,
        #   hover = TRUE,
        #   f7Card(
        #     title = "Card header",
        #     f7SmartSelect(
        #       inputId = "variable", label = "Variables to show:",
        #       choices = c("Cylinders" = "cyl", "Transmission" = "am",
        #                   "Gears" = "gear"),
        #       openIn = "sheet",
        #       multiple = TRUE
        #     ),
        #     tableOutput("data")
        #   )
        # )
      ),
      
      
      # Second Tab -----------------------
      f7Tab(
        title = "Comparison",
        tabName = "Comparison",
        icon = f7Icon("timelapse"),
        # f7Shadow(
        #   intensity = 10,
        #   hover = TRUE,
        #   f7Card(
        #     title = "Card header",
        #     f7SmartSelect(
        #       inputId = "variable", label = "Variables to show:",
        #       choices = c("Cylinders" = "cyl", "Transmission" = "am",
        #                   "Gears" = "gear"),
        #       openIn = "sheet",
        #       multiple = TRUE
        #     ),
        #     tableOutput("data")
        #   )
        # )
      ),
      
      # Third Tab
      f7Tab(
        title = "Prediction",
        tabName = "Prediction",
        icon = f7Icon("waveform_path_ecg"),
        # f7Shadow(
        #   intensity = 10,
        #   hover = TRUE,
        #   f7Card(
        #     title = "Card header",
        #     f7SmartSelect(
        #       "variable",
        #       "Variables to show:",
        #       c("Cylinders" = "cyl",
        #         "Transmission" = "am",
        #         "Gears" = "gear"),
        #       openIn = "sheet",
        #       multiple = TRUE
        #     ),
        #     tableOutput("data")
        #   )
        # )
      )
    )
  )
)

server <- function(input, output, session){
  
}

shinyApp(ui, server)