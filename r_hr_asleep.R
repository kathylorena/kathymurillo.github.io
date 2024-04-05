library(bigrquery)
library(tidyverse)

# Specify the path to your service account key file
json_path <- "json service account key"

# Authenticate with Google Cloud using the service account key
bq_auth(path = json_path)

# Set your BigQuery project ID
project <- "data-analyst-course-1"

# Set your SQL query
sql <- "SELECT * FROM `data-analyst-course-1.case_study.r_activity_hr`"

# Run the query and store the result in a BigQuery table
tb <- bq_project_query(project, sql)

# Download the results from the BigQuery table
r_activity_hr <- bq_table_download(tb)

ggplot(data=r_activity_hr, aes(x=avg_hr, y=AsleepHours)) + 
  geom_point(color = "orchid4") +
  geom_smooth(color = "coral2") +
  theme_minimal() + 
  labs(x = "Avg. Heart Rate",
       y = "Asleep Hours",
       caption = "Source: Fitbit data") +
  theme(axis.text = element_text(size = 18),
        axis.title.x = element_text(size = 18, vjust = -2),  # Adjust vertical alignment for X-axis title
        axis.title.y = element_text(size = 18, vjust = 2),
        plot.caption = element_text(size = 10, color = "gray"))
