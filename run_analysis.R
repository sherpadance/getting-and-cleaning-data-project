# run_analysis.R transforms the dataset downloaded using downloadData() to meet
# the coursera data science assignment "Getting and Cleaning Data".
# 
# run_analyis.R:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#
# run_analysis.R assumes the project dataset is found in a 'Data/UCI HAR dataset'
# subdirectory of the project's working directory. This condition can be met by
# running the seperate downloadData() function (source downloadData.R)

# ------------------------------------------------------------------------------

# Load libraries
library(plyr)


# set data location variables
dataDir <- file.path(getwd(), "Data","UCI HAR Dataset")
testDir <- file.path(dataDir, "test")
trainDir <- file.path(dataDir, "train")

## Load data to R

# read activity labels
activityLabels <- read.table(file.path(dataDir, "activity_labels.txt"), sep=" ")
# read features
features <- read.table(file.path(dataDir, "features.txt"), sep=" ")

# read test data - subjects
testSubjects <- read.table(file.path(testDir, "subject_test.txt"))
# read training data - subjects
trainSubjects <- read.table(file.path(trainDir, "subject_train.txt"))

# read test labels
testLabels <- read.table(file.path(testDir, "y_test.txt"))

# read training labels
trainLabels <- read.table(file.path(trainDir, "y_train.txt"))

## For data - only read mean/std values

# find column numbers with mean/std values
colNumbers_mean <- which(grepl("mean\\(\\)", features$V2))
colNumbers_std <- which(grepl("std\\(\\)", features$V2))

# get variable names, remove mean()/std()
colNames_mean <- gsub("-mean\\(\\)-*", "", features[colNumbers_mean,2])
colNames_std <- gsub("-std\\(\\)-*", "", features[colNumbers_std, 2])
# these should be the same - if not: throw error!
if(!identical(colNames_mean, colNames_std)) {stop("Feature order mean/std does not match.")}

# Prep col.names to select columns to read
col_mean <- grepl("mean\\(\\)", features$V2)
col_std  <- grepl("std\\(\\)", features$V2)
colSelection_mean <- col_mean
colSelection_std <- col_std
colSelection_mean[col_mean] <- "numeric"
colSelection_mean[!col_mean] <- "NULL"
colSelection_std[col_std] <- "numeric"
colSelection_std[!col_std] <- "NULL"

# read test data - dataset
testData_mean <- read.table(file.path(testDir, "X_test.txt"), colClasses = colSelection_mean)
testData_std <- read.table(file.path(testDir, "X_test.txt"), colClasses = colSelection_std)

# read training data - dataset
trainData_mean <- read.table(file.path(trainDir, "X_train.txt"), colClasses = colSelection_mean)
trainData_std <- read.table(file.path(trainDir, "X_train.txt"), colClasses = colSelection_std)

## Do some housekeeping on the imported data

# rename subject column names
colnames(testSubjects) <- "subject"
colnames(trainSubjects) <- "subject"
# Subject names are factors
testSubjects$subject <- factor(testSubjects$subject, ordered=FALSE)
trainSubjects$subject <- factor(trainSubjects$subject, ordered=FALSE)

# rename labels column names
colnames(testLabels) <- "activity"
colnames(trainLabels) <- "activity"
# activity is a factor
testLabels$activity <- factor(testLabels$activity, ordered=FALSE)
trainLabels$activity <- factor(trainLabels$activity, ordered=FALSE)

# rename labels for activities
testLabels$activity <- mapvalues(testLabels$activity, activityLabels$V1, as.vector(activityLabels$V2))
trainLabels$activity <- mapvalues(trainLabels$activity, activityLabels$V1, as.vector(activityLabels$V2))
