## Coursera - Getting and Cleaning Data
### Tidy Data Set Codebook
### Intoduction

A tidy data set as described below was created for data collected from a Samsung Gallaxy S smartphone's accelerometers. This data set is a small subset of the total data collected.

The data set includes only the data of the mean and standard deviation for each measurement. For the selected measurements an average is calculated for each measurement for each combination of subject and activity. A sample output for the first 12 rows and the first two variables:

```
  SubjectCode  ActivityLabel AvgtBodyAccelMeanX AvgtBodyAccelMeanY
1            1        walking                NaN                NaN
2            1   walkUpStairs                NaN                NaN
3            1 walkDownStairs                NaN                NaN
4            1        sitting                NaN                NaN
5            1       standing          0.2656969        -0.01829817
6            1         laying                NaN                NaN
7            2        walking                NaN                NaN
8            2   walkUpStairs                NaN                NaN
9            2 walkDownStairs                NaN                NaN
10           2        sitting                NaN                NaN
11           2       standing          0.2731131        -0.01913232
12           2         laying                NaN                NaN 
```

### Data Description
#### Data Processing
See the README.md file in this github repo for more information and description of the cleaning and processing performed to obtain the final tidy data set.

#### Data Source
The data was obtained from the [UCI Machine Learning Repository: Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

It is divided into two subsets: a training set and a testing set. The data files are stored locally in sub-folders of the R working directory for this project.

* Training data files in "working directory"\\UCI HAR Dataset\\train

* Testing data files in "working directory"\\UCI HAR Dataset\\test

* List and description of original UCI HAR data files:

    + x_train.txt: Data file for the training dataset
        - File is fixed width (16 characters); Data is numeric
    + y_train.txt: Activity code for each row (observation)
        - File is tab deliminated; Data is integer
    + x_test.txt: Data file for the test dataset
        - File is fixed width (16 characters); Data is numeric
    + y_test.txt: Activity code for each row (observation)
        - File is tab deliminated; Data is integer
    + features.txt: Column (variable) labels for the dataset
        - Data is tab deliminated; Data is character (feature code plus  
          description)
    + subject_train.txt: Subject code for each row (observation)
        - Data is tab deliminated; Data is integer
    + subject_train.txt: Subject code for each row (observation)
        - Data is tab deliminated; Data is integer
    + activity_labels.txt: Labels for the activity codes
        - Data is tab deliminated; Data is character (activity code plus  
          description)
    + features_info.txt: Information on the feature variables (columns)
      Text file

#### Data Structure
The experiments were conducted using 30 subjects with each subject performing six activities:

* Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, and Laying.

The original data set have 7,352 records for the training set and 2,947 records for the testing set.

For each record in both the train and test sets, a 561-feature vector with time and frequency domain variables were recorded. Each record also identifies the subject and the activity performed.

* Time domain variables are identified with a "t" prefix in the variable label.

* Frequency domain variables are identified with a "f" prefix in the variable label. Some examples:
    + 1 tBodyAcc-mean()-X
    + 17 tBodyAcc-energy()-X
    + 294 fBodyAcc-meanFreq()-X
    + 437 fBodyGyro-min()-Y
    
* A complete list of the 561 feature variables is in the "features.txt" file in the same github repository. This file is a tab deliminated text file.


* Feature label follow the following pattern:
    + Avg to indicate the value in the variable column
    + t for time domain or f for frequency domain.
    + Type of measurement. For example,
        - BodyAccel - body acceleration
        - GravityAccel - gravety acceleration
        _ body linear acceleration and angular velocity were derived in                                 
          time to obtain Jerk signals
        - etc
    + Variable estimated from the feature. For the tidy data set, only the 
      mean() and std() variables were used.
        - mean(): Mean value
        - std(): Standard deviation
        - std(): Standard deviation
        - mad(): Median absolute deviation 
        - max(): Largest value in array
        - min(): Smallest value in array
        - sma(): Signal magnitude area
        - energy(): Energy measure. Sum of the squares divided by the
        - number of values. 
        - iqr(): Interquartile range 
        - entropy(): Signal entropy
        - arCoeff(): Autorregresion coefficients with Burg order equal to 4
        - correlation(): correlation coefficient between two signals
        - maxInds(): index of the frequency component with largest 
          magnitude
        - meanFreq(): Weighted average of the frequency components to 
          obtain a mean frequency
        - skewness(): skewness of the frequency domain signal 
        - kurtosis(): kurtosis of the frequency domain signal 
        - bandsEnergy(): Energy of a frequency interval within the 64 bins 
          of the FFT of each window.
        - angle(): Angle between to vectors.
    + Coordinate direction
        - X, Y, Z
    + tBodyAccelMeanX would be the mean variable of the time domain body 
      acceleration in the X coordinate direction.

    + List of all the mean and std deviation variables included in the tidy 
      data set:

```
 [1] "SubjectCode"                  "ActivityLabel"               
 [3] "AvgtBodyAccelMeanX"           "AvgtBodyAccelMeanY"          
 [5] "AvgtBodyAccelMeanZ"           "AvgtBodyAccelStdX"           
 [7] "AvgtBodyAccelStdY"            "AvgtBodyAccelStdZ"           
 [9] "AvgtGravityAccelMeanX"        "AvgtGravityAccelMeanY"       
[11] "AvgtGravityAccelMeanZ"        "AvgtGravityAccelStdX"        
[13] "AvgtGravityAccelStdY"         "AvgtGravityAccelStdZ"        
[15] "AvgtBodyAccelJerkMeanX"       "AvgtBodyAccelJerkMeanY"      
[17] "AvgtBodyAccelJerkMeanZ"       "AvgtBodyAccelJerkStdX"       
[19] "AvgtBodyAccelJerkStdY"        "AvgtBodyAccelJerkStdZ"       
[21] "AvgtBodyGyroMeanX"            "AvgtBodyGyroMeanY"           
[23] "AvgtBodyGyroMeanZ"            "AvgtBodyGyroStdX"            
[25] "AvgtBodyGyroStdY"             "AvgtBodyGyroStdZ"            
[27] "AvgtBodyGyroJerkMeanX"        "AvgtBodyGyroJerkMeanY"       
[29] "AvgtBodyGyroJerkMeanZ"        "AvgtBodyGyroJerkStdX"        
[31] "AvgtBodyGyroJerkStdY"         "AvgtBodyGyroJerkStdZ"        
[33] "AvgtBodyAccelMagMean"         "AvgtBodyAccelMagStd"         
[35] "AvgtGravityAccelMagMean"      "AvgtGravityAccelMagStd"      
[37] "AvgtBodyAccelJerkMagMean"     "AvgtBodyAccelJerkMagStd"     
[39] "AvgtBodyGyroMagMean"          "AvgtBodyGyroMagStd"          
[41] "AvgtBodyGyroJerkMagMean"      "AvgtBodyGyroJerkMagStd"      
[43] "AvgfBodyAccelMeanX"           "AvgfBodyAccelMeanY"          
[45] "AvgfBodyAccelMeanZ"           "AvgfBodyAccelStdX"           
[47] "AvgfBodyAccelStdY"            "AvgfBodyAccelStdZ"           
[49] "AvgfBodyAccelJerkMeanX"       "AvgfBodyAccelJerkMeanY"      
[51] "AvgfBodyAccelJerkMeanZ"       "AvgfBodyAccelJerkStdX"       
[53] "AvgfBodyAccelJerkStdY"        "AvgfBodyAccelJerkStdZ"       
[55] "AvgfBodyGyroMeanX"            "AvgfBodyGyroMeanY"           
[57] "AvgfBodyGyroMeanZ"            "AvgfBodyGyroStdX"            
[59] "AvgfBodyGyroStdY"             "AvgfBodyGyroStdZ"            
[61] "AvgfBodyAccelMagMean"         "AvgfBodyAccelMagStd"         
[63] "AvgfBodyBodyAccelJerkMagMean" "AvgfBodyBodyAccelJerkMagStd" 
[65] "AvgfBodyBodyGyroMagMean"      "AvgfBodyBodyGyroMagStd"      
[67] "AvgfBodyBodyGyroJerkMagMean"  "AvgfBodyBodyGyroJerkMagStd"
 
```


* The final tidy data set will have 180 rows (6 activities for each of the 
  30 subjects) and 68 variables (columns): the 66 feature variables plus 
  the subject code and activity code.

* For each combination of subject and activity, an average of the feature 
  variable was calculated.


