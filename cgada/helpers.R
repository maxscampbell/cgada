# Load in relevant packages
library(ggplot2)
library(tidyverse)
library(glue)

# Names vector for easy applications
names <- c( "Class", "Entries", "Coins", "Kills", "Deaths", "Vigor.Flask.Entries", 
            "Bandage.Entries", "Accelerator.Entries", "Echo.Bolt.Entries",
            "Spring.Plume.Entries", "Hedge.Seed.Entries", "Risk.It.Biscuit.Entries",
            "Nox.Bomb.Entries", "Flame.Trap.Entries", "Lava.Cake.Entries", 
            "Smoke.Screen.Entries",
            "Vigor.Flask.Coins", "Bandage.Coins", "Accelerator.Coins", 
            "Echo.Bolt.Coins", "Spring.Plume.Coins", "Hedge.Seed.Coins",
            "Risk.It.Biscuit.Coins", "Nox.Bomb.Coins", "Flame.Trap.Coins", 
            "Lava.Cake.Coins", "Smoke.Screen.Coins"
)

# Load in raw data and compile into list
mar16 <- as_tibble(read.csv(".\\data\\March 16 2025.csv", TRUE))
mar22 <- as_tibble(read.csv(".\\data\\March 22 2025.csv", TRUE))

playtests <- list(mar16, mar22)
dates <- c("03/16/2025", "03/22/2025")

#Add dates to each raw dataset
add_dates <- function(tib, date = "01/01/1990") {
  dateFormatted <- as.Date(date, "%m/%d/%Y")
  
  result <- tib |>
    mutate(date = dateFormatted)
  
  return(result)
}

combine <- function(tib1, tib2) {
  result <- bind_rows(tib1, tib2)
  return(result)
}

#Iterate through n datasets and combine them
compile <- function(tib_list, date_list) {
  for(i in 1:length(date_list)) {
    tib_list[[i]] <- add_dates(tib_list[[i]], date = date_list[[i]])
  }
  
  for (i in 2:length(tib_list)) {
    tib_list[[1]] <- combine(tib_list[[1]], tib_list[[i]])
  }
  
  return(tib_list[[1]])
}

cg_data <- compile(playtests, dates)

#Add statistics that we are interested in
cg_data_full <- cg_data |>
  mutate(Entry.Percent = Entries / sum(Entries)) |>
  group_by(Class.Name) |>
  mutate(KPE = Kills / Entries,
         CPE = Coins / Entries,
         Entry.Percent = sum(Entry.Percent))