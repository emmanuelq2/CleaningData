# CleaningData
The R script, run_analysis.R, completes the following steps:

1. Downloading the dataset if it does not already exist in the working directory
2. Loading both the training and test datasets
3. Merging the two datasets
4. Loading the feature file info keeping only columns comprising a mean or standard deviation
5. Loading the activity file and rename activity labels
6. Giving relevant names to subjects data
7. Creating a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair
8. Finally, use data <- read.table("tidy.txt") command in RStudio to read the file. Since there are 6 activities in total and 30 subjecs in total, we have 180 rows with all combinations for each of the 79 features (+ 2 columns for subject and activity)

The data is in "wide" format as described by Wickham; there is a single row for each subject/activity pair, and a single column for each measurement.
