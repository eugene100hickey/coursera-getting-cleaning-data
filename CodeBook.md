# Code Book for run_analysis.R
## Variables

 R Programme for the Course Project in Getting and Cleaning Data from Coursera
 Programme accepts biometric data from a Samsung phone and does a Split-Analyse-Combine
 Written 26th July 2015


activity_labels  - these are the 6 different types of activity undertaken by the trial subjects
features  - these are the 561 types of measurement taken by the Samsung
features_mean_std  - these are the 79 types of measurement of interest, those that involve mean or standard deviation


Samsung_data  - a function to read in the data
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

