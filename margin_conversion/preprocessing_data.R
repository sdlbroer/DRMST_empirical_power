# clear environment
rm(list = ls())

# load necessary libraries
library(readxl) # read in data
library(plyr) # plyr
library(dplyr) # data wrangling
library(data.table) # data wrangling

# our included trials
trials <- read_excel("manuscript_information.xlsx", 
                     sheet = "trials", 
                     col_types = c("numeric", 
                                   "skip", "skip", "text", "numeric", 
                                   "numeric", "text", "text", "numeric", 
                                   "skip", "skip", "skip", "skip", 
                                   "skip", "skip", "skip", "skip"))

# Weir and Trinquart's included trials
Weir_trials <- read_excel("manuscript_information.xlsx", 
                          sheet = "Weir_trials", 
                          col_types = c("numeric", 
                                        "skip", "skip", "text", "numeric", 
                                        "numeric", "text", "text", "numeric", 
                                        "skip", "skip", "skip", "skip", 
                                        "skip", "skip", "skip", "skip"))

# seperate different margin types
## original margin = HR 
HR_margins <- rbind(trials[trials$margin_type == 'HR',],
                    Weir_trials[Weir_trials$margin_type == 'HR',])
## original margin = DS 
DS_margins <- rbind(trials[trials$margin_type == 'DS',],
                    Weir_trials[Weir_trials$margin_type == 'DS',]) %>%
  mutate(NI_margin = NI_margin/100,
         NI_margin = - abs(NI_margin)) %>%  # make all margins negative
  select(id, time_hor, unit, NI_margin, onetwosided, CI_perc, margin_type)
## original margin = DRMST
DRMST_margins <- trials[trials$margin_type == 'DRMST',] %>%
  mutate(NI_margin = - abs(NI_margin)) # make margin negative

# read in the reconstructed study data
reconstructed <- read_excel("reconstructed.xlsx")

p0_new <- read_excel("manuscript_information.xlsx", 
                     sheet = "trials",
                     col_types = c("numeric", "skip", "skip", 
                                   "skip", "skip", "skip", "skip", "skip", 
                                   "skip", "numeric", "numeric", "text", 
                                   "numeric", "numeric", "numeric", 
                                   "numeric", "numeric"))
p0_weir <- read_excel("manuscript_information.xlsx", 
                      sheet = "Weir_trials",
                      col_types = c("numeric", "skip", "skip", 
                                    "skip", "skip", "skip", "skip", "skip", 
                                    "skip", "numeric", "numeric", "text", 
                                    "numeric", "numeric", "numeric", 
                                    "numeric", "numeric"))
p0 <- rbind(p0_new, p0_weir) %>%
  mutate(lambda = ifelse(!is.na(lambda) & unit == 'd', lambda/365, lambda)) %>%
  mutate(lambda = ifelse(!is.na(lambda) & unit == 'w', lambda/52, lambda)) %>%
  mutate(lambda = ifelse(!is.na(lambda) & unit == 'm', lambda/12, lambda)) %>%
  mutate(lambda = ifelse(is.na(lambda), -log(1-expected_rate)/expected_time, lambda)) %>%
  mutate(expected_rate = NULL,
         expected_time = NULL,
         unit = NULL)
rm(p0_new, p0_weir)

# add max time if tau =/= max time 
HR_margins <- left_join(HR_margins, select(p0, id, max_time))
