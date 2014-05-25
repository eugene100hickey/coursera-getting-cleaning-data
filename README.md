coursera-getting-cleaning-data
==============================

Repository for Getting and Cleaning Data Course Project.

### run_analysis.R

When sourced, the script displays instuctions for running data download and processing functions.
The script checks if the required R packages are installed and tries to install them
if previous installation is not found.

```r
source('./run_analysis.R')
download.data()
run.analysis()
```

In the case the Samsung data is already unzipped and directory with the dataset is available as
 `UCI HAR Dataset` subdirectory of the current directory, the processing function `run.analysis()` can be 
 called straight away.


## Processing steps

1. When sourced, the script chechs if the required R packages are available and proceeds to install them if they are not found
2. Calling download.data() downloads the zipped dataset and unarchives it.
3. Calling run.analysis() starts the actual data processing:
   1. Feature vector label data is loaded from `features.txt`
   2. Using regex with grepl, subset of label data for selecting desired data coluns is created. 
   3. Activity labels are loaded from `features.txt`
   4. Activity labels (id->label) and selected features (id->label) are given as parameters to function which loads the training or test dataset, based on the type value given also as a parameter.
       1. Paths to data files are created based on type parameter
       2. Data files are loaded. Feature vector data is filtered using ids of the selected features.
       3. Activity and subject id data are loaded
       4. Feature vector data is renamed using the names of selected features
       5. Activies and subjects are given labels using factor levels of activity and subject id data.
       6. Finally, processed dataset is returned.
   5. (The previous processing is repeated to both training and test datasets.)
   6. Training and test datasets are merged using `rbind()` and converted to `data.table` to make it easier to do groupwise operations in the following step
   7. Mean is calculated for all variables for each activity and subject
   8. Variable names are loaded to separate vector and  tidied to follow camelCase-convention. 
   9. New names are applied to dataset
   10. Tidy dataset is written to disk.

