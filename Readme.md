## Coursera - Getting and Cleaning Data
### README for script run_analysis.R
### Intoduction

FIles in this github repo:

* README.md - Description of how the script run_analysis.R takes the  
  original UCI HAR data and cleans and processes it to produce the  
  requested "tidy data set".
* CodeBook.md - Description of the data and variables for the original UCI  
  HAR data and the consolidated tidy data set.
* run_analisis>R - The script to prpocess the original UCI HAR data into  
  the consolidated tidy set.
* Features.md - List of the 561 original UCI HAR feature variables.

A tidy data set as described below was created for data collected from a Samsung Gallaxy S smartphone's accelerometers. This data set is a small subset of the total data collected.

The data set includes only the data of the mean and standard deviation for each measurement. For the selected measurements an average is calculated for each measurement for each combination of subject and activity.  

This results in 180 combinations of Subject / Activity for which the Average for each of the 66 feature variables is calculated. A sample output for the first 12 rows and the first two variables is below.

There is not data for all combinations of Subject and Activity. A NaN is returned when there was no data to compure the average for any Subject / Activity combination.

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

The tidy dataset was exported to tab deliminated text file named "TidyData.txt"

If the Subject / Activity combinations with no data are removed, there are 40 combinations that have data (only first two feature variables shown):

```
   SubjectCode  ActivityLabel AvgtBodyAccelMeanX AvgtBodyAccelMeanY
1            1        walking          0.2656969        -0.01829817
2            2   walkUpStairs          0.2731131        -0.01913232
3            3 walkDownStairs          0.2734287        -0.01785607
4            4        sitting          0.2725398        -0.01962696
5            4       standing          0.2748047        -0.01298539
6            5         laying          0.2791780        -0.01548335
7            6        walking          0.2723766        -0.01756970
8            7   walkUpStairs          0.2697530        -0.01971729
9            7 walkDownStairs          0.2721474        -0.01487908
10           8        sitting          0.2707591        -0.01818950
11           9       standing          0.2703138        -0.02094666
12          10         laying          0.2778939        -0.02010073
13          10        walking          0.2761672        -0.01635976
14          11   walkUpStairs          0.2765853        -0.01912725
15          12 walkDownStairs          0.2736087        -0.01833720
16          13        sitting          0.2759723        -0.01816997
17          13       standing          0.2753313        -0.01381421
18          14         laying          0.2701846        -0.01625482
19          15        walking          0.2808090        -0.01325707
20          15   walkUpStairs          0.2767741        -0.01824301
21          16 walkDownStairs          0.2778874        -0.01585679
22          17        sitting          0.2740295        -0.01754160
23          18       standing          0.2775325        -0.01663202
24          18         laying          0.2747131        -0.01815133
25          19        walking          0.2697235        -0.01820315
26          20   walkUpStairs          0.2746876        -0.01881072
27          20 walkDownStairs          0.2662910        -0.01717559
28          21        sitting          0.2783382        -0.01832671
29          21       standing          0.2748515        -0.01568570
30          22         laying          0.2747677        -0.01682736
31          23        walking          0.2734933        -0.01958926
32          24   walkUpStairs          0.2767670        -0.01768225
33          25 walkDownStairs          0.2784617        -0.01995439
34          25        sitting          0.2713599        -0.01853364
35          26       standing          0.2730366        -0.01616873
36          27         laying          0.2772646        -0.01679692
37          28        walking          0.2774107        -0.01949022
38          28   walkUpStairs          0.2787034        -0.01611504
39          29 walkDownStairs          0.2791115        -0.01847195
40          30        sitting          0.2763058        -0.01758561
```


### Data Description
#### Data Source
See the "CodeBook.md" file in the same github repo as this file.

#### Data Structure
See the "CodeBook.md" file in the same github repo as this file.

#### Data Processing
The script run_analysis.R takes the original UCI HAR data files and  processes them to obtain the "tidy data set".

* The training and test data were read into R as separate files for initial processing prior to combining into one consolidated file.
    + The training data was read from the tab deliminated text file  
      X_train.txt in the train folder to the R dataframe x.train.data
    + The testing data was read from the tab deliminated text file  
      Y_train.txt in the test folder to the R dataframe x.test.data
* Once read into R, the original train and test data files are saved as  
  R objects "x-TrainDataOrig.rda" and "x-TestDataOrig.rda" in the working  
  directory. This is to cut down on processing time if there is a subsequet  
  need to read in to R the original test and / or train data due to the  
  size of the original data files.
* Feature (column) labels were read into R from the tab deliminated  
  text file features.txt in the UCI HAR Dataset folder. These labels were  
  assigned to the x.train.data and x.test.data dataframes.
* A new column "dataset.code" was added to each dataframe to identify  
  which data file it came from: training or testing.
* The activity code for each record was read into R from the  
  corresponding tab delimited text file and was added as a new column to  
  each dataframe
    + y_train.txt for the training dataframe.
    + y_test.txt for the test dataframe.
* The subject code for each record was read into R from the  
  corresponding tab deliminated text file and was added as a new column to  
  each dataframe.
    + subject_train.txt for the training dataframe.
    + subject_test.txt for the testing dataframe.
* The training and testing dataframe were consolidated into one dataframe  
  consolidated.data
* The features (columns) with "mean()" or "std()" were extracted from the  
  consolidated dataframe of 561 feature columns.
* The reduced dataframe has 66 feature columns plus an activity code column  
  and a subject code column (for a total of 68 variable columns). This  
  dataframe is called mean.sd.data
* The reduced dataframe mean.sd.data "molten" the 66 feature variables into  
  "measurement.name"" and "measurement" columns and named mean.sd.data.melt
* The "molten" dataframe mean.sd.data.melt was cast using the subject  
  code and activity code as a combined x variable. The measurement.name  
  column is used as the y variable. The measurement columns is used for the  
  value variable. Mean is used as the function. To include all combinations  
  of Subject and Activity, even when there is no measurement, set the 
  "drop" option in the dcast function to FALSE.  
* To exclude the conbinations without data (NaN results) set the "drop" option in the dcast function to TRUE (the default).  
* Activity codes are replaced with a simplified label.
* The feature labels were simplified by removing punctuation marks  
  (parentheses, hyphens, spaces) and numerical ID at the start of each   
  feature label.
* The final result is a dataframe called mean.sd.data.tidy. This dataframe  
  is written to a tab deliminated text file named TidyData.txt and  
  submitted to the Coursera.

* Feature label follow the following pattern:
    + Avg to indicate the value in the variable column
    + t for time domain or f for frequency domain.
    + Type of measurement. For example,
        - BodyAccel - body acceleration
        - GravityAccel - gravity acceleration
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


