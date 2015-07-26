# R Programme for the Course Project in Getting and Cleaning Data from Coursera
# Programme accepts biometric data from a Samsung phone and does a Split-Analyse-Combine
# Written 26th July 2015

# Just some initial stuff to get going
library(dplyr)
setwd("C:/Users/Eugene/Desktop/Coursera/Getting and Cleaning Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")


# These are the features that are useful for both test and train data
# features_info.txt and README.txt in the working directory have more information
# activity_labels describe six types of activity
# features are 561 types of measurement from the phone, 79 of which are of interest
activity_labels <- read.table("./activity_labels.txt")$V2
features <- read.table("./features.txt")$V2
features_mean_std <- grepl("mean|std", features)


# the data are stored in two directories, one for test data, the other for train data
# both test and train are in the same format
# the function Samsung_data takes an input location, either test or train
# in reads in and parses the data
Samsung_data <- function(trial){
  X_file_name = paste("./", trial, "/X_", trial, ".txt", sep = "")
  y_file_name = paste("./", trial, "/y_", trial, ".txt", sep = "")
  subject_file_name = paste("./", trial, "/subject_", trial, ".txt", sep = "")
  
  X_data <- read.table(X_file_name)
  names(X_data) <- features
  X_data_meanstd = X_data[, features_mean_std]
  
  y_data <- read.table(y_file_name)
  names(y_data) = c("Activities")
  
  
  subject_data <- read.table(subject_file_name)
  names(subject_data) = c("Subjects")
  subject_data$trial = trial
  
  trial_data = cbind(subject_data, y_data, X_data_meanstd)
  
  trial_data
}

# Runs the Samsung_data function to read in data from test and train
test_data = Samsung_data("test")
train_data = Samsung_data("train")

# Combines and arranges the data from test and train
total_data = rbind(test_data, train_data)
total_data = arrange(total_data, Subjects, Activities)


# adds meaningful labels to the activities, Walking instead of 1 for example
total_data$Activities = activity_labels[total_data$Activities]

# Splits the data using the gather function
gathered = gather(total_data, Variables, Measurements, -Subjects, -Activities, -trial)

# Applies the mean function to the split data using the aggregate function
aggdata = aggregate(gathered$Measurements, by=list(Subjects = gathered$Subjects,Activities = gathered$Activities, Variables = gathered$Variables, TestOrTrain = gathered$trial), FUN=mean)

# Combines the data using the spread function
tidy_data = spread(aggdata, Variables, x)

# Writes the data to file
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)

