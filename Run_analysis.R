#1.Merges the training and the test sets to create one data set.

##1.1 Read the data
X_test <- read.table ("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

##1.2 Inspect the data to make the decision about what to merge
dim(X_test)
dim(X_train)
names(X_test)
names(X_train)
dim(y_test)
dim(y_train)
names(y_train)
names(y_test)
dim(subject_test)
dim(subject_train)
names(subject_train)

##1.3 Merge all data  
X<-rbind(X_test, X_train)
y<-rbind(y_test, y_train )
subject<- rbind(subject_test, subject_train)
dim(X)
dim(y)
dim(subject)
dataset<- cbind(X,subject,y)
View(dataset[562:563])


#2.Extracts only the measurements on the mean and standard deviation for each measurement
features<-read.table("./UCI HAR Dataset/features.txt")
View(features)
MeanAndStd <- grep("-(mean|std)\\(\\)", features[,2])
dataset <- dataset [, MeanAndStd]
dataset <- cbind(dataset,subject,y)
View(dataset)

#3. Uses descriptive activity names to name the activities in the data set
activities <- read.table ("./UCI HAR Dataset/activity_labels.txt")
View(activities)
dataset[,68]<- activities[dataset[,68],2]
View(dataset)

#4. Appropriately labels the data set with descriptive variable names.
names(dataset)<- features[MeanAndStd, 2]
View(features)
names(dataset) [67] <- "subject"
names(dataset)[68]<- "activity"
colnames(dataset)<- sub("\\(\\)","",colnames(dataset),)
colnames(dataset)<- gsub("-","",colnames(dataset),)
colnames(dataset)<- tolower(colnames(dataset))
colnames(dataset)<- sub("^t","time",colnames(dataset),)
colnames(dataset)<- sub("^f","frequency",colnames(dataset),)
View(dataset)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
dataset_by_subject_activity <- group_by (dataset, subject, activity)
dataset_means <- summarise_each (dataset_by_subject_activity, funs(mean), 1:66)
View(dataset_means)
names(dataset_means) 

write.table(dataset_means, "dataset_means_tidy.txt", row.names = FALSE, quote = FALSE)
