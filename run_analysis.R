# Coursera Getting and Cleaning Data Course Project

#The purpose of this project is to demonstrate your ability to collect, work with, and 
#clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
#You will be graded by your peers on a series of yes/no questions related to the project. 
#You will be required to submit: 
#1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables, the data, and any transformations or 
#work that you performed to clean up the data called CodeBook.md. 

#You should also include a README.md in the repo with your scripts. 
#This repo explains how all of the scripts work and how they are connected.  

# One of the most exciting areas in all of data science right now is wearable computing - 
# see for example this article . Companies like Fitbit, Nike, and Jawbone Up are 
# racing to develop the most advanced algorithms to attract new users. 
# The data linked to from the course website represent data collected from the 
# accelerometers from the Samsung Galaxy S smartphone. A full description is available 
# at the site where the data was obtained: 

#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#Here are the data for the project: 

#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.  
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.

setwd("/Users/mdeleo/Github/Getting and Cleaning Data");

# 1. Merges the training and the test sets to create one data set.

# Read in the data from files


xTrain <- read.table("./train/X_train.txt",header=FALSE);
yTrain <- read.table("./train/y_train.txt",header=FALSE); 
features <- read.table("./features.txt",header=FALSE);
activityType <- read.table("./activity_labels.txt",header=FALSE); 
subjectTrain <- read.table("./train/subject_train.txt",header=FALSE); 

# Assign column names
colnames(activityType) <- c("activityId","activityType");
colnames(subjectTrain) <- "subjectId";
colnames(xTrain) <- features[,2]; 
colnames(yTrain) <- "activityId";

# Create the final training set
trainingData = cbind(yTrain,subjectTrain,xTrain);

# Read in the test data sets
subjectTest <- read.table("./test/subject_test.txt",header=FALSE); 
xTest <-read.table("./test/X_test.txt",header=FALSE); 
yTest <-read.table("./test/y_test.txt",header=FALSE); 

# Assign column names to the test data
colnames(subjectTest) <- "subjectId";
colnames(xTest) <- features[,2]; 
colnames(yTest) <- "activityId";

# Create the final test data 
testData <- cbind(yTest,subjectTest,xTest);

# Combine training and test data to create a final data set
FinalData <- rbind(trainingData,testData);

# Create a vector for the column names from the FinalData, which will be used
# to select the desired mean() & stddev() columns
colnames  <- colnames(FinalData); 

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.  

# Create a list for TRUE values mean() & stddev() columns
logicalList <- (grepl("activity..",colnames) | grepl("subject..",colnames) | grepl("-mean..",colnames) & !grepl("-meanFreq..",colnames) & !grepl("mean..-",colnames) | grepl("-std..",colnames) & !grepl("-std()..-",colnames));

# Subset FinalData table based on the logicalList to keep only desired columns
FinalData <- FinalData[logicalList==TRUE];

# 3. Uses descriptive activity names to name the activities in the data set

FinalData <- merge(FinalData,activityType,by="activityId",all.x=TRUE);

# Updating the colnames 
colnames <- colnames(FinalData); 

# 4. Appropriately labels the data set with descriptive variable names. 

# Assigning the  column names to the FinalData set
colnames(FinalData) <- colnames;

# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.

# Create a new table, FinalDataNoActivityType without the activityType column
FinalDataNoActivityType <- FinalData[,names(FinalData) != "activityType"];

# Summarizing the FinalDataNoActivityType table to include just the mean 
TidyData <- aggregate(FinalDataNoActivityType[,names(FinalDataNoActivityType) != c("activityId","subjectId")],by=list(activityId=FinalDataNoActivityType$activityId,subjectId = FinalDataNoActivityType$subjectId),mean);

# Merging  to include descriptive acitvity names
TidyData <- merge(TidyData,activityType,by="activityId",all.x=TRUE);

# Export the TidyData set 
write.table(TidyData, "./TidyDataSamsung.txt",row.names=FALSE,sep="\t");
