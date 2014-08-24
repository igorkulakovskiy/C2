## Assigment for Coursera Cleansing Data

## Step 1. First we combine datasets from Test and Train
TestDataset = read.table("UCI HAR Dataset/test/X_test.txt")
TrainDataset = read.table("UCI HAR Dataset/train/X_train.txt")
TotalDataset <- rbind(TrainDataset, TestDataset)
rm(TrainDataset);rm(TestDataset)

## Step 2. We open file with column names and assing them to dataset
require(sqldf)
Header = read.table("UCI HAR Dataset//features.txt")
names(TotalDataset)[1:561] = paste0(Header$V2)
ReqCols = sqldf("select V2 from Header where V2 LIKE '%mean()%' or V2 LIKE '%std()%'")
ReqCols = as.character(ReqCols$V2)
## Also we get a subset only with means and std's
TotalSubset = subset(TotalDataset, select=ReqCols)
rm(Header);rm(ReqCols);rm(TotalDataset)


## Step 3. Then we join activities
TestActivities = read.table("UCI HAR Dataset/test/y_test.txt")
TrainActivities = read.table("UCI HAR Dataset/train/y_train.txt")
TotalActivities <- rbind(TrainActivities, TestActivities)
rm(TrainActivities);rm(TestActivities)

TotalSubset["activityNo"]=TotalActivities$V1
ActivityLables = read.table("UCI HAR Dataset/activity_labels.txt")
TotalSubset = merge(TotalSubset, ActivityLables, by.x="activityNo", by.y="V1")
TotalSubset = subset(TotalSubset, select=-c(activityNo))
names(TotalSubset)[names(TotalSubset) == 'V2'] = 'activityName'
rm(ActivityLables);rm(TotalActivities)


## Step 4. Then we join Subjects
TestSub = read.table("UCI HAR Dataset/test/subject_test.txt")
TrainSub = read.table("UCI HAR Dataset/train/subject_train.txt")
TotalSub <- rbind(TrainSub, TestSub)
rm(TrainSub);rm(TestSub)

names(TotalSub)[names(TotalSub) == 'V1'] = 'SubNo'
TotalSubset["SubNo"]=TotalSub$SubNo
rm(TotalSub)

## Step 5. At last we calculate average of requered fields grouping by activityName and SubNo
TidyDataset = aggregate(TotalSubset[1:66], list(TotalSubset$activityName, TotalSubset$SubNo), mean)
names(TidyDataset)[names(TidyDataset) == 'Group.1'] = 'activityName'
names(TidyDataset)[names(TidyDataset) == 'Group.2'] = 'SubjectNo'

## Write in a file
write.table(TidyDataset, file="tudyDS.txt", row.name=FALSE)
