# First Step - Merges the training and the test sets to create one data set.
Tables were creates with the data from the training set (X_Train.txt and y_Train.txt) and from the test set (X_Test.txt and y_Test.txt). With cbind the tabels were merged to the table "train" respectively "test". "Train" was merged with the subject_Train-data and "test" with the subject_Test-data, and then both tabels were merged to create a complete data set called "data"

# Second Step - Extracts only the measurements on the mean and standard deviation for each measurement. 
The features with "mean" or "std" were extracted to "col" and then the measurement with the columns according to these features were extracted to the data set "data2".

# Third Step - Uses descriptive activity names to name the activities in the data set
"names" are the features seperated by the second step and the columnnames were replaced by them.

# Step 4 - Appropriately labels the data set with descriptive variable names. 
The names in the "names"-table were replaced by the follwing descriptive names
"t" by "Time"
"f" by "Frequency"
"BodyAcc" by "Acceleration of Body"
"-mean" by ".Mean"
"-std" by ".Standard Deviation "
"GravityAcc" by "Gravitational Acceleration "
"-X" by ".X direction"
"-Y" by ".Y direction"
"-Z" by ".Z direction"
"BodyGyro" by "Gyroscopic acceleration of Body"
"Body" by ""
"Mag" by ".Magnitude"
"Jerk"by ".Jerk"
Then the colnames of the data2-table were replaced by the new names

# Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The data2-set war split into a tidy data set wiht the averade of each variable for each activity and each subject.


1 # First Step
2 X_train<-read.table("./UCI HAR Dataset/train/X_Train.txt")
3 Y_train<-read.table("./UCI HAR Dataset/train/y_Train.txt")
4 train <- cbind(Y_train,X_train)
5 subject_train<-read.table("./UCI HAR Dataset/train/subject_Train.txt")
6 train<- cbind(subject_train,train)
7 features <- read.table("./UCI HAR Dataset/features.txt")
8
9 X_test<-read.table("./UCI HAR Dataset/test/X_Test.txt")
10 Y_test<-read.table("./UCI HAR Dataset/test/Y_Test.txt")
11 test <- cbind(Y_test,X_test)
12 subject_test<-read.table("./UCI HAR Dataset/test/subject_Test.txt")
13 test <- cbind(subject_test,test)
14
15 data <- rbind(train,test)
16
17 #Second Step
18 col <- grep('mean\\(\\)|std\\(\\)',features$V2)
19 data2 <- data[,c(1,2,col+2)]
20
21 #Third Step
22 name <- features[col,2]
23 name<-as.character(name)
24 colnames(data2)<-c("Subject","Activity",name)
25 library(plyr)
26 data2$Activity <- as.factor(data2$Activity)
27 data2$Activity<-revalue(data2$Activity,c("1" = "Walking","2"="Walking_Upstairs","3"="Walking_Downstairs","4"="Sitting","5"="Standing","6"="Laying"))
28
29 #Step 4
30 name <- names(data2)
31 name[3:42] <- sub("t","Time.",name[3:42])
32 name[42:68] <- sub("f","Frequency.",name[42:68])
33 name[3:68] <- sub("BodyAcc","Acceleration of Body",name[3:68])
34 name[3:68] <- sub("-mean",".Mean",name[3:68])
35 name[3:68] <- sub("-std",".Standard Deviation ",name[3:68])
36 name[3:68] <- sub("GravityAcc","Gravitational Acceleration ",name[3:68])
37 name[3:68] <- sub("-X",".X direction",name[3:68])
38 name[3:68] <- sub("-Y",".Y direction",name[3:68])
39 name[3:68] <- sub("-Z",".Z direction",name[3:68])
40 name[3:68]<-sub("BodyGyro","Gyroscopic acceleration of Body",name[3:68])
41 name[63:68]<-sub("Body","",name[63:68])
42 name[3:68]<-sub("Mag",".Magnitude",name[3:68])
43 name[3:68]<-sub("Jerk",".Jerk",name[3:68])
44 name[3:68]<-sub("[()]","",name[3:68])
45 name[3:68]<-sub("[)]","",name[3:68])
46 names(data2)<- name
47
48 #Step 5
49 tinydata <- aggregate(data2[3:68],list(Subject = data2$Subject,Activity = data2$Activity),mean)
50 write.table(tinydata,file="tinydata.txt",sep="\t", row.name=FALSE)