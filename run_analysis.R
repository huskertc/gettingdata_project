#  Script name: run_analysis.R
#  Rev date: 03/2015
#  Requires dplyr package
#
#  Output: space-delimited txt file "proj_datatable.txt" written to working directory.
#
#  Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#  Experiment description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#  Notes on data files:
#  After unzipping, read file "README.txt" (description of the experiment and the data files).
#  File "features_info.txt" describes the measurements taken for each exercise event.
#  Files "subject_train.txt" and "subject_test.txt" contain subject (people) ID's for each exercise event.
#  File "activity_labels.txt" contains the integer code and name of the six types of exerecise.
#  File "features.txt" contains the measurement variable names for each exercise event.
#  Files "y_train.txt" and "y_test.txt" contain the activity code for each exercise event.
#  Files "X_train.txt" and "X_test.txt" contain the actual measurement data for each exercise event.
#
#  Notes on data pre-prep:
#  Move the following files to the working directory:
#	subject_train.txt
#	subject_test.txt
#	activity_labels.txt
#	features.txt
#	y_train.txt
#	y_test.txt
#	X_train.txt
#	X_test.txt
#
#  Notes on experiment and data pre-processing:
#  Experiment consisted of 30 people (21 in training dataset and 7 in test dataset).
#  Each person did six exercises (walking, walking upstairs, walking downstairs, sitting, standing and laying).
#  Each exercise was repeated multiple times to create a sample for each subject-exercise combination.
#  Raw measurements included accelerometer and gyroscope readings.
#  Raw measurements were pre-processed to provide accelerations and angular velocities 
#  acting on the subject's bodies in X, Y, and Z axes, along with associated magnitudes.
#  For each exercise event, summary statistics (e.g., means and std deviations) were also calculated.
#
#  Script explanation:
#  The scripts loads the various txt files into dataframes and adds descriptive variable names and activity names.
#  Then the dataframes are merged and a subset of variables is pulled (mean and std deviation of each exercise event).
#  Note that "meanFreq" is not in the subset as that is weighted avg of frequency-space components.
#  Note that the angle means are not in the subset as they are the angle between mean vectors.
#  Then the average of each subject-exercise-measurement combination is determined and written to the output table.
#
#
# Start of script
#
# Read subject codes (values = 1:30) for the study participants.
subject_train <- read.table("subject_train.txt", col.names="subject")
subject_test <- read.table("subject_test.txt", col.names="subject")
subject <- rbind(subject_train,subject_test)
#
#  Read activity codes (values = 1:6) for each measurement record.
activity_train <- read.table("y_train.txt", col.names="activity")
activity_test <- read.table("y_test.txt", col.names="activity")
activity <- rbind(activity_train, activity_test)
#
#  Read activity names corresponding to the six activity codes.
activity_label <- read.table("activity_labels.txt", sep="", stringsAsFactors=FALSE, col.names=c("activity_code","activity"))
#
#  Replace activity codes with the activity names.
for (i in 1:nrow(activity)) { activity[i,] <- activity_label[activity[i,],2] }
#
#  Read measurement variable names.
meas_label <- read.table("features.txt", sep="", stringsAsFactors=FALSE, col.names=c("meas_code","meas_name"))
#
#  Correct typo "BodyBody" to "Body"
meas_label$meas_name <- gsub("BodyBody", "Body", meas_label$meas_name)
#
#  Read measurement event data and assign measurement variable names.
meas_train <- read.table("X_train.txt", sep="")
meas_test <- read.table("X_test.txt", sep="")
meas <- rbind(meas_train, meas_test)
names(meas) <- meas_label[,2]
#
#  Determine column index values for "mean()" and "std()"
#  Note: do not include "meanFreq" as that is weighted avg of frequency-space components.
#  Note: do not include angle means as that is angle between mean vectors.
meas_mean_index <- data.frame (col_index = grep("mean\\(\\)",colnames(meas)))
meas_stdev_index <- data.frame (col_index = grep("std\\(\\)",colnames(meas)))
meas_subset_index <- data.frame(rbind(meas_mean_index, meas_stdev_index))
#
#  Subset measurement dataset to select "mean()" and "std()" columns
#  This is the summary statistics of interest for each measurement event
meas_subset <- meas[,meas_subset_index$col_index]
#
#  Add row index variable to subject, activity and measurement datasets
subject$index <- seq(along=subject$subject)
activity$index <- seq(along=activity$activity)
meas_subset$index <- seq(along=meas_subset[,1])
#
#  Merge the subject, activity and measurement datasets by row indices
merge_subj_act <- merge(subject, activity, by.x="index", by.y="index")
merge_meas <- merge(merge_subj_act, meas_subset, by.x="index", by.y="index")
merge_meas[,1] <- NULL      # drop index column
#
#  Determine mean of each sample, grouped by subject and activity
#  This summarizes the sample of measurement events for the above grouping
library(dplyr)
meas_summary <- merge_meas %>% group_by(subject, activity) %>% summarise_each(funs(mean))
#
#  Clean up measurement names: drop "()" from name
names(meas_summary) <- gsub("\\(\\)","",names(meas_summary))
#
#  Write to output table
write.table(meas_summary, file="proj_datatable.txt", sep = " ", row.names=FALSE)
#
print ("done processing")
#  End
