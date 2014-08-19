Getting and Cleaning Data / Course Project
===========================================

The **raw data** is given by the following zip file:  
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip),  
which was obtained from the following web site:  
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones),  
where the basic information about the raw data is explain.

The **tidy data** is given by the text file "tidy_data.txt" which is produced by the R program "run_analysis.R" and the **Code Book** for the tidy data is given in the file "CodeBook.md". This three files are included on this github repository.

The **pseudocode**, the explicit and exact recipe used to go from the raw data to the tidy data, is:

* Unzip the data from the first link on the same directory where R program "run_analysis.R" is stored, the name of the folder created is "UCI HAR Dataset".  
* Run the R program "run_analysis.R", which have the following steps:
     + Step 0. Set the directory and read the files inside the folder "UCI HAR Dataset". 
     + Step 1. Merges the training and the test sets to create one data set.
     + Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
     + Step 3. Uses descriptive activity names to name the activities in the data set.
     + Step 4. Appropriately labels the data set with descriptive variable names.
     + Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
     + Step 6. Writes a text file "tidy_data.txt" in the same directory from Step 0.
     
The R program "run_analysis.R" has more detailed comments explaining each of the previous steps. 