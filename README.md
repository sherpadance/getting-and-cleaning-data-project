# Coursera - Getting and Cleaning Data Course Project

One of the most exiting areas in data science is wearable computing. See, for 
instance [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike and Jawbone are racing
to develop the most advanced algorithms to attract new users.

This project develops a tidy dataset starting from an existing dataset representing
data collected from the accelerometers from the Samsung Galaxy S smartphone. A
full description is available at [Human Activity Recognition Using Smartphones Data Set  ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) webpage.

This repository comprises the following files:

* `README.md`, this file, which provides context and background to the project, background information on the source data used for the project, the transformations applied to this source data and the resulting tidy data set;
* `run_analyis.R`, the R script that was used to create the tidy data set, see [creating the tidy data set](#CreatingTheDataSet);
* `codebook.md`, describing the contents of the dataset;
* `tidy_data.txt`, the resulting tidy data set.

## Source data

The source data for the project was downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

### Data set information

The [Human Activity Recognition Using Smartphones Data Set  webpage](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) provides the following information on the dataset:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## <a name="CreatingTheDataSet"></a>Creating the tidy data set

The R script `run_analysis.R` can be used to create the ´tidy_data.txt` data set. 

The script performs the following actions:

* downloads and extracts the source ZIP file (if not already present in the working directory);
* reads the datafiles; taking care only to load standard deviation and mean measurements for each measurement included in the dataset;
* merges test and training datasets;
* cleans up the resulting merged data set by:
    * Setting descriptive column names;
    * Coding factor variables as factors;
* creates a second merged dataset, containing only averages of each variable for each subject and activity;
* stores this second dataset in a `tidy_data.txt` file.

The `tidy_data.txt`dataset is described in the `codebook.md`codebook.

The `tidy_data.txt`file in this repository was created by sourcing the `run_analysis.R` script using R version 3.3.3 (2017-03-06) running on Microsoft Windows 10 Pro 64 bit. It is dependent on the `dplyr`library (version 0.5.0 was used).

## Reference

The following reference refers to the original data set used in this analysis:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.