### This is the CodeBook which describes the run_analysis.R script.

The script lies on data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
You can download data for the project from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Please, unpack data to your R working directory before running run_analysis.R. 
The CodeBook follows the steps on Readme.md file and describes variables, datasets and their purpose. 

## Step 1. First we combine datasets from Test and Train
TestDataset - dataset with Test observations (30% according to Samsung documentation)
TrainDataset - dataset with Train observations (other 70% according to Samsung documentation)
TotalDataset - dataset that contains both observations

## Step 2. We open file with column names and assign them to dataset
We are going to use "sqldf" R package to select variable names only for mean and standard deviation 
Header - dataset that contains variable names
	names(TotalDataset)[1:561] = paste0(Header$V2) - we assign names to the columns
ReqCols - dataset (after - vector) that contain column names only for mean and standard deviation
TotalSubset - dataset that contains data with only requeres columns (mean and standard deviation columns)

## Step 3. Then we join activities
TestActivities - dataset with activity code for each test observation (30% according to Samsung documentation)
TrainActivities - dataset with activity code for each train observation (70% according to Samsung documentation)
TotalActivities - dataset with total activity codes
TotalSubset["activityNo"]=TotalActivities$V1 - we join activity codes to observations
ActivityLables - dataset with activity descriptions
	TotalSubset = merge(TotalSubset, ActivityLables, by.x="activityNo", by.y="V1")
	TotalSubset = subset(TotalSubset, select=-c(activityNo))
we join activity descriptions according activity codes
	names(TotalSubset)[names(TotalSubset) == 'V2'] = 'activityName'
and renaming activity description column to activityName

## Step 4. Then we join Subjects
TestSub - dataset with test subjects codes (a person's code who was observed) (30% according to Samsung documentation) 
TrainSub - dataset with train subjects codes (a person's code who was observed) (70% according to Samsung documentation) 
TotalSub - dataset with total subjects codes
	names(TotalSub)[names(TotalSub) == 'V1'] = 'SubNo'
we renaming subject's code column to SubNo
	TotalSubset["SubNo"]=TotalSub$SubNo
and join it to TotalSubset

## Step 5. At last we calculate average of requered fields grouping by activityName and SubNo
TidyDataset - result tidy dataset grouped by activityName and SubjectNo columns

## Write in a file
at last we write TidyDataset to "tidyDS.txt" file at current directory
