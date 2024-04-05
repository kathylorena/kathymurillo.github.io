library(bigrquery)
library(tidyverse)

# Specify the path to your service account key file
json_path <- "json service account key"

# Authenticate with Google Cloud using the service account key
bq_auth(path = json_path)

# Set your BigQuery project ID
project <- "data-analyst-course-1"

# Set your SQL query
sql <- "SELECT * FROM `data-analyst-course-1.case_study.r_avg_hourly_intensity`"

# Run the query and store the result in a BigQuery table
tb <- bq_project_query(project, sql)

# Download the results from the BigQuery table
r_avg_hourly_intensity <- bq_table_download(tb)

# Convert time_of_day to POSIXct format
r_avg_hourly_intensity$time_of_day <- as.POSIXct(r_avg_hourly_intensity$time_of_day)

# Create a time-series plot with a prettier appearance using ggplot2
ggplot(r_avg_hourly_intensity, aes(x = time_of_day, y = avg_intensity)) +
  geom_line(color = "orchid4", size = 1) +                     # Line plot with thicker line
  theme_minimal() + 
  labs(x = "Time of Day",
       y = "Average Intensity",
       caption = "Source: Fitbit data") +   # Caption with data source
  theme(axis.text = element_text(size = 18),
        axis.title.x = element_text(size = 18, vjust = -2),  # Adjust vertical alignment for X-axis title
        axis.title.y = element_text(size = 18, vjust = 2),
        plot.caption = element_text(size = 10, color = "gray")) + # Caption appearance
  scale_x_datetime(date_breaks = "2 hour", date_labels = "%H:%M") # Adjust x-axis breaks and labels
