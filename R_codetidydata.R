

## Reading training tables
x_train<-read.table("C:/Users/sony/Desktop/datascience/data science toolbox/week4/UCI HAR Dataset/train/X_train.txt")
y_ytain<-read.table("C:/Users/sony/Desktop/datascience/data science toolbox/week4/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("C:/Users/sony/Desktop/datascience/data science toolbox/week4/UCI HAR Dataset/train/subject_train.txt")
                          
## Reading testing tables
x_test<-read.table("C:/Users/sony/Desktop/datascience/data science toolbox/week4/UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("C:/Users/sony/Desktop/datascience/data science toolbox/week4/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("C:/Users/sony/Desktop/datascience/data science toolbox/week4/UCI HAR Dataset/test/subject_test.txt")

##Reading the feature vector
features<-read.table<-read.table("C:/Users/sony/Desktop/datascience/data science toolbox/week4/UCI HAR Dataset/features.txt")

#Reading activity labels
activityLabels<-read.table("C:/Users/sony/Desktop/datascience/data science toolbox/week4/UCI HAR Dataset/activity_labels.txt")

##Assign column names
colnames(x_train)<-features[,2]
colnames(y_ytain)<-"activityId"
colnames(subject_train)<-"subjectId"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

##Merging all data in one set
merge_train<-cbind(y_ytain,subject_train,x_train)
merge_test <- cbind(y_test, subject_test, x_test)
mergeall <- rbind(merge_train, merge_test)

## Extracting only the measures of the mean and standard deviation of each instrument
# Reading column names

colNames<-colnames(mergeall)

#Create ID for defining ID, mean and standard deviation

mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
                 
)

                 
 ## Making the necessary subsets from setAllinOne
 
subsetmeanstd <- mergeall[ , mean_and_std == TRUE]


##Using descriptive activity names to name the activities in the data set

subsetwithactivitynames <- merge(subsetmeanstd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

## Creating a second, independent tidy data set with the average of each variable for each activity and each subject:

tidydataset <- aggregate(. ~subjectId + activityId, subsetwithactivitynames, mean)
tidydataset <- tidydataset[order(tidydataset$subjectId, tidydataset$activityId),]


##Writing second tidy data set in txt file
write.table(tidydataset, "tidydataset.txt", row.name=FALSE)







