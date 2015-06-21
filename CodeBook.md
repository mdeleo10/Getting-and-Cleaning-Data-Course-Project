# Getting and Cleaning Data Project
Getting and Cleaning Data Project

## Introduction
The R script performs 5 steps, please refer to the README.md

First read the data sets and merge using rbind(). Column names are assigned and creates one data set.

Then the columns with ID, mean and standard deviation are taken into a list.

Labels are assigned to activities that are descriptive.

Last, the tidy data set for Samsung phones is created with the average of each variable for each activity and each subject.

##
The files downloaded contain the following input files:
features.txt, activity_labels.txt, subject_train.txt, x_train.txt, y_train.txt, subject_test.txt, x_test.txt, y_test.txt



## Variables
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.

FinalData is the final data set

TinyData contains the data that will be exported to the TidyDataSamsung.txt file
