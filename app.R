source("data/dependencies.R")
colors <- tibble(
  primary= '#007aff',
  red= '#ff3b30',
  green= '#4cd964',
  blue= '#2196f3',
  pink= '#ff2d55',
  yellow= '#ffcc00',
  orange= '#ff9500',
  purple= '#9c27b0',
  deeppurple= '#673ab7',
  lightblue= '#5ac8fa',
  teal= '#009688',
  lime= '#cddc39',
  deeporange= '#ff6b22',
  white= '#ffffff',
  black= '#000000'
)


app_option <- list(
  theme = "auto",
  dark = FALSE,
  filled= FALSE,
  skeletonsOnLoad = TRUE,
  color = "white",
  touch = list(
    touchClicksDistanceThreshold = 5,
    tapHold = TRUE,
    tapHoldDelay = 500,
    tapHoldPreventClicks = TRUE,
    iosTouchRipple = TRUE,
    mdTouchRipple = TRUE
  ),
  iosTranslucentBars = FALSE,
  navbar = list(
    iosCenterTitle = TRUE,
    hideOnPageScroll = TRUE
  ),
  toolbar = list(
    hideOnPageScroll = TRUE
  ),
  pullToRefresh = TRUE
)


ui <- f7Page(
  title = "EMT Mobile Tracker",
  options = app_option,
  f7TabLayout(
    navbar = f7Navbar(
      title = "EMT Tracker",
      hairline = TRUE
    ),
    
    # Tabs
    f7Tabs(
      animated = TRUE,
      id = "tabset",
      # First Tab
      f7Tab(
        title = "Overview",
        tabName = "Tab1",
        icon = f7Icon(
          "chart_pie_fill",
          color = "primary"
        ),
        f7Card(
          outline = TRUE
        ),
        f7Card(
          outline = TRUE
        ),
        f7Card(
          outline = TRUE
        )
      ),
      
      # Second Tab
      f7Tab(
        title = "Compare Gases",
        tabName = "Tab2",
        icon = f7Icon(
          "arrow_right_arrow_left_circle_fill",
          color = "primary"
        ),
        f7Card(
          outline = TRUE
        ),
        f7Card(
          outline = TRUE
        )
      ),
      
      # Third Tab
      f7Tab(
        title = "Country Comparison",
        tabName = "Tab3",
        icon = f7Icon(
          "flag_circle_fill",
          color = "primary"
        ),
        f7Card(
          outline = TRUE
        ),
        f7Card(
          outline = TRUE
        ),
        f7Card(
          outline = TRUE
        )
      ),
      
      # Fourth Tab
      f7Tab(
        title = "Emission Forecast",
        tabName = "Tab4",
        icon = f7Icon(
          "graph_square_fill",
          color = "primary"
        ),
        f7Card(
          outline = TRUE
        )
      ),
      
      # Fifth Tab
      f7Tab(
        title = "Scenario Analysis",
        tabName = "Tab5",
        icon = f7Icon(
          "cloud_sun_rain_fill",
          color = "primary"
        ),
        f7Card(
          outline = TRUE
        )
      )
    ),
  ),
  allowPWA = TRUE
)

server <- function(input, output, session){
  
}

shinyApp(ui, server)