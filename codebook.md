# Code book for the getting and cleaning data course project

This codebook describes the `tidy_data.txt`data set. The original source data and the transformations performed to  create this dataset are described in the [source data and transformations](#SourceAndTransformations) section. The data structure and variables included in the dataset are described in the [variables](#Variables) section.

##<a href="Variables"></a>Variables

Each row in `tidy_data.txt` contains the average value of a set of signal measurements calculated across all measurements available in the source data set for a given subject performing a given activity. For details on how these measurements were created, please consult the `features_info.txt`file supplied with the source data.

### Identifiers

* `subject`: Subject identifier. An integer value ranging from 1 to 30.
* `activity`: Character string, one of 6 possible values:
    * `WALKING`
    * `WALKING_UPSTAIRS`
    * `WALKING_DOWNSTAIRS`
    * `SITTING`
    * `STANDING`
    * `LAYING`
    
### Measurements

All measurements are floating point values, normalized and bounded within [-1,1]. Prior to normalization, acceleration measurements were made in standard gravity units 'g', and angular velocity measurements were made in radians/second.

#### Time-domain signals

* Average and standard deviation of the time-domain body and gravity acceleration signals in the X, Y and Z directions:
    * `timeBodyAccelerometer-mean()-X`
    * `timeBodyAccelerometer-mean()-Y`
    * `timeBodyAccelerometer-mean()-Z`
    * `timeBodyAccelerometer-std()-X`
    * `timeBodyAccelerometer-std()-X`
    * `timeBodyAccelerometer-std()-X`
    * `timegravityAccelerometer-mean()-X`
    * `timegravityAccelerometer-mean()-Y`
    * `timegravityAccelerometer-mean()-Z`
    * `timegravityAccelerometer-std()-X`
    * `timegravityAccelerometer-std()-X`
    * `timegravityAccelerometer-std()-X`
* Average and standard deviation of the body acceleration jerk signals (derivative of body acceleration in time) in the X, Y and Z direction:
    * `timeBodyAccelerometerJerk-mean()-X`
    * `timeBodyAccelerometerJerk-mean()-Y`
    * `timeBodyAccelerometerJerk-mean()-Z`
    * `timeBodyAccelerometerJerk-std()-X`
    * `timeBodyAccelerometerJerk-std()-Y`
    * `timeBodyAccelerometerJerk-std()-Z`
* Average and standard deviation of the body angular velocity signals in the X, Y and Z directions:
    * `timeBodyGyroscope-mean()-X`
    * `timeBodyGyroscope-mean()-Y`
    * `timeBodyGyroscope-mean()-Z
    * `timeBodyGyroscope-std()-X`
    * `timeBodyGyroscope-std()-Y`
    * `timeBodyGyroscope-std()-Z`
* Average and standard deviation of the body angular velocity jerk signals (derivative of angular velocity in time) in the X, Y and Z directions:
    * `timeBodyGyroscopeJerk-mean()-X`
    * `timeBodyGyroscopeJerk-mean()-Y`
    * `timeBodyGyroscopeJerk-mean()-Z`
    * `timeBodyGyroscopeJerk-std()-X`
    * `timeBodyGyroscopeJerk-std()-Y`
    * `timeBodyGyroscopeJerk-std()-Z`
* Average and standard deviation of the magnitude of the time-domain body and gravity acceleration:
    * `timeBodyAccelerometerMagnitude-mean()`
    * `timeBodyAccelerometerMagnitude-std()`
    * `timeGravityAccelerometerMagnitude-mean()`
    * `timeGravityAccelerometerMagnitude-std()`
* Average and standard deviation of the magnitude of the time-domain body acceleration jerk:
    * `timeBodyAccelerometerJerkMagnitude-mean()`
    * `timeBodyAccelerometerJerkMagnitude-std()`
* Average and standard deviation of the magnitude of the time-domain body angular velocity:
    * `timeBodyGyroscopeMagnitude-mean()`
    * `timeBodyGyroscopeMagnitude-std()`
* Average and standard deviation of the magnitude of the time-domain body angular velocity jerk:
    * `timeBodyGyroscopeJerkMagnitude-mean()`
    * `timeBodyGyroscopeJerkMagnitude-std()`

#### Frequency-domain signals

FFT applied to some of the time-domain signals included above:

* `frequencyBodyAccelerometer-mean()-X`
* `frequencyBodyAccelerometer-mean()-Y`
* `frequencyBodyAccelerometer-mean()-Z`
* `frequencyBodyAccelerometer-std()-X`
* `frequencyBodyAccelerometer-std()-Y`
* `frequencyBodyAccelerometer-std()-Z`

* `frequencyBodyAccelerometerJerk-mean()-X`
* `frequencyBodyAccelerometerJerk-mean()-Y`
* `frequencyBodyAccelerometerJerk-mean()-Z`
* `frequencyBodyAccelerometerJerk-std()-X`
* `frequencyBodyAccelerometerJerk-std()-Y`
* `frequencyBodyAccelerometerJerk-std()-Z`
    
* `frequencyBodyGyroscope-mean()-X`
* `frequencyBodyGyroscope-mean()-Y`
* `frequencyBodyGyroscope-mean()-Z`
* `frequencyBodyGyroscope-std()-X`
* `frequencyBodyGyroscope-std()-Y`
* `frequencyBodyGyroscope-std()-Z`

* `frequencyBodyAccelerometerMagnitude-mean()`
* `frequencyBodyAccelerometerMagnitude-std()`
    
* `frequencyBodyAccelerometerJerkMagnitude-mean()`
* `frequencyBodyAccelerometerJerkMagnitude-std()`
    
* `frequencyBodyGyroscopeMagnitude-mean()`
* `frequencyBodyGyroscopeMagnitude-std()`
    
* `frequencyBodyGyroscopeJerkMagnitude-mean()`
* `frequencyBodyGyroscopeJerkMagnitude-std()`

##<a href="SourceAndTransformations"></a>Source data and transformations

The source data for the project was downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The following transformations were applied to the source data:

* Mean() and std() measurements were imported from the original data set
* Training and test data were merged in a single dataset
* Activity codings (integer values) were converted to descriptive activity names
* Column names were replaced with descriptive variable names
* The final data set was produced by averaging each variable after grouping per subject and activity.

For more details, see the `README.md`file.