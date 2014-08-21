# Course Project: "Getting and Cleaning Data"

## Step 0
## Set the directory where the file "UCI HAR Dataset" is stored.
setwd("~/Documents/ProgramsR/CourseraClass/003GettingCleaning")
## read the files about: subject, activities and data for "test" and "train"
testsubject<-read.table("./UCI HAR Dataset/test/subject_test.txt",col.names="subject")
testactivity<-read.table("./UCI HAR Dataset/test/y_test.txt",col.names="activity")
testdata<-read.table("./UCI HAR Dataset/test/X_test.txt")
trainsubject<-read.table("./UCI HAR Dataset/train/subject_train.txt",col.names="subject")
trainactivity<-read.table("./UCI HAR Dataset/train/y_train.txt",col.names="activity")
traindata<-read.table("./UCI HAR Dataset/train/X_train.txt")

## Step 1
## Merges the training and the test sets to create one data set.
testmerge<-do.call("cbind",list(testsubject,testactivity,testdata))
trainmerge<-do.call("cbind",list(trainsubject,trainactivity,traindata))
mergedata<-rbind(testmerge,trainmerge)
dim(mergedata)                                ## cheking the dimensions of mergedata
## remove variables that we are not going to use anymore
remove(testsubject,testactivity,testdata,testmerge,trainsubject,trainactivity,traindata,trainmerge)

## Step 2
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## note: mean() are the only real mean related with each measurement / meanFreq() is a weighted average.
features<-read.table("./UCI HAR Dataset/features.txt")
index<-grep("mean\\(|std\\(", features[, 2])   ## features names with mean and std 
mergedata<-mergedata[,c(1,2,index+2)]          ## subset mergedata with mean and std
dim(mergedata)                                 ## cheking the dimensions of mergedata

## Step 3
## Uses descriptive activity names to name the activities in the data set.
activitylabels<-read.table("./UCI HAR Dataset/activity_labels.txt",colClasses="character")
activitylabels[,2]<-sub("_","",activitylabels[,2])     ## delete "_"
activitylabels[,2]<-tolower(activitylabels[,2])        ## lower case alphabet
## note that the number of the row correspond to the number code of the activity
mergedata[,2]<-activitylabels[mergedata[,2], 2]        ## rename activity mergedata
## remove variables that we are not going to use anymore
remove(activitylabels)

## Step 4
## Appropriately labels the data set with descriptive variable names.
features<-features[index,]                             ## names with mean and std
features[,2]<-gsub("\\(\\)", "",features[,2])          ## delete "()"
features[,2]<-gsub("-", "",features[,2])               ## delete "-"
features[,2]<-tolower(features[,2])                    ## lower case alphabet
names(mergedata)[3:68]<-features[,2]
## remove variables that we are not going to use anymore
remove(index,features)

## Step 5 
## Creates a second, independent tidy data set with:
## the average of each variable for each activity and each subject.
for(i in 3:68){
     auxmatrix=tapply(mergedata[,i],list(mergedata$subject,mergedata$activity),mean)  ## average of each variable
     if(i==3) tidydata<-data.frame(do.call("expand.grid",dimnames(auxmatrix)))        ## creates tidydata
     tidydata[,i]<-do.call("rbind",as.list(auxmatrix))                                ## collect average 
}
names(tidydata)<-names(mergedata)    ##names
tidydata<-tidydata[order(tidydata$subject,tidydata$activity),]   ## ordering by subject and activity 
## remove variables that we are not going to use anymore
remove(auxmatrix,i)

## Step 6
## Writes a text file "tidy_data.txt" 
## in the same directory where the file "UCI HAR Dataset" is stored 
write.table(tidydata,file="./tidy_data.txt",row.names=FALSE,col.names=FALSE)