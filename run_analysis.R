
## Load required librarys
library(reshape2)
library(plyr)
                 
cProject.wd <- getwd()
cProject.Data.Folder <- paste(cProject.wd,"/Project Data", sep = "")

cProject.Data.path <- paste(cProject.Data.Folder,"/UCI HAR Dataset", sep = "")
cProject.TrainData.path <- paste(cProject.Data.path,"/train", sep = "")
cProject.TestData.path <- paste(cProject.Data.path,"/test", sep = "")

### Information on data files
## x_train.txt: Data file for the training dataset
##      File is fixed width (16 characters); Data is numeric
## y_train.txt: Activity code for each row (observation)
##      File is tab deliminated; Data is interger
## x_test.txt: Data file for the test dataset
##      File is fixed width (16 characters); Data is numeric
## y_test.txt: Activity code for each row (observation)
##      File is tab deliminated; Data is interger
## features.txt: Column (variable) labels for the dataset
##      Data is tab deliminated; Data is character (feture code plus description)
## subject_train.txt: Subject code for each row (observation)
##      Data is tab deliminated; Data is interger
## subject_train.txt: Subject code for each row (observation)
##      Data is tab deliminated; Data is interger
## activity_labels.txt: Labels for the activity codes
##      Data is tab deliminated; Data is character (activity code plus description)
## features_info.txt: Information on the feature variables (columns)
##      Text file


## Assign full path plus file name for each file to be loaded into memory
x.train.file <- paste(cProject.TrainData.path, "/X_train.txt", sep = "")
y.train.file <- paste(cProject.TrainData.path, "/y_train.txt", sep = "")
subject.train.file <- paste(cProject.TrainData.path, "/subject_train.txt", sep = "")

x.test.file <- paste(cProject.TestData.path, "/X_test.txt", sep = "")
y.test.file <- paste(cProject.TestData.path, "/y_test.txt", sep = "")
subject.test.file <- paste(cProject.TestData.path, "/subject_test.txt", sep = "")

features.file <- paste(cProject.Data.path, "/features.txt", sep = "")
activity.labels.file <- paste(cProject.Data.path, "/activity_labels.txt", sep = "")

## read activity labels into memory
activity.labels <- read.delim(activity.labels.file, header = FALSE,
                              colClasses = "character")
activity.labels <- activity.labels[,1]
activity.labels <- as.data.frame(strsplit(activity.labels,split = " "))
activity.labels <- t(activity.labels)
activity.labels.V1 <- as.integer(activity.labels[,1])
activity.labels.V2 <- as.character(activity.labels[,2])

activity.labels <- data.frame(activity.labels.V1, activity.labels.V2,
                             stringsAsFactors = FALSE)

row.names(activity.labels) <- NULL
names(activity.labels) <- c("ActivityCode", "ActivityLabel")
## Clean up activity labels
activity.labels$ActivityLabel <- c("walking","walkUpStairs", "walkDownStairs",
                        "sitting", "standing", "laying")

act.label.levels <- activity.labels$ActivityLabel

activity.labels$ActivityLabel <- factor(activity.labels$ActivityLabel,
                                levels = act.label.levels)


## *** Begin Training Data Processing ***
## Read training data files into memory
if (file.exists("x-TrainDataOrig.rda")) {
    load("x-TrainDataOrig.rda")
} else {
    fixed.widths <- rep(16,561)
    x.train.data <- read.fwf(x.train.file, widths = fixed.widths,
                            header = FALSE,
                            buffersize = 500,colClasses = "numeric")
    save(x.train.data, file = "x-TrainDataOrig.rda")  ## save dataset to file
}

## Read column labels into memory
col.labels <- read.delim(features.file, header = FALSE, colClasses = "character")
names(col.labels) <- "ColNames"
col.labels <- col.labels[,1]

## Assign column names to training dataset
names(x.train.data) <- col.labels

## Create column to idetify training data
dataset.code <- rep("train", nrow(x.train.data))

## add dataset.code column to training dataset
x.train.data <- cbind(x.train.data, dataset.code)

## Read subject data into memory
subject.codes.train <- read.delim(subject.train.file, header = FALSE, 
                                  colClasses = "integer")
names(subject.codes.train) <- "SubjectCode"

## add subject code column to training dataset
x.train.data <- cbind(x.train.data, subject.codes.train)

## read activity codes into memory
activity.codes.train <- read.delim(y.train.file, header = FALSE, 
                             colClasses = "integer")
names(activity.codes.train) <- "ActivityCode"

activity.codes.train <- merge(activity.codes.train,
                              activity.labels, by = "ActivityCode",
                              sort = FALSE)
activity.codes.train$ActivityLabel <-
    as.character(activity.codes.train$ActivityLabel)

## add activity code column to training dataset
x.train.data <- cbind(x.train.data, activity.codes.train)

save(x.train.data, file = "x-TrainData.rda")  ## save dataset to file


## *** End Training Data Processing ***

