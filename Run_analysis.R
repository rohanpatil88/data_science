activity_labels <- read.table("C:/Users/Sushant/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"")
features <- read.table("C:/Users/Sushant/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"")
X_test <- read.table("C:/Users/Sushant/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("C:/Users/Sushant/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"")
X_train <- read.table("C:/Users/Sushant/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("C:/Users/Sushant/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_test <- read.table("C:/Users/Sushant/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("C:/Users/Sushant/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"")
y_test$V1 <- gsub("4","SITTING",y_test$V1)
y_test$V1 <- gsub("3","WALKING_DOWNSTAIRS",y_test$V1)
y_test$V1 <- gsub("2","WALKING_UPSTAIRS",y_test$V1)
y_test$V1 <- gsub("1","WALKING",y_test$V1)
y_test$V1 <- gsub("6","LAYING",y_test$V1)
y_test$V1 <- gsub("5","STANDING",y_test$V1)
y_train$V1 <- gsub("4","SITTING",y_train$V1)
y_train$V1 <- gsub("3","WALKING_DOWNSTAIRS",y_train$V1)
y_train$V1 <- gsub("2","WALKING_UPSTAIRS",y_train$V1)
y_train$V1 <- gsub("1","WALKING",y_train$V1)
y_train$V1 <- gsub("6","LAYING",y_train$V1)
y_train$V1 <- gsub("5","STANDING",y_train$V1)
colnames(X_test) <- features$V2
colnames(X_train) <- features$V2
X_train_new <- cbind(X_train,y_train$V1)
X_train_new <- cbind(X_train_new,subject_train$V1)
X_test_new  <- cbind(X_test,y_test$V1)
X_test_new <- cbind(X_test_new,subject_test$V1)
names(X_train_new)[563]  <- "Subject"
names(X_train_new)[562]  <- "Activity"
names(X_test_new)[563]  <- "Subject"
names(X_test_new)[562]  <- "Activity"
complete_data <- rbind(X_train_new,X_test_new)
complete_data_mean <- complete_data[, grep("mean", names(complete_data))]
complete_data_std <- complete_data[, grep("std", names(complete_data))]
complete_data_merged <- cbind(complete_data_mean,complete_data_std)
complete_data_merged  <- cbind(complete_data_merged,complete_data$Activity)
complete_data_merged <- cbind(complete_data_merged,complete_data$Subject)
complete_data_merged$Activity <- as.character(complete_data_merged$Activity)
complete_data_proper <- aggregate( . ~ complete_data$Activity + complete_data$Subject, data = complete_data_merged,FUN=mean)
names(complete_data_proper)[2]  <- "Subject"
names(complete_data_proper)[1]  <- "Activity"
