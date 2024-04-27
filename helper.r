app_opts <- list(
  theme = "auto",
  dark = TRUE,
  filled = TRUE,
  color = "darkgreen",
  touch = list(
    tapHold = TRUE,
    tapHoldDelay = 750,
    iosTouchRipple = FALSE
  ),
  iosTranslucentBars = FALSE,
  navbar = list(
    iosCenterTitle = TRUE,
    hideOnPageScroll = TRUE
  ),
  toolbar = list(
    hideOnPageScroll = FALSE
  ),
  pullToRefresh = TRUE
)

nav_bar <-  f7Navbar(
  title = "EMT Greenhouse Emission Tracker",
  hairline = FALSE,
  shadow = TRUE,
  icon = f7Icon("cloud_bolt_fill"),
  leftPanel = FALSE,
  rightPanel = TRUE
)

left_panel <-  f7Panel(
  id = "ltab",
  title = "Overview",
  side = "left", 
  theme = "dark",
  effect = "cover"
)

right_panel <- f7Panel(
  id = "rtab",
  title = "Controls", 
  side = "right",
  theme = "dark", 
  effect = "cover"
)