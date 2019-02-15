# load package
library(dplyr)

# set working directory to folder that data is in
setwd("H:/coursera/cleaning data/Week 4 assessment/UCI HAR Dataset")


# Read test files 
x <- read.table("./test/X_test.txt")
y <- read.table("./test/y_test.txt")
subtest <- read.table("./test/subject_test.txt")

# read train files
x2 <- read.table("./train/X_train.txt")
y2 <- read.table("./train/Y_train.txt")
subtrain <- read.table("./train/subject_train.txt")

# read in the data descriptions
featurenames <- read.table("features.txt")

## read in activity lables
activity.labels <- read.table("activity_labels.txt")

##merge files by x, y or subject
x3 <- rbind(x, x2)
y3 <- rbind(y, y2)
sub3 <- rbind(subtest, subtrain)

##keep only measurements for the mean and standard deviation
mean.sd <- featurenames[grep("mean\\(\\)|std\\(\\)", featurenames[,2]),]
subset_mean.sd <- x3[, mean.sd[, 1]]

##Specify the column names
colnames(x3) <- mean.sd[, 2]
colnames(y3) <- "ActivityID"
colnames(sub3) <- "subjectID"

## Specifying the descriptive names for variables
y3$activitylabel <- factor(y3$activity, labels = as.character(activity.labels[,2]))
activitylabel <- y3[,-1]

##merge all datasets and produce seperate tidy dataset
alldata <- cbind(sub3, y3, x3)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_all(funs(mean))
write.table(total_mean, file = "Tidy.data.txt", row.names = FALSE, col.names = TRUE)
