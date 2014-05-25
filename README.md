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


