# run_analysis.R
#
# Starting from an existing data set, create a tidy data set and output it to
# a 'tidy_data.txt' data file.
#
# The dataset used is derived from the 'Human Activity Recognition Using 
# Smartphones Data Set'(available at https://tinyurl.com/o69d2jl, representing
# data collected from the accellerometers from the Samsung Galaxy S smartphone.
# 
# see README.md for details.

# ----------
## libraries
# ----------
library(dplyr)


## ------------------------------------------------------
## Download and unzip source dataset if not yet available
## ------------------------------------------------------

data.source <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data.file <- "UCI HAR Dataset.zip"
data.dir <- "UCI HAR Dataset"


if (!file.exists(data.file)) {
    download.file(data.source, data.file, mode="wb")
}
if (!file.exists(data.dir)) {
    unzip(data.file)
}

## ---------------
## Read data files
## ---------------

# set data location variables
test.dir <- file.path(data.dir, "test")
train.dir <- file.path(data.dir, "train")

## Load data to R

# read activity labels
activities <- read.table(file.path(data.dir, "activity_labels.txt"), sep=" ", as.is=TRUE)
# read features as character vector
features <- read.table(file.path(data.dir, "features.txt"), sep=" ", as.is=TRUE)

# Extract features representing mean or std
selected.columns <- grepl("(mean\\(\\))|(std\\(\\))", features$V2)
selected.columns.numbers <- which(selected.columns)
selected.columns.names <- features[selected.columns.numbers,2]

# Select columns to read fom data files
selected.columns.type <- selected.columns
selected.columns.type[selected.columns] <- "numeric"
selected.columns.type[!selected.columns] <- "NULL"

# read test data
test.subjects <- read.table(file.path(test.dir, "subject_test.txt"))
test.labels <- read.table(file.path(test.dir, "y_test.txt"))
test.data <- read.table(
    file.path(test.dir, "X_test.txt"), 
    colClasses = selected.columns.type
) # only include mean/std data

# read training data
train.subjects <- read.table(file.path(train.dir, "subject_train.txt"))
train.labels <- read.table(file.path(train.dir, "y_train.txt"))
train.data <- read.table(
    file.path(train.dir, "X_train.txt"), 
    colClasses = selected.columns.type
) # only include mean/std data

# ----------------------------------
## Merge test and training data sets
# ----------------------------------

merged.data <- rbind(
    cbind(test.subjects, test.labels, test.data),
    cbind(train.subjects, train.labels, train.data)
)

# --------------------------------------------
## Do some housekeeping on the merged data set
# --------------------------------------------

# Set column names
colnames(merged.data) <- c("subject", "activity", selected.columns.names)

# subject is a factor
merged.data$subject <- factor(merged.data$subject, ordered=FALSE)
# activity is a factor
merged.data$activity <- factor(
    merged.data$activity,
    levels = activities$V1,
    labels = activities$V2
)

# make the column names more descriptive
column.names <- colnames(merged.data)
column.names <- gsub("^t", "time", column.names)
column.names <- gsub("^f", "frequency", column.names)
column.names <- gsub("Acc", "Accelerometer", column.names)
column.names <- gsub("Gyro", "Gyroscope", column.names)
column.names <- gsub("Mag", "Magnitude", column.names)
# ??BodyBody - let's assume that's a typo
column.names <- gsub("BodyBody", "Body", column.names)
colnames(merged.data) <- column.names

# ---------------------------------------------------------------------------
## Create a dataset with averages of each variable for each activity and each
## subject
# ---------------------------------------------------------------------------

merged.data2 <- merged.data %>%
    group_by(subject, activity) %>%
    summarize_each(funs(mean))

# write to file
write.table(merged.data2, "tidy_data.txt", row.names=FALSE, quote=FALSE)