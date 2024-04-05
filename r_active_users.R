library(bigrquery)
library(tidyverse)

# Specify the path to your service account key file
json_path <- "json service account key"

# Authenticate with Google Cloud using the service account key
bq_auth(path = json_path)

# Set your BigQuery project ID
project <- "data-analyst-course-1"

# Set your SQL query
sql <- "SELECT * FROM `data-analyst-course-1.case_study.r_active_users`"

# Run the query and store the result in a BigQuery table
tb <- bq_project_query(project, sql)

# Download the results from the BigQuery table
r_active_users <- bq_table_download(tb)

# Create the time series plot
ggplot(r_active_users, aes(x = Activitydate, y = User_count, color = reorder(ActiveCategory, desc(User_count)))) +
  geom_smooth(se = FALSE, method = "loess", size = 1) +
  scale_color_manual(values = c("orchid4", "coral2", "#4daf4a", "#377eb8"), name = NULL) +
  theme_minimal() + 
  labs(x = "Activity date", y = "User count", caption = "Source: Fitbit data") +
  theme(axis.text = element_text(size = 18),
        axis.title.x = element_text(size = 18, vjust = -2),  # Adjust vertical alignment for X-axis title
        axis.title.y = element_text(size = 18, vjust = 2),
        legend.text = element_text(size = 18),
        plot.caption = element_text(size = 10, color = "gray")) +
  guides(color = guide_legend(keyheight = unit(2, "lines")))
  
