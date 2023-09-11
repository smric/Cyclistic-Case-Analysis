# Cyclistic-Case-Analysis
## Introduction 
In this case study, I performed real-world tasks of a junior data analyst at a fictional company called Cyclistic 
### Quick link:
Data Source: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html)

## Ask 
### Buisness Task 
Devise marketing strategies to convert casual riders to members 
### Analysis QUestions 
Three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?
The first questions was assigned to answer - How do annual members and casual riders use Cyclistic bikes differently?

## Prepare 
### Data Source 
I used Cyclistic's historical trip data to analyse and identify trends from June 2022 to July 2023 

### Data organisation 
There are 12 files with naming convention of YYYYMM-divvy-tripdata and each file includes information for one month, such as the ride id, bike type, start time, end time, start station, end station, start location, end location, and whether the rider is a member or not. The corresponding column names are ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.

### Process 
R analysis was used to combine the various datasets into one dataset and clean it. 
### Packages Used 
1. tidyverse - Helps wrangle data 
2. lubridate - Helps wrangle data attributes
3. ggplot2 - Helps visualise data 
### Combining Data 
Before combining the 12 csv files, checked the consistency between the data sets 
### Preparing Data 
1. Added date, month, year, day of week columns
2. Checking and ensuring that data is in numeric
3. Remove bad data
### Analyse Phase 
Calculated 
1. Descriptive analysis on ride_length
2. Compare the descriptive analysis among casual users and members
3. Average ride time by each day for members and casual users
4. Analyse ridership data by type and week day
5. Visualisation the number of rides by ridership (casual users and members)
6. Visualisation for average duration





