source("data/dependencies.R")
source("get-data.R")

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
      
      # First Tab --------------------------------------------
      ## Overview -------------------------------------------
      f7Tab(
        title = "Overview",
        tabName = "Tab1",
        icon = f7Icon("chart_pie_fill", color = "primary"),
        active = TRUE,
        
        ## Tab 1 Input Box -----------------------------------
        f7List(
          inset = TRUE,
          dividers = TRUE,
          strong = TRUE,
          f7SmartSelect(
            inputId = "select_year",
            label = "Choose a Year",
            choices = unique(tbl$year),
            openIn = "sheet",
            selected = 1990
          )
        ),
        f7Card(
          outline = TRUE,
          raised = TRUE,
          divider = TRUE,
          title = "Gas Emission for Year",
          apexchartOutput("gas_emission")
        ),
        f7Card(
          outline = TRUE,
          raised = TRUE,
          divider = TRUE,
          title = "Least Emitting Country",
          apexchartOutput("least_emitters")
        ),
        f7Card(
          outline = TRUE,
          raised = FALSE,
          divider = TRUE,
          title = "Top Emitting Country",
          apexchartOutput("top_charter")
        )
      ),
      
      # Second Tab -------------------------------------------
      ## Gas comparison
      f7Tab(
        title = "Compare Gases",
        tabName = "Tab2",
        icon = f7Icon("arrow_right_arrow_left_circle_fill", color = "primary"),
        
        ## Tab 2 Input Box -----------------------------------
        f7List(
          inset = TRUE,
          strong = TRUE,
          outline = TRUE,
          f7SmartSelect(
            inputId = "select_year_2",
            label = "Choose a Year",
            choices = unique(tbl$year),
            openIn = "sheet"
          ),
          hr(),
          f7SmartSelect(
            inputId = "Select_gas",
            label = "Choose a Greenhouse Gas",
            choices = unique(tbl$gas),
            openIn = "sheet"
          )
        ),
        
        f7Card(
          outline = TRUE,
          raised = TRUE,
          divider = TRUE,
          title = "Total Gas Emission",
          apexchartOutput("total_gas")
        ),
        f7Card(
          outline = TRUE,
          raised = TRUE,
          divider = TRUE,
          title = "Individual Gas Comparison",
          apexchartOutput("individual_gas")
        )
      ),
      
      # Third Tab ------------------------------------------
      ## Country metrics
      f7Tab(
        title = "Country Comparison",
        tabName = "Tab3",
        icon = f7Icon("flag_circle_fill", color = "primary"),
        
        ## Tab 3 Input Box ---------------------------------
        f7List(
          inset = TRUE,
          strong = TRUE,
          outline = TRUE,
          f7SmartSelect(
            inputId = "select_country",
            label = "Choose a Country",
            choices = unique(tbl$country),
            openIn = "sheet"
          )
        ),
        f7Card(
          outline = TRUE,
          raised = TRUE,
          divider = TRUE,
          title = "Emission per Person",
          apexchartOutput("emission_per_person")
        ),
        f7Card(
          outline = TRUE,
          raised = TRUE,
          divider = TRUE,
          title = "Emission per Capital",
          apexchartOutput("emission_per_capital")
        ),
        f7Card(
          outline = TRUE,
          raised = TRUE,
          divider = TRUE,
          title = "Proportion of Total Emission for Year",
          apexchartOutput("prop_emission")
        )
      ),
      
      # Fourth Tab ------------------------------------------
      ## Forecast data
      f7Tab(
        title = "Emission Forecast",
        tabName = "Tab4",
        icon = f7Icon("graph_square_fill", color = "primary"),
        
        ## Tab 4 Input Box -----------------------------------
        f7List(
          inset = TRUE,
          outline = TRUE,
          strong = TRUE,
          f7DatePicker(
            inputId = "pick_date",
            label = "Pick a Date",
            minDate = min(unique(forecast_tbl$year)),
            maxDate = max(unique(forecast_tbl$year)),
            value = unique(forecast_tbl$year)[30],
            openIn = "popover",
            closeByOutsideClick = TRUE,
            header = TRUE
          ),
          hr(),
          f7SmartSelect(
            inputId = "select_ghg",
            label = "Select GreenHouse Gas",
            choices = unique(as.character(forecast_tbl$gas)),
            openIn = "popup"
          )
        ),
        f7Card(
          outline = TRUE,
          raised = TRUE,
          divider = TRUE,
          title = "Emission Forecast",
          apexchartOutput("forecast")
        )
      )
    )
  ),
  allowPWA = TRUE
)

server <- function(input, output, session){
  
}

shinyApp(ui, server)