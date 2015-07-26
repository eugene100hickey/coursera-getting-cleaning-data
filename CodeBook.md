# Code Book for run_analysis.R


 R Programme for the Course Project in Getting and Cleaning Data from Coursera.
 
 Programme accepts biometric data from a Samsung phone and does a Split-Analyse-Combine
 
 Written 26th July 2015

## Variables
*activity_labels*  - these are the 6 different types of activity undertaken by the trial subjects

*features*  - these are the 561 types of measurement taken by the Samsung

*features_mean_std*  - these are the 79 types of measurement of interest, those that involve mean or standard deviation

*Samsung_data*  - a function to read in the data, takes input of a *trial* parameter which in this case will be either test or train. The variables below are internal to *Samsung_data*.

*X_file_name* - set of actual measurements from the Samsung. Has 561 columns corresponding to the different *features*. Will be either X_test.txt or X_train.txt. In the case of X_test, it has 2947 rows.

*y_file_name* - for each of the rows of *X_file_name*,  *y_file_name* give the corresponding activity by number. It has one column. In the case of y_test, it has 2947 rows.

*subject_file_name* - for each of the rows of *X_file_name*,  *subject_file_name* give the corresponding subject by number. These numbers run from 1:30. Nine of them are in test, the rest in train. It has one column. In the case of subject_test, it has 2947 rows.

*X_data* - the data from *X_file_name* in data.frame class. The column names are set to the corresponding values from *features*. *features_mean_std* is used to reduce the number of columns from 561 to 79.

*y_data* - the data from *y_file_name* in data.frame class. The column is given the name "Activities".

*subject_data* - the data from *subject_file_name in data.frame class. The column is given the name "Subjects". In addition a second column is added stating the type of trial; test or train.

*trial_data* - a data.frame produced by binding *subject_data*, *y_data*, and *X_data* in that order. This completes the *Samsung_data* function.



*test_data* - *Samsung_data* data from the directory, test.
*train_data* - *Samsung_data* data from the directory train.

total_data* - binds the data.frames from *test_data* and *train_data*. Rows then ordered by "Subjects" and "Activities". The we add meaningful labels to the activities, Walking instead of 1 for example.

*gathered* - the split data.frame of total_data using the gather() function.

*aggdata* -  the result of applying the mean function to the split data using the aggregate() function.

*tidy_data* - the final data combined from *aggdata* using the spread() function.

