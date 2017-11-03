#1
temp<-tempfile()
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',destfile = '~/Trabajos R/Datasets.zip')
unzip(zipfile='Datasets.zip')
#Reading test files
x_test<-read.table('~/Trabajos R/UCI HAR Dataset/test/X_test.txt')
y_test<-read.table('~/Trabajos R/UCI HAR Dataset/test/y_test.txt')
subject_test<-read.table('~/Trabajos R/UCI HAR Dataset/test/subject_test.txt')
#readin train files
x_train<-read.table('~/Trabajos R/UCI HAR Dataset/train/X_train.txt')
y_train<-read.table('~/Trabajos R/UCI HAR Dataset/train/y_train.txt')
subject_train<-read.table('~/Trabajos R/UCI HAR Dataset/train/subject_train.txt')

features <- read.table('~/Trabajos R/UCI HAR Dataset/features.txt')
activityLabels = read.table('~/Trabajos R/UCI HAR Dataset/activity_labels.txt')

#colnames
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')


train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)

dataset<-rbind(train,test)

#2

colNames <- colnames(dataset)
m_s<-(grepl("mean.." , colNames) | grepl("std.." , colNames))
measurements<-dataset[,m_s==TRUE]

#3

ac<-(grepl("activityId" , colNames) |grepl("mean.." , colNames) | grepl("std.." , colNames))
activity<-dataset[,ac==TRUE]
acnames<-merge(activity,activityLabels,by='activityId',all.x=TRUE)

#4
sub_mean<-(grepl("subjectId" , colNames) | grepl("activityId" , colNames) |grepl("mean.." , colNames) | grepl("std.." , colNames))
sub1<-dataset[,sub_mean==TRUE]
activitynames<-merge(sub1,activityLabels,by='activityId',all.x=TRUE)


TidyData<- aggregate(. ~subjectId + activityId,activitynames, mean)
TidyData<- TidyData[order(TidyData$subjectId, TidyData$activityId),]

write.table(TidyData, "TidyData.txt", row.name=FALSE)


