# First Step
X_train<-read.table("./UCI HAR Dataset/train/X_Train.txt")
Y_train<-read.table("./UCI HAR Dataset/train/y_Train.txt")
train <- cbind(Y_train,X_train)
subject_train<-read.table("./UCI HAR Dataset/train/subject_Train.txt")
train<- cbind(subject_train,train)
features <- read.table("./UCI HAR Dataset/features.txt")

X_test<-read.table("./UCI HAR Dataset/test/X_Test.txt")
Y_test<-read.table("./UCI HAR Dataset/test/Y_Test.txt")
test <- cbind(Y_test,X_test)
subject_test<-read.table("./UCI HAR Dataset/test/subject_Test.txt")
test <- cbind(subject_test,test)

data <- rbind(train,test)

##Second Step
col <- grep('mean\\(\\)|std\\(\\)',features$V2)
data2 <- data[,c(1,2,col+2)]

##Third Step
name <- features[col,2]
name<-as.character(name)
colnames(data2)<-c("Subject","Activity",name)
library(plyr)
data2$Activity <- as.factor(data2$Activity)
data2$Activity<-revalue(data2$Activity,c("1" = "Walking","2"="Walking_Upstairs","3"="Walking_Downstairs","4"="Sitting","5"="Standing","6"="Laying"))

##Step 4
name <- names(data2)
name[3:42] <- sub("t","Time.",name[3:42])
name[42:68] <- sub("f","Frequency.",name[42:68])
name[3:68] <- sub("BodyAcc","Acceleration of Body",name[3:68])
name[3:68] <- sub("-mean",".Mean",name[3:68])
name[3:68] <- sub("-std",".Standard Deviation ",name[3:68])
name[3:68] <- sub("GravityAcc","Gravitational Acceleration ",name[3:68])
name[3:68] <- sub("-X",".X direction",name[3:68])
name[3:68] <- sub("-Y",".Y direction",name[3:68])
name[3:68] <- sub("-Z",".Z direction",name[3:68])
name[3:68]<-sub("BodyGyro","Gyroscopic acceleration of Body",name[3:68])
name[63:68]<-sub("Body","",name[63:68])
name[3:68]<-sub("Mag",".Magnitude",name[3:68])
name[3:68]<-sub("Jerk",".Jerk",name[3:68])
name[3:68]<-sub("[()]","",name[3:68])
name[3:68]<-sub("[)]","",name[3:68])
names(data2)<- name

#Step 5
tinydata <- aggregate(data2[3:68],list(Subject = data2$Subject,Activity = data2$Activity),mean)
write.table(tinydata,file="tinydata.txt",sep="\t", row.name=FALSE)

