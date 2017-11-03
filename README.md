# Getting and Cleaning Data Course Project
This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1. Download the Dataset and unzip the data.
2. Load the data into R with read.table and merge the train and test datas
3. Look for the columns that has means, standard deviations, activityID and subjectID with grepl
4. Merge the data resulting for the step 3 with activity labels
5. Merge the data resulting for the step 4 with subjectID
6. Create the tidy dataset