## *** Begin Test Data Processing ***
## Read test data files into memory
if (file.exists("x-TestDataOrig.rda")) {
    load("x-TestDataOrig.rda")
} else {
    
    fixed.widths <- rep(16,561)
    x.test.data <- read.fwf(x.test.file, widths = fixed.widths,
                            header = FALSE,
                            buffersize = 500,colClasses = "numeric")
    save(x.test.data, file = "x-TestDataOrig.rda")  ## save dataset to file
}

## Assign column names to test dataset
names(x.test.data) <- col.labels

## Create column to idetify test data
dataset.code <- rep("test", nrow(x.test.data))

## add dataset.code column to test dataset
x.test.data <- cbind(x.test.data, dataset.code)

## Read subject data into memory
subject.codes.test <- read.delim(subject.test.file, header = FALSE, 
                                 colClasses = "integer")
names(subject.codes.test) <- "SubjectCode"

## add subject code column to test dataset
x.test.data <- cbind(x.test.data, subject.codes.test)

## read activity codes into memory
activity.codes.test <- read.delim(y.test.file, header = FALSE, 
                                   colClasses = "integer")
names(activity.codes.test) <- "ActivityCode"

activity.codes.test <- merge(activity.codes.test,
                              activity.labels, by = "ActivityCode",
                              sort = FALSE)

activity.codes.test$ActivityLabel <-
    as.character(activity.codes.test$ActivityLabel)

## add activity code column to test dataset
x.test.data <- cbind(x.test.data, activity.codes.test)

save(x.test.data, file = "x-TestData.rda")  ## save dataset to file

## *** End Test Data Processing ***

## Merge to training and test datasets into one dataset
consolidated.data <- rbind(x.train.data, x.test.data)

## Extract only columns for the mean and standard deviation
## for each measurement.
##  Use regex within grep function to find column names that match
##  "mean()" and "std()"
##  regex expression is "mean\\(\\)|(std)\\(\\)" (note use of escape char "\")

mean.sd.cols <- grep("mean\\(\\)|(std)\\(\\)",
                     names(consolidated.data), value = TRUE)

mean.sd.data <- consolidated.data[,c(mean.sd.cols,
                                     "SubjectCode", "ActivityCode")]


## "Melt" consolidated data with varibles activity and subject
mean.sd.data.melt <- melt(mean.sd.data,
                          id=c("SubjectCode", "ActivityCode"),
                          measure.vars = 1:66, na.rm = TRUE,
                          variable.name = "measurementName",
                          value.name = "measurement")


## Cast the "mealted" dataset
mean.sd.data.tidy <- dcast(mean.sd.data.melt,
              SubjectCode + ActivityCode ~ measurementName,
              fun.aggregate = mean, value.var = "measurement")

## head(mean.sd.data.tidy[,1:4],10)

## Replace ActivityCode with ActivityLabel
temp.01 <- mean.sd.data.tidy$ActivityCode
temp.02 <- replace(temp.01, 1:length(temp.01),
                   as.character(activity.labels$ActivityLabel))
mean.sd.data.tidy$ActivityCode <- temp.02
names(mean.sd.data.tidy)[2] <- "ActivityLabel"

## Rename variable label
temp <- names(mean.sd.data.tidy)

## Remove parentheses from column labels
temp.02 <- gsub("\\(\\)", "", temp)

## Remove "numerical ID from beginning of column labels
temp.03 <- gsub("^[[:digit:]]+[[:blank:]]", "", temp.02)

## Remove hyphen between "mean" or "std" and coordinate X,Y,Z
temp.04 <- gsub("(-X)$+", "X", temp.03)
temp.04 <- gsub("(-Y)$+", "Y", temp.04)
temp.04 <- gsub("(-Z)$+", "Z", temp.04)

## Change description "Acc" to "Accel"
temp.05 <- gsub("Acc","Accel", temp.04)

## Remove hyphen before "mean" or "std" and replace with ""
temp.06 <- gsub("-", "", temp.05)

## Capitalize firts letter of "mean" and "std"
temp.07 <- gsub("mean", "Mean",temp.06)
temp.07 <- gsub("std", "Std",temp.07)

## Add prefix Avg to each label to indicate value
temp.08 <- gsub("^t", "Avgt", temp.07)
temp.08 <- gsub("^f", "Avgf", temp.08)


## Assign new labels to variables in mean.sd.data.tidy
names(mean.sd.data.tidy) <- temp.08
rm(temp, temp.02, temp.03, temp.04, temp.05, temp.06, temp.07, temp.08)

## Save "tidy" dataset as R object
save(mean.sd.data.tidy, file = "Tidy Mean-Sd Data.rda")  ## save dataset to file

## Save "tidy" dataset to txt file.
write.table(mean.sd.data.tidy, "TidyData.txt", sep = "\t",row.names = FALSE)
save(mean.sd.data.tidy, file = "Tidy Mean-Sd Data.rda")
## head(mean.sd.data.tidy[,1:4],12)



#######
