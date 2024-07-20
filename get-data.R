url <- ("https://raw.githubusercontent.com/xrander/emission_tracker/master/data/dat-processing.r")
source(url)


rm(list = ls())

tbl <- read_csv("data/data.csv")
tbl |> print(width = Inf)

forecast_tbl <- read_rds("data/forecast_mod.rds")

forecast_tbl <- forecast_tbl |> 
  extract_nested_future_forecast() |> 
  clean_names() |> 
  select(year = index, everything())



## Year Emission
year_emission <- function(select_year) {
  tbl |> 
    summarize(
      .by = year,
      emission = sum(emission)
    ) |> 
    mutate(
      emission = round((emission/1e9), 2),
      emission = paste0(emission, " Billion Tonne CO2e")
    ) |> 
    filter(year == {{ select_year }})
}

## Emission Year Percentage Change

select_percent_difference <- function(select_year) {
  tbl |> 
    summarize(
      .by = year,
      emission = sum(emission)
    ) |> 
    mutate(
      percent_change = round((emission - lag(emission))/emission * 100, 2),
      status = case_when(
        percent_change < lag(percent_change) ~ "Good",
        percent_change == lag(percent_change) ~ "No change",
        .default = "Bad"
      )
    ) |> 
    filter(year == {{ select_year }})
}

## Emitting Countries

### Top Emitters

plot_top_emitters <- function(select_year) {
  tbl |> 
    filter(year == {{ select_year }}) |> 
    summarize(
      .by = country,
      emission = sum(emission),
      emission = round(emission/1e9)
    ) |> 
    slice_max(order_by = emission, n = 5) |> 
    apex(
      type = "column",
      aes(country, emission)
    ) |> 
    ax_title(
      text = paste0("Top Emitting Countries for ", {{select_year}}),
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#800B05"
      )
    ) |> 
    ax_xaxis(title = list(text = "Countries")) |> 
    ax_yaxis(title = list(text = "Emissions in Co2e (Billions)")) |> 
    ax_fill(
      type = "solid",
      colors = "#E63120"
    )
}

### Least Emitters

plot_least_emitters <- function(select_year) {
  tbl |> 
    filter(year == {{ select_year }}) |> 
    summarize(
      .by = country,
      emission = sum(emission),
      emission = round(emission/1e6)
    ) |> 
    slice_min(order_by = emission, n = 5) |> 
    apex(
      type = "column",
      aes(country, emission)
    ) |> 
    ax_title(
      text = paste0("Least Emitting Countries for ", {{select_year}}),
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#800B05"
      )
    ) |> 
    ax_xaxis(title = list(text = "Countries")) |> 
    ax_yaxis(title = list(text = "Emissions in Co2e (Millions)")) |> 
    ax_fill(
      type = "solid",
      colors = "#E63120"
    )
}



plot_top_emitters(1995)
plot_least_emitters(1995)
