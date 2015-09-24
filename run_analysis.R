#> getwd()
# [1] "C:/Users/.../Documents"
# setwd("./R/data")

# filename <- "getdata_dataset.zip"
## Download and unzip the dataset:
# if (!file.exists(filename)){
#   fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
#    download.file(fileURL, filename, method="libcurl") }  
#if (!file.exists("UCI HAR Dataset")) { 
#    unzip(filename) }

# 1. Merges the training and the test sets to create one data set.
trainData <- read.table("X_train.txt")
dim(trainData)
# [1] 7352  561
trainLabel <- read.table("y_train.txt")
dim(trainLabel)
# [1] 7352    1
trainSubject <- read.table("subject_train.txt")
dim(trainSubject) # [1] 7352    1
testData <- read.table("X_test.txt")
dim(testData) # [1] 2947  561
testLabel <- read.table("y_test.txt")
dim(testLabel) # [1] 2947    1
testSubject <- read.table("subject_test.txt")
dim(testSubject) # [1] 2947    1
UData <- rbind(trainData, testData)
dim(UData) # [1] 10299   561
ULabel <- rbind(trainLabel, testLabel)
dim(ULabel) # [1] 10299     1
USubject <- rbind(trainSubject, testSubject)
dim(USubject) # [1] 10299     1

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("features.txt")
dim(features) # [1] 561   2
Selectedfeatures <- grep(".*mean.*|.*std.*", features[,2])
length(Selectedfeatures) # [1] 79
UData <- UData[, Selectedfeatures]
dim(UData) # [1] 10299    79
names(UData) <- features[Selectedfeatures,2]
names(UData) = gsub('-mean', 'Mean', names(UData))
names(UData) = gsub('-std', 'Std', names(UData))
names(UData) <- gsub('[-()]', '', names(UData))
names(UData)
# [1] "tBodyAccMeanX"                "tBodyAccMeanY"                "tBodyAccMeanZ" ...

# 3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
activityLabel <- activity[ULabel[, 1], 2]
# chr [1:10299] "standing" "standing" "standing" "standing" "standing" "standing" ...
# [6005] "walkingdownstairs" "walkingdownstairs" "walkingdownstairs" "walkingdownstairs"...
# [6025] "walkingdownstairs" "walkingdownstairs" "walkingupstairs"   "walkingupstairs"...
# [6049] "walkingupstairs"   "walkingupstairs"   "walkingupstairs"   "standing"...
# [6053] "standing"          "standing"          "standing"          "standing" ...
# [6097] "sitting"           "sitting"           "sitting"           "sitting" ...
# [6129] "laying"            "laying"            "laying"            "laying"  ...
#  [6169] "walking"           "walking"           "walking"           "walking" ...
#  [9997] "laying"            "laying"            "laying"            "laying"           
# [ reached getOption("max.print") -- omitted 299 entries ]
ULabel[, 1] <- activityLabel


# 4. Appropriately labels the data set with descriptive variable names. 
names(ULabel) <- "activity"
names(USubject) <- "subject"
tidyData <- cbind(USubject, ULabel, UData)
dim(tidyData) # [1] 10299    81


# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
library(reshape2)
DataMelted <- melt(tidyData, id = c("subject", "activity"))
DataMeltedMean <- dcast(DataMelted, subject + activity ~ variable, mean)
write.table(DataMeltedMean, "tidy.txt", row.names = FALSE, quote = FALSE)
# data <- read.table("./tidy.txt")
# data[1:18, 1:3]