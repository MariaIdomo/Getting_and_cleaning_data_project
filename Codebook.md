##DATA

The original data come from the experiments that were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The original data are available here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
-  File 'train': - 'X_train.txt': Training set.
          - 'y_train.txt': Training labels.
                      -'subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
                       - File:'Inertial Signals:- total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
                                  - 'body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
                                  - 'body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
- File 'test': - 'X_test.txt': Test set.
       - 'y_test.txt': Test labels.
                   -'subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
                    - File:'Inertial Signals' (the same txt than in file train)


##TRANSFORMATIONS

1.	Merges the training and the test sets to create one data set.
After reading and inspecting the data I merged those with similar characteristics (same number of columns and referring the same variables). I used the function rbind and cbind

2.	Extracts only the measurements on the mean and standard deviation for each measurement.
I selected from the data set only the columns with mean or standard deviation in their names (-mean() or –std()), using the function grep. The names of the columns were on features.txt 

3.	Uses descriptive activity names to name the activities in the data set
I substitute the numbers of the last column of my dataset with the appropriate activity label from the activity_labels.txt 

4.	Appropriately labels the data set with descriptive variable names.
Appropriate variable names are those with only valid characters: letters (lower case) and digits. I considered as not valid: “-” and “()”. I also changed “t” to time and “f” to freq. I used the “sub” function from the dplyr package. I used tolower to change all to lower case.

5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
I started grouping my data set by activity and subject using group_by. Then, I calculated the mean of these groups using sumarise_each. Finally, I created the new data set with write.table


##VARIABLES

[1] subject: there are 30 subjects who participated in this study, each of them identified with a number

[2] activity: the purpose of this study is measured different parameters when the subjects were performing each one of the activities described in this variable.

-  the rest of the variables are the average of certain variables (mean and standard deviation) for each activity and each subject of the original data set. 
The unit of the variables starting by “time” is second and the unit of those starting by “frequency” is Hz (hertz).
These variables come from the accelerometer and gyroscope 3-axial raw signals timeaccxyz and tgyroxyz. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timebodyaccxyz and timegravityaccxyz) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timebodyaccjerkxyz and timebodygyrojerkxyz). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timebodyaccmag, timegravityaccmag, timebodyaccjerkmag, timebodygyromag, timebodygyrojerkmag). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequenzybodyaccxyz, frequenzybodyzccjerkxyz, frequenzybodygyroxyz, frequenzybodyaccjerkmag, frequenzybodygyromag, frequenzybodygyrojerkmag. These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The list of the variables described above:

[3] "timebodyaccmeanx"                 "timebodyaccmeany"                
 [5] "timebodyaccmeanz"                 "timebodyaccstdx"                 
 [7] "timebodyaccstdy"                  "timebodyaccstdz"                 
 [9] "timegravityaccmeanx"              "timegravityaccmeany"             
[11] "timegravityaccmeanz"              "timegravityaccstdx"              
[13] "timegravityaccstdy"               "timegravityaccstdz"              
[15] "timebodyaccjerkmeanx"             "timebodyaccjerkmeany"            
[17] "timebodyaccjerkmeanz"             "timebodyaccjerkstdx"             
[19] "timebodyaccjerkstdy"              "timebodyaccjerkstdz"             
[21] "timebodygyromeanx"                "timebodygyromeany"               
[23] "timebodygyromeanz"                "timebodygyrostdx"                
[25] "timebodygyrostdy"                 "timebodygyrostdz"                
[27] "timebodygyrojerkmeanx"            "timebodygyrojerkmeany"           
[29] "timebodygyrojerkmeanz"            "timebodygyrojerkstdx"            
[31] "timebodygyrojerkstdy"             "timebodygyrojerkstdz"            
[33] "timebodyaccmagmean"               "timebodyaccmagstd"               
[35] "timegravityaccmagmean"            "timegravityaccmagstd"            
[37] "timebodyaccjerkmagmean"           "timebodyaccjerkmagstd"           
[39] "timebodygyromagmean"              "timebodygyromagstd"              
[41] "timebodygyrojerkmagmean"          "timebodygyrojerkmagstd"          
[43] "frequencybodyaccmeanx"            "frequencybodyaccmeany"           
[45] "frequencybodyaccmeanz"            "frequencybodyaccstdx"            
[47] "frequencybodyaccstdy"             "frequencybodyaccstdz"            
[49] "frequencybodyaccjerkmeanx"        "frequencybodyaccjerkmeany"       
[51] "frequencybodyaccjerkmeanz"        "frequencybodyaccjerkstdx"        
[53] "frequencybodyaccjerkstdy"         "frequencybodyaccjerkstdz"        
[55] "frequencybodygyromeanx"           "frequencybodygyromeany"          
[57] "frequencybodygyromeanz"           "frequencybodygyrostdx"           
[59] "frequencybodygyrostdy"            "frequencybodygyrostdz"           
[61] "frequencybodyaccmagmean"          "frequencybodyaccmagstd"          
[63] "frequencybodybodyaccjerkmagmean"  "frequencybodybodyaccjerkmagstd"  
[65] "frequencybodybodygyromagmean"     "frequencybodybodygyromagstd"     
[67] "frequencybodybodygyrojerkmagmean" "frequencybodybodygyrojerkmagstd"
