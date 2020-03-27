---
title: "CodeBook.md"
---

## Introduction
This CodeBook describes the transformations and varibles in run_analysis.R

## Section 1: Download raw data files
This section of code checks to see if the necessary files exist, and if not 
downloads them using the appropriate url. 
The downloaded files are .zip, and therefore the UCI HAR Dataset, is extracted 
with the unzip function.

## Section 2: Collating the Training Dataset
Variable information for the training dataset is stored in multiple files. The 
purpose of this section of code is to collate this data into a single table.

**traindata** : initially, this is just the measurements taken from the 
smartphones, read from file X_train.txt.
But after this section of code processes, it will also have the subject id, and 
activity variables bound to it. 

**trainactivity** : this is a column of data indicating the activities that were 
performed for each measurement in traindata.
read from file y_train.txt.

**trainsubject** : this is a column of data indicating the subject who performed 
each activity and was measured.
read from file subject_train.txt.

## Section 3: Collating the Test Dataset
Like the above mentioned training dataset, the test dataset variable information 
is stored in multiple files. The purpose of this section of code is to collate 
all this data into a single table.

**testdata** : initially, this is just the measurements taken from the 
smartphones, read from file X_test.txt.
But after this section of code processes, it will also have the subject id, and 
activity variables bound to it.

**testactivity** : this is a column of data indicating the activities that were 
performed for each measurement in traindata.
read from file y_test.txt.

**testsubject** : this is a column of data indicating the subject who performed 
each activity and was measured.
read from file subject_test.txt.

## Section 4: Merging Training and Test Datasets
This section of code merges the training and test datasets.

**mergeddata** : this is the row binding of training and test datasets.

**measurement_columns** : This is the column labels for the measurements taken 
from the smartphones. 
read from file features.txt.
The measurement columns along with the labels Subject and Activity (for the 
first two columns) are bound to the mergeddata using the colnames() function.

## Section 5: Selecting only relevant data
Not all the data in mergeddata are relevant to downstream analysis. This section
of code selects out from the merged dataset only the measurement columns related
to mean and standard deviation (std).

**relevant_index** : this is the indecies from mergeddata that contain 
information that is relevant to the downstream analyis. Therefore, they 
correspond to the columns containing Subject ID, Activity Labels, and all 
columns with measurements of mean or std.

**relevantdata** : this is only the relevant columns of data, obtained by 
applying the relevant_index to mergeddata.

## Section 6: Tidying Column Names
Many of the column names specified by measurement_columns in the raw data 
contain, nonessential characters. This section of code removes those characters.

## Section 7: Updating Activity Labels
The actity labels in the unprocessed dataset are numeric and undescriptive. This
section of code translates these labels into descriptive values.

**activity_key** : this is a table read in from the file activity_labels.txt 
with the corresponding key for translating each numeric activity value into a 
descriptive character value.

**new_activity** : this is a vector containing the translated activity values.

## Section 8: Summarizing the tidy data and writing to a file
The new tidy data set contians multiple observations per subject and activty. 
This section of code summarizes the mean of these observations by grouping by 
subject and activity. The newly summarized data is output to a .txt file. 

**summarydata** : this is a table summarizing the mean of the data per subject
and activity.






