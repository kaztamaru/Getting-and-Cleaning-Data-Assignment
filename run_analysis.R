#********************************************************************************************
#   The Course Project : run_analysis.R                                                                         *
# 1.Merges the training and the test sets to create one data set.                           *
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. * 
# 3.Uses descriptive activity names to name the activities in the data set.                 *
# 4.Appropriately labels the data set with descriptive variable names.                      *
# 5.From the data set in step 4, creates a second, independent tidy data set                *
#   with the average of each variable for each activity and each subject.                   *
#********************************************************************************************

# 1.Merges the training and the test sets to create one data set.

setwd("/Users/kaztamaru/Desktop/デスクトップ/R/Cousera/Getting and Cleaning Data/UCI HAR Dataset/")

#1. Merges the training and the test sets to create one data set. 
#1.1 Get column names
DT <- read.table("features.txt")
col_name <- DT[, 2]
col_name <- gsub(",", "_", gsub("[()]", "", col_name))

#1.2 Get training data set
S <- read.table("train/subject_train.txt")
colnames(S) <- "subject"
X <- read.table("train/X_train.txt")
colnames(X) <- col_name
Y <- read.table("train/y_train.txt")
colnames(Y) <- "activities"
train <- cbind(S, Y, X)

#1.3 Get test data set
S <- read.table("test/subject_test.txt")
colnames(S) <- "subject"
X <- read.table("test/X_test.txt")
colnames(X) <- col_name
Y <- read.table("test/y_test.txt")
colnames(Y) <- "activities"
test <- cbind(S, Y, X)

#1.4 Get activity_labels
DT <- read.table("activity_labels.txt")
colnames(DT) <- c("activities", "activity")

#1.5 Merge training and the test sets
Merge_data <- rbind(train, test)
Merge_data <- merge(DT, Merge_data)
Merge_data <- Merge_data[, -1] 

#2. Creat tidy data set with the average of each variable for each activity and each subject.
library(plyr)
mean_data <- ddply(Merge_data, .(activity, subject), numcolwise(mean))
sd_data <- ddply(Merge_data, .(activity, subject), numcolwise(sd))

#3. Write tidy data set.
write.table(mean_data, "tidy_data_set.txt", row.name=FALSE) 
