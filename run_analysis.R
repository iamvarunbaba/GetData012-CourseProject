## GETTING AND CLEANING DATA - COURSE PROJECT - COURSERA (getdata-012)

## User ID          : 5076930
## Submission Login : varun.ramakrishnan@gmail.com

## Data for the Project :
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## This script - 'run_analysis.R' does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Installing & Loading the 'Data Table' & 'Reshape2' packages
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Loading the 'activity labels' data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Loading the 'features' data
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extracting mean & standard deviation of 'features' data.
extract_features <- grepl("mean|std", features)

# Loading 'X_test',  'y_test' & 'subject_test' data.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Formatting the above test data
names(X_test) = features
X_test = X_test[,extract_features]
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Binding the above processed data as 'test_data'
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Loading 'X_train', 'y_train' and 'subject_train' data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Formatting the above train data
names(X_train) = features
X_train = X_train[,extract_features]
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Binding the above processed data as 'train_data'
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# (1) Merging 'test_data' and 'train_data' into data
merged_data = rbind(test_data, train_data)

# Getting id labels & data labels, Melting data
labels_id   = c("subject", "Activity_ID", "Activity_Label")
labels_data = setdiff(colnames(merged_data), labels_id)
melt_data      = melt(merged_data, id = labels_id, measure.vars = labels_data)

# Applying the mean to dataset
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

# Creating the independent tidy data set
write.table(tidy_data, file = "./tidy_data.txt", row.names=FALSE)


