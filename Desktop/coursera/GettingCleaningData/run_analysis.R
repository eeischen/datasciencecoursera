#This code downloads the Samsung data.  It is commented out, because the project instructions state: 
# "The code should have a file run_analysis.R in the main directory 
# that can be run as long as the Samsung data is in your working directory."
#fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl, destfile="Dataset.zip", method="curl")
#unzip("Dataset.zip")

#read files from the train folder
trainset<-read.table("./UCI HAR Dataset/train/X_train.txt")
trainlabels<-read.table("./UCI HAR Dataset/train/y_train.txt")
subjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")

#read files from th test folder
testset<-read.table("./UCI HAR Dataset/test/X_test.txt")
testlabels<-read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt")

#merge the data sets from the train folder
training<-cbind(trainset, trainlabels, subjecttrain)

#merge the data sets from the test folder
test<-cbind(testset, testlabels, subjecttest)

#merge training and test sets
merged<-rbind(training, test)

#assign names to the merged data set
features<-read.table("./UCI HAR Dataset/features.txt")
featuresvector<-as.vector(features[,2])
names<-append(as.vector(featuresvector), c("Activity", "Subject"))
names(merged)<-names

#extract only the measurements on the mean and standard deviation for each measurement 
meanl<-grepl("mean\\(\\)", featuresvector)
stdl<-grepl("std", featuresvector)
meanorstdl<-meanl|stdl
append(meanorstdl, c(TRUE, TRUE))
mergednew<-merged[,meanorstdl]

#merge dataset mergednew with activity labels (to give numbered activities descriptive names)
activitylabels<-read.table("./UCI HAR Dataset/activity_labels.txt")
names(activitylabels)<-c("Activity Code", "Activity")
activitylabels$Activity<-gsub("_", " ", activitylabels$Activity)
mergeddescriptive<-merge(activitylabels, mergednew, by.x="Activity Code", by.y="Activity")

#make the variable names more descriptive
names(mergeddescriptive)<-tolower(names(mergeddescriptive))
names(mergeddescriptive)<-gsub("^t", "time.", names(mergeddescriptive))
names(mergeddescriptive)<-gsub("^f", "frequency.domain.signal.", names(mergeddescriptive))
names(mergeddescriptive)<-gsub("mean\\(\\)", "mean", names(mergeddescriptive))
names(mergeddescriptive)<-gsub("std\\(\\)", "standard.deviation", names(mergeddescriptive))
names(mergeddescriptive)<-gsub("bodybody", "body", names(mergeddescriptive))
names(mergeddescriptive)<-gsub("\\-", "\\.", names(mergeddescriptive))

#remove activity numbers, move subject number to first column, order by subject number 
mergeddescriptive2<-mergeddescriptive[,c(69, 2:68)]
order<-order(mergeddescriptive2[,1])
mergeddescriptive2<-mergeddescriptive2[order,]

#create tidy data set with average of each variable for each activity and each subject
subjectby<-as.vector(mergeddescriptive2[, "subject"])
activityby<-as.vector(mergeddescriptive2[,"activity"])
output<-aggregate(x=mergeddescriptive2[3:68], by=list(Subject=subjectby, Activity=activityby), FUN="mean")
write.table(output, "tidy.txt")
