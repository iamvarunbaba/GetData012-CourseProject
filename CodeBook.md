# CodeBook

This book describes the variables, data, and any formatting / transformations that has been performed to get & clean the data.

## The Data

* Original dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


## "run_analysis.R" Script details

* Requires "reshapre2" and "data.table" libraries.
* Loads the activity_labels & features data frame.
* Extracts the mean and standard deviation from features data.
* Reads & Processes the 'X_test' & 'y_test' tables from the respective files
* Binds them using cbind into 'test_data'
* Reads & Processes the 'X_train' & 'y_train' tables from the respective files
* Binds them using cbind into 'train_data'
* Merges 'test_data' & 'train_data' into 'merged_data' using rbind
* Melts the data using 'melt' after identifying the id labels & data labels
* Mean of the 'melt_data' is transofrmed into 'tidy_data' using 'dcast'
* Finally 'tidy_data.txt' is written using write.table & row.names=FALSE

