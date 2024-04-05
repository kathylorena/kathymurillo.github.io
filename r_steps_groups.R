library(bigrquery)
library(tidyverse)

# Specify the path to your service account key file
json_path <- "json service account key"

# Authenticate with Google Cloud using the service account key
bq_auth(path = json_path)

# Set your BigQuery project ID
project <- "data-analyst-course-1"

# Set your SQL query
sql <- "SELECT * FROM `data-analyst-course-1.case_study.r_steps_groups`"

# Run the query and store the result in a BigQuery table
tb <- bq_project_query(project, sql)

# Download the results from the BigQuery table
r_steps_groups <- bq_table_download(tb)

ggplot(data=r_steps_groups, aes(reorder(x=avg_steps_group,step_order), y=user_count)) +
  geom_col(fill = "orchid4") +
  theme_minimal() + 
  labs(x = "Avg. steps",
       y = "User count",
       caption = "Source: Fitbit data") +
  theme(axis.text = element_text(size = 18),
        axis.title.x = element_text(size = 18, vjust = -2),  # Adjust vertical alignment for X-axis title
        axis.title.y = element_text(size = 18, vjust = 2),
        plot.caption = element_text(size = 10, color = "gray"))
