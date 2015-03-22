# Getting Data Project
Codebook for "Getting and Cleaning Data" course project

Script name: run_analysis.R

## Description of the Experiment
 Experiment consisted of 30 people (21 in training dataset and 7 in test dataset).
 Each person did six exercises (walking, walking upstairs, walking downstairs, sitting, standing and laying).
 Each exercise was repeated multiple times to create a sample for each subject-exercise combination.
 Raw measurements included accelerometer and gyroscope readings.
 Raw measurements were pre-processed to provide accelerations and angular velocities. 
 acting on the subject's bodies in X, Y, and Z axes, along with associated magnitudes.
 For each exercise event, summary statistics (e.g., means and std deviations) were also calculated.

## Original Data Sources
* [Data source] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* [Experiment description] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##  Prior to Running the Script
* Download the zip file and unzip. Move the following files to the working directory.
* subject_train.txt (experiment participant's ID' for each exercise event)
* subject_test.txt (experiment participant's ID' for each exercise event)
* activity_labels.txt (integer code and name of the six types of exerecise)
* features.txt (measurement variable names for each exercise event)
* y_train.txt (activity code for each exercise event)
* y_test.txt (activity code for each exercise event)
* X_train.txt (actual measurement data for each exercise event)
* X_test.txt (actual measurement data for each exercise event)

##  Script Explanation
 The scripts loads the various txt files into dataframes and adds descriptive variable names and activity names.
 Then the dataframes are merged and a subset of variables is pulled (the mean and std deviation of each exercise event).
 Note that "meanFreq" is not in the subset as that is weighted avg of frequency-space components.
 Note that the angle means are not in the subset as they are the angle between mean vectors.
 Then the average of each subject-exercise combination for each measurement variable is determined and written to the output table.
 Output: space-delimited txt file "proj_datatable.txt" written to working directory.

### Details of the Script Blocks
* Read subject codes (values = 1:30) for the study participants.
* Read activity codes (values = 1:6) for each measurement record.
* Read activity names corresponding to the six activity codes.
* Replace activity codes with the activity names (more descriptive).
* Read measurement variable names (see below for details on the variable names).
* Clean up data: correct typo "BodyBody" to "Body."
* Read measurement event data and assign descriptive measurement variable names.
* Determine column index values for "mean()" and "std()" and subset to just those columns.
* Add row index variable to subject, activity and measurement datasets and merge them by the row index.
* Determine mean of each sample, grouped by subject and activity (summarizes the data by group).
* Clean up measurement names: drop "()" from name.
* Write tidy dataset to output table.

## Codebook of Variable Names for Tidy Dataset
* subject:  the integer ID of the study participant
* activity:  description of the exercise activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* measurement names (e.g., tBodyAcc-mean-X, tBodyGyroJerk-mean-X, fBodyAcc-std-Y) built as follows:
* "t" for time-space data or "f" for frequency-space data
* "Body" for forces acting on the body or "Gravity" for forces due to gravity
* "Acc," "AccJerk," "Gyro" or "GyroJerk" to denote acceleration (Acc) or angular velocity (Gyro) and derivative in time (Jerk) signals
* "Mag" to denote the magnitude of the signal (if calculated)
* "mean" or "std" to denote the summary statistic for the exercise event (mean or standard deviation)
* "X,", "Y" or "Z" to denote the axis of the acceleration or velocity (if applicable)

## Additional Notes
* The values in the final tidy dataset are the means of the above variables calculated for each subject-activity-variable combination.
* The summary statistic "meanFreq" is not in the tidy dataset since it is a weighted avg of frequency-space components (not an arithmetic average).
* The angle means are not in the subset as they are the angle between mean vectors (not an arithmetic average).

