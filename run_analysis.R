path <- "C:/Users/Riaz/Dropbox/Riazahida/Data Science/Courses/Data Science - Johns Hopkins/Getting and Cleaning Data/Week 4/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"

library(dplyr)

# 1. Merge the training and the test sets to create one data set.
# load train data
train.set <- read.table(paste(path, "/train/X_train.txt", sep = ""))
train.labels <- read.table(paste(path, "/train/y_train.txt", sep = ""))
train.subject <- read.table(paste(path, "train/subject_train.txt", sep = ""))

# Merge labels and subject columns into the test data set
# train.data <- cbind(train.subject, train.labels, train.set)


# load test data
test.set <- read.table(paste(path, "/test/X_test.txt", sep = ""))
test.labels <- read.table(paste(path, "/test/y_test.txt", sep = ""))
test.subject <- read.table(paste(path, "test/subject_test.txt", sep = ""))

# Merge labels and subject columns into the test data set
#test.data <- cbind(test.subject, test.labels, test.set)

# merge training and test date sets
all.set <- rbind(train.set, test.set)
all.labels <- rbind(train.labels, test.labels)
all.subject <- rbind(train.subject, test.subject)

# 2. Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table(paste(path, "features.txt", sep = ""))

idx <- intersect(grep("mean|std", features[,2]), grep("Freq+", features[,2], invert=TRUE))

all.set <- all.set[,idx]

# 3. Use descriptive activity names to name the activities in the data set
activities <- read.table(paste(path, "activity_labels.txt", sep = ""))

all.labels[,1] = activities[all.labels[,1],2]
names(all.labels) <- "Activity"

# 4. Appropriately label the data set with descriptive variable names.
names(all.set) <- features[idx,2]

names(all.subject) <- "Subject"

all.data <- cbind(all.subject, all.labels, all.set)

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
avg.data <- all.data %>%
group_by(Subject,Activity) %>%
summarise_each(funs(mean))







