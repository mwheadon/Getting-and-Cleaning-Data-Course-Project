## This script was written to clean the UCI HAR Dataset on Human Activity 
## Recognition using the Samsung Galaxy S II Smartphone. Transformation to the 
## dataset are described in the comments. Additional information on the dataset,
## and the purpose of this script can be found in README.md and CodeBook.md.

library(readr)
library(dplyr)
library(tidyr)
library(stringr)

## Check if messy dataset files exist. If not download files and extract from 
## zip file.

if(!file.exists("./UCI HAR Dataset")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                  "Dataset.zip")
    unzip("Dataset.zip")
}

## Get training dataset and bind information about subject and activity 
## variables.

traindata <- read_table("./UCI HAR Dataset/train/X_train.txt", 
                        col_names = FALSE)

trainactivity <- read_table("./UCI HAR Dataset/train/y_train.txt",
                            col_names = FALSE)
trainsubject <- read_table("./UCI HAR Dataset/train/subject_train.txt", 
                           col_names = FALSE)

traindata <- bind_cols(trainsubject, trainactivity, traindata)

## Get test dataset and bind information about subject and activity variables.

testdata <- read_table("./UCI HAR Dataset/test/X_test.txt", 
                       col_names = FALSE)
testactivity <- read_table("./UCI HAR Dataset/test/y_test.txt",
                           col_names = FALSE)
testsubject <- read_table("./UCI HAR Dataset/test/subject_test.txt", 
                          col_names = FALSE)

testdata <- bind_cols(testsubject, testactivity, testdata)

## Merge data from training and test datasets 

mergeddata <- bind_rows(testdata, traindata)

measurement_columns <- read_delim("./UCI HAR Dataset/features.txt", delim = " ", 
                         col_names = FALSE)

colnames(mergeddata) <- c("Subject", "Activity", measurement_columns$X2)

## Select only the columns with information on mean or standard deviation for
## each measurement. Also keep columns for subject ID and activity variables.

relevant_index <- c(1, 2, grep("mean|std", colnames(mergeddata)))

relevantdata <- mergeddata[, relevant_index] 

## Tidy up the column names.
colnames(relevantdata) <- colnames(relevantdata) %>%
    str_replace("\\(\\)", "") %>%
    str_replace("-mean", "Mean") %>%
    str_replace("-std", "Std")

## Rename Activity labels with informative values. In other words replace a 
## integer value with a descriptive character value.

activity_key <- read_delim("./UCI HAR Dataset/activity_labels.txt", 
                           col_names = FALSE, delim = " ")
new_activity <- as.character(sapply(relevantdata$Activity, 
                       function(x) {x = activity_key[x, 2]}))
    
relevantdata <- mutate(relevantdata, Activity = new_activity)

## Now to summarize the new tidy dataset!
summarydata <- relevantdata %>%
    group_by(Subject, Activity) %>%
    summarise_all(mean)

write.table(summarydata, "tidy.txt", row.names = FALSE)