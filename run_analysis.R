library(dplyr)
setwd("C:/Users/Eugene/Desktop/Coursera/Getting and Cleaning Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")


activity_labels <- read.table("./activity_labels.txt")$V2
features <- read.table("./features.txt")$V2
features_mean_std <- grepl("mean|std", features)


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

test_data = Samsung_data("test")
train_data = Samsung_data("train")
total_data = rbind(test_data, train_data)
total_data = arrange(total_data, Subjects, Activities)

total_data$Activities = activity_labels[total_data$Activities]

gathered = gather(total_data, Variables, Measurements, -Subjects, -Activities, -trial)

aggdata = aggregate(gathered$Measurements, by=list(Subjects = gathered$Subjects,Activities = gathered$Activities, Variables = gathered$Variables, TestOrTrain = gathered$trial), FUN=mean)

tidy_data = spread(aggdata, Variables, x)

write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)

