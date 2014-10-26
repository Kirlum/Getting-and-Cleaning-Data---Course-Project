### First Step - Merges the training and the test sets to create one data set.
Tables were creates with the data from the training set (X_Train.txt and y_Train.txt) and from the test set (X_Test.txt and y_Test.txt). With cbind the tabels were merged to the table "train" respectively "test". "Train" was merged with the subject_Train-data and "test" with the subject_Test-data, and then both tabels were merged to create a complete data set called "data"

### Second Step - Extracts only the measurements on the mean and standard deviation for each measurement. 
The features with "mean" or "std" were extracted to "col" and then the measurement with the columns according to these features were extracted to the data set "data2".

### Third Step - Uses descriptive activity names to name the activities in the data set
"names" are the features seperated by the second step and the columnnames were replaced by them.

### Step 4 - Appropriately labels the data set with descriptive variable names. 
The names in the "names"-table were replaced by the follwing descriptive names

 - "t" by "Time"
 - "f" by "Frequency"
 - "BodyAcc" by "Acceleration of Body"
 - "-mean" by ".Mean"
 - "-std" by ".Standard Deviation "
 - "GravityAcc" by "Gravitational
   Acceleration "
 - "-X" by ".X direction"
 - "-Y" by ".Y direction"
 - "-Z" by ".Z direction"
 - "BodyGyro" by "Gyroscopic
   acceleration of Body"
 - "Body" by ""
 - "Mag" by ".Magnitude"
 - "Jerk"by ".Jerk"

Then the colnames of the data2-table were replaced by the new names

### Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The data2-set war split into a tidy data set wiht the averade of each variable for each activity and each subject.
