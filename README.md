# Getting Data Project
Description of script for "Getting and Cleaning Data" course project

Script name: run_analysis.R
Rev date: 03/2015
Requires dplyr package

## Original Data Sources
* [Data source] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* [Experiment description] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##  Notes on Data Files
*  After unzipping, read file "README.txt" (description of the experiment and the data files).
*  File "features_info.txt" describes the measurements taken for each exercise event.
*  Files "subject_train.txt" and "subject_test.txt" contain subject (people) ID's for each exercise event.
*  File "activity_labels.txt" contains the integer code and name of the six types of exerecise.
*  File "features.txt" contains the measurement variable names for each exercise event.
*  Files "y_train.txt" and "y_test.txt" contain the activity code for each exercise event.
*  Files "X_train.txt" and "X_test.txt" contain the actual measurement data for each exercise event.

##  Location of Data Files for Script
Move the following files to the working directory prior to running the "run_analysis.R" script in the working directory
* subject_train.txt
* subject_test.txt
* activity_labels.txt
* features.txt
* y_train.txt
* y_test.txt
* X_train.txt
* X_test.txt

## Notes on Experiment and Data Pre-Processing
 Experiment consisted of 30 people (21 in training dataset and 7 in test dataset).
 Each person did six exercises (walking, walking upstairs, walking downstairs, sitting, standing and laying).
 Each exercise was repeated multiple times to create a sample for each subject-exercise combination.
 Raw measurements included accelerometer and gyroscope readings.
 Raw measurements were pre-processed to provide accelerations and angular velocities 
 acting on the subject's bodies in X, Y, and Z axes, along with associated magnitudes.
 For each exercise event, summary statistics (e.g., means and std deviations) were also calculated.

 See CodeBook.md for a description of the variables and data analysis steps for this project.

##  Script explanation
 The scripts loads the various txt files into dataframes and adds descriptive variable names and activity names.
 Then the dataframes are merged and a subset of variables is pulled (mean and std deviation of each exercise event).
 Note that "meanFreq" is not in the subset as that is weighted avg of frequency-space components.
 Note that the angle means are not in the subset as they are the angle between mean vectors.
 Then the average of each subject-exercise-measurement combination is determined and written to the output table.
 Output: space-delimited txt file "proj_datatable.txt" written to working directory.
