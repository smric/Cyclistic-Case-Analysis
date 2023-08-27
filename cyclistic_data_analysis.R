library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data
getwd()
setwd("/Users/User/Documents/Data Analytics Course Materials/Cyclistic Case Study/Raw Data")

july_2022 <-read.csv("July 2022.csv")
aug_2022 <-read.csv("Aug 2022.csv")
sept_2022 <-read.csv("Sept 2022.csv")
oct_2022 <-read.csv("Oct 2022.csv")
nov_2022 <-read.csv("Nov 2022.csv")
dec_2022 <-read.csv("Dec 2022.csv")
jan_2023 <-read.csv("Jan 2023.csv")
feb_2023 <-read.csv("Feb 2023.csv")
march_2023 <-read.csv("March 2023.csv")
april_2023 <-read.csv("April 2023.csv")
may_2023 <-read.csv("May 2023.csv")
june_2023 <-read.csv("June 2023.csv")

colnames(july_2022)#checking data sets for consistency 
colnames(aug_2022)
colnames(sept_2022)
colnames(oct_2022)
colnames(nov_2022)
colnames(dec_2022)
colnames(jan_2023)
colnames(feb_2023)
colnames(march_2023)
colnames(april_2023)
colnames(may_2023)
colnames(june_2023)

str(july_2022)#check data structure 
str(aug_2022)
str(sept_2022)
str(oct_2022)
str(nov_2022)
str(dec_2022)
str(jan_2023)
str(feb_2023)
str(march_2023)
str(april_2023)
str(may_2023)
str(june_2023)

#merge monthly data frames into a large data frame 
tripdata <-bind_rows(july_2022, aug_2022, sept_2022, oct_2022, nov_2022, dec_2022, jan_2023, feb_2023, march_2023,april_2023, may_2023, june_2023)

#check the merged data 
colnames(tripdata)  #List of column names
head(tripdata)  #See the first 6 rows of data frame.  Also tail(tripdata)
str(tripdata)  #See list of columns and data types (numeric, character, etc)
summary(tripdata)  #Statistical summary of data. Mainly for numeric.

#adding date, month, year, day of week columns 
tripdata <- tripdata %>% 
  mutate(year = format(as.Date(started_at), "%Y")) %>% # extract year
  mutate(month = format(as.Date(started_at), "%B")) %>% #extract month
  mutate(date = format(as.Date(started_at), "%d")) %>% # extract date
  mutate(day_of_week = format(as.Date(started_at), "%A")) %>% # extract day of week
  mutate(ride_length = difftime(ended_at, started_at))%>% #ended_at minus started_at
  mutate(start_time = strftime(started_at, "%H")) #extracting hours 

# converting 'ride_length' to numeric for calculation on data
tripdata <- tripdata %>% 
  mutate(ride_length = as.numeric(ride_length))
is.numeric(tripdata$ride_length) # to check it is right format

#remove bad data
tripdata_clean <- tripdata[!(tripdata$ride_length <= 0),]

#Descriptive analysis on ride_length 
mean(tripdata_clean$ride_length) #straight average (total ride length / rides)
median(tripdata_clean$ride_length)  #midpoint number in the ascending array of ride lengths
max(tripdata_clean$ride_length)#longest ride
min(tripdata_clean$ride_length)#shortest ride

# You can condense the four lines above to one line using summary() on the specific attribute
summary(tripdata_clean$ride_length)

#compare members and casual users 
aggregate(tripdata_clean$ride_length ~ tripdata_clean$member_casual, FUN = mean)
aggregate(tripdata_clean$ride_length ~ tripdata_clean$member_casual, FUN = median)
aggregate(tripdata_clean$ride_length ~ tripdata_clean$member_casual, FUN = max)
aggregate(tripdata_clean$ride_length ~ tripdata_clean$member_casual, FUN = min)

#average ride time by each day for members and casual users 
aggregate(tripdata_clean$ride_length ~ tripdata_clean$member_casual + tripdata_clean$day_of_week, FUN = mean)

#rearranging the days of week in order 
tripdata_clean$day_of_week <- ordered(tripdata_clean$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

#rerun the aggregate
aggregate(tripdata_clean$ride_length ~ tripdata_clean$member_casual + tripdata_clean$day_of_week, FUN = mean)

#analyze ridership data by type and weekday
tripdata_clean %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n(),average_duration = mean(ride_length)) %>% #calculates the number of rides and average duration
  arrange(member_casual, weekday)	# sorts

#Visualise the number of rides by ridership 
tripdata_clean %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%   group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday) %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) + geom_col(position = "dodge") + labs(title = "Cyclistic Bike Share:Number of Rides by Ridership")

#Visualisation for average duration 
tripdata_clean %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%    
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n(),average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) + geom_col(position = "dodge") + labs(title = "Cyclistic Bike Share:Average duration by Ridership")

write.csv(tripdata_clean, "C:/Users/User/Documents/Data Analytics Course Materials/Cyclistic Case Study/cleantripdata.csv", row.names = FALSE)

