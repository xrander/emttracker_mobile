
# Get Emission Data -------------------------------------------------------

url <- ("https://raw.githubusercontent.com/xrander/emission_tracker/master/data/dat-processing.r")
source(url)


 rm(list = ls())

tbl <- read_csv("data/data.csv")
tbl <- tbl |> 
  mutate(
    country = case_when(country == "United States of America" ~ "USA",
                        country == "European Union" ~ "EU",
                        country == "United Kingdom" ~ "UK",
                        country == "Liechtenstein" ~ "LCHT",
                        country == "New Zealand" ~ "NZ",
                        .default = country)
  ) 

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


# Tab 1 -------------------------------------------------------------------

## Top Emitters Plot ------------------------------------------------------

plot_top_emitters <- function(select_year) {
  tbl |> 
    filter(year == {{ select_year }}) |> 
    summarize(
      .by = country,
      emission = sum(emission),
      emission = round(emission/1e6)
    ) |> 
    slice_max(order_by = emission, n = 5) |> 
    apex(
      type = "bar",
      aes(country, emission)
    ) |> 
    ax_title(
      text = paste0("Top Emitting Countries, Year ", {{select_year}}),
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#000"
      )
    ) |> 
    ax_xaxis(title = list(text = "Emissions in Co2e (Millions)")) |> 
    ax_fill(
      type = "solid",
      colors = "#be3f0e"
    ) |> 
    ax_tooltip(
      fixed = list(enabled = TRUE, position = "topright")
    )
}

### Log Transformed -----------------------------------------------------
plot_top_emitters_log <- function(select_year) {
  tbl |> 
    filter(year == {{ select_year }}) |> 
    summarize(
      .by = country,
      emission = sum(emission),
    ) |> 
    slice_max(order_by = emission, n = 5) |> 
    mutate(
      log_emission = round(log(emission), 2),
    ) |> 
    arrange(desc(log_emission)) |> 
    apex(
      type = "bar",
      aes(country, log_emission)
    ) |> 
    ax_xaxis(title = list(text = "Log Value of Co2e")) |> 
    ax_title(
      text = paste0("Top Emitters (log scale), Year ", {{select_year}}),
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#000"
      )
    ) |> 
    ax_fill(
      type = "solid",
      colors = "#be3f0e"
    ) |> 
    ax_tooltip(
      fixed = list(enabled = TRUE, position = "topright")
    )
}
## Least Emitters ---------------------------------------------------------

plot_least_emitters <- function(select_year) {
  tbl |> 
    filter(year == {{ select_year }}) |> 
    summarize(
      .by = country,
      emission = sum(emission),
      emission = round(emission/1e6)
    ) |> 
    slice_min(order_by = emission, n = 5) |> 
    arrange(desc(emission)) |> 
    apex(
      type = "bar",
      aes(country, emission)
    ) |> 
    ax_title(
      text = paste0("Least Emitting Countries, Year ", {{select_year}}),
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#000000"
      )
    ) |> 
    ax_xaxis(title = list(text = "Emissions in Co2e (Millions)")) |> 
    ax_fill(
      type = "solid",
      colors = "#3f0ebe"
    ) |> 
    ax_tooltip(
      fixed = list(enabled = TRUE, position = "topright")
    )
}

### Log Transformation ----------------------------------------------------
plot_least_emitters_log <- function(select_year) {
  tbl |> 
    filter(year == {{ select_year }}) |> 
    summarize(
      .by = country,
      emission = sum(emission),
    ) |> 
    slice_min(order_by = emission, n = 5) |> 
    mutate(
      log_emission = round(log(emission), 2),
    ) |> 
    arrange(desc(log_emission)) |> 
    apex(
      type = "bar",
      aes(country, log_emission)
    ) |> 
    ax_xaxis(title = list(text = "Log Value of Co2e")) |> 
    ax_title(
      text = paste0("Top Emitters (log scale), Year ", {{select_year}}),
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#000"
      )
    ) |> 
    ax_fill(
      type = "solid",
      colors = "#3f0ebe"
    ) |> 
    ax_tooltip(
      fixed = list(enabled = TRUE, position = "topright")
    )
}
## Yearly Gas Proportion ---------------------------------------------------

plot_yearly_gas_proportion <- function(select_year) {
  tbl |> 
    filter(year == {{ select_year }}) |> 
    summarize(
      .by = gas,
      emission = sum(emission),
      emission = round(emission, 1e6)
    ) |> 
    mutate(
      percent_emission = round(emission / sum(emission), 4)
    ) |> 
    arrange(desc(percent_emission)) |> 
    apex(
      type = "bar",
      aes(gas, percent_emission)
    ) |> 
    ax_xaxis(
      title = list(text = "Proportion of Emission"),
      type = "numeric",
      tickPlacement = "on",
      labels = list(
        formatter = format_num(".0%")
      )
    ) |> 
    ax_title(
      text = paste0("GHG Proportion Year ", {{select_year}}),
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#000000"
      )
    ) |> 
    ax_fill(
      type = "solid",
      colors = "#be3f0e"
    ) |> 
    ax_tooltip(
      fixed = list(enabled = TRUE, position = "topright")
    )
}

### Pie Option -------------------------------------------------------------
plot_yearly_gas_prop_pie <- function(select_year) {
  tbl |> 
    filter(year == {{ select_year }}) |> 
    summarize(
      .by = gas,
      emission = sum(emission),
      emission = round(emission, 1e6)
    ) |> 
    mutate(
      percent_emission = round(emission / sum(emission), 4)
    ) |> 
    arrange(desc(percent_emission)) |> 
    apex(
      type = "pie",
      aes(gas, percent_emission)
    ) |> 
    ax_title(
      text = paste0("Gas Proportion ", {{select_year}}), 
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#003964"
      )
    )
}

### Log Transformation -----------------------------------------------------
plot_year_gas_prop_log <- function(year) {
  tbl |> 
    filter(year == {{ year }}) |> 
    summarize(
      .by = gas,
      emission = sum(emission),
    ) |> 
    mutate(
      log_emission = log(emission),
      percent_log_emission = round(log_emission / sum(log_emission), 4)
    ) |> 
    arrange(desc(percent_log_emission)) |> 
    apex(
      type = "bar",
      aes(gas, percent_log_emission)
    ) |> 
    ax_xaxis(
      title = list(text = "Proportion of Emission"),
      type = "numeric",
      tickPlacement = "on",
      labels = list(
        formatter = format_num(".0%")
      )
    ) |> 
    ax_title(
      text = paste0("GHG Proportion Year ", {{ year }}),
      align = "center",
      style = list(
        fontSize = "25px",
        fontWeight = 500,
        color = "#000000"
      )
    ) |> 
    ax_fill(
      type = "solid",
      colors = "#be3f0e"
    ) |> 
    ax_tooltip(
      fixed = list(enabled = TRUE, position = "topright")
    )
}





plot_yearly_gas_proportion(2021)
plot_top_emitters(1995)
plot_least_emitters(1995)
plot_yearly_gas_prop_pie(2010)
