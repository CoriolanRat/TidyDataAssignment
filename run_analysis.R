activity_label<- read.table("./UCI HAR Dataset/activity_labels.txt")
features<- read.table("./UCI HAR Dataset/features.txt")

#body_acc_x <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
#body_acc_y <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
#body_acc_z <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
#body_gyro_x <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
#body_gyro_y <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
#body_gyro_z <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
#total_acc_x <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
#total_acc_y <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
#total_acc_z <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")

subject1 <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject2 <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subject1,subject2)
rm(subject1)
rm(subject2)
names(subject) <- "subject"

set1 <- read.table("./UCI HAR Dataset/test/X_test.txt")
set2 <- read.table("./UCI HAR Dataset/train/X_train.txt")
set <- rbind(set1,set2) 
rm(set1)
rm(set2)

activity1 <- read.table("./UCI HAR Dataset/test/y_test.txt")
activity2 <- read.table("./UCI HAR Dataset/train/y_train.txt")
activity <- rbind(activity1,activity2)
rm(activity1)
rm(activity2)

#convert activity label to its name and rename with meaningful name (it's a matrix, hence use colnames)
activity_names <- sapply(activity, function(x) { activity_label[x,2]})
colnames(activity_names) <- "activity"
#Get the indexes in features with the mean and std measurements
list_of_measurements <- grep("mean()|std()",features[,2])

mydata <- set
names(mydata)<- features[,2]
mydata <- mydata[,list_of_measurements]
mydata <- cbind("subject"=subject,mydata)
mydata <- cbind("activity"=activity_names,mydata)

new_data <- data.frame()
for (i in 1:max(mydata$subject)) {
  
  for (j in 1:6) {
    act <- activity_label[j,2]
    temp <- mydata[mydata$subject==i & mydata$activity==act,]
    temp2 <- cbind(temp[1,1], temp[1,2])
    for (k in 3:ncol(temp)) {
      temp2 <- cbind(temp2,mean(temp[,k]))
    }
    new_data <- rbind(new_data,temp2)
  }
  
}

names(new_data) <- names(mydata)

