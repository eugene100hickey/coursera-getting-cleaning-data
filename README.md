This run_analysis.R script aims to produce a tidy data set from the suite of data contained within the UCI HAR Dataset.In broad terms, it performs the following steps:
1. Gets the data from the *test* and the *train* directories and mungs them into a suitable format
2. Excludes all columns of measurement that don't concern mean or standard deviation
3. Combines the two data.frames into one large data frame.
4. Gathers the data based on the measurement type.
5. Calculates the mean of the data for each combination of *Activity Type*, *Subject*, and *Measurement Type*.
6. Spreads the data back into a wide data.frame
7. Writes the resulting file into a .txt file



###acknowledgements
1. I used the project from [Deduce](https://github.com/deduce/Getting-and-Cleaning-Data-Project/blob/master/run_analysis.R) last year to produce an output to check against my own. I also learned a lot from the flow of this script.
2. I forked the github repo from [mjlassila](https://github.com/mjlassila/coursera-getting-cleaning-data), this was easier than starting my own repo for this. Didn't use any of his work as a basis for the R scripting, it's just that I am a bit rusty of the process of setting up a repo from scratch.
