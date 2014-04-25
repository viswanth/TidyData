#assuming the data set is unzipped into the folder "UCI HAR Dataset" within the current working directory
#if not download the data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
#Unzip the folder in the working directory


#read the X_train training and test data sets into X_train and X_test dataframe 
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

#read the feature names data to features data frame and get the list of feature names
features <- read.table("UCI HAR Dataset/features.txt")
feat_list <- features[[2]]

#add column names to train and test data
names(X_train) <- 1:561
names(X_test) <- 1:561

#merge both data sets into total data and rename the columns to feature names
X_total <- merge(X_train,X_test,by=1:561, all = TRUE)
names(X_total) <- feat_list

#get the columns with the name mean and std 
rmean <- grep('\\-mean()',names(X_total))
rmeanf <- grep('\\-meanFreq()',names(X_total))
meancol <- setdiff(rmean,rmeanf)
stdcol <- grep('\\-std()',names(X_total))

#get all the column names with mean and std
meanstdnames <- names(X_total)[union(meancol,stdcol)]

#copy the mean and std data into new data frame 
X_meanstd <- data.frame(X_total[union(meancol,stdcol)])

#set names of this data frame with col names
names(X_meanstd) <- meanstdnames

#get the data regarding training labels and test labels and merge the data 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_total <- rbind(y_train,y_test)

#add a new column of activities according to activity codes from activity_labels.txt
y_total[(y_total[,1]==1),2]="WALKING"
y_total[(y_total[,1]==2),2]="WALKING_UPSTAIRS"
y_total[(y_total[,1]==3),2]="WALKING_DOWNSTAIRS"
y_total[(y_total[,1]==4),2]="SITTING"
y_total[(y_total[,1]==5),2]="STANDING"
y_total[(y_total[,1]==6),2]="LAYING"
names(y_total) = c("Activity_code","Activity")
activity_data <- cbind(Activity_code = y_total$"Activity_code",Activity=y_total$"Activity",X_total)

###This is the required data set with activity names descriptively added to each row

###Now to get the final tidy data set

#gather and merge the subject data from training and testing data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_total <- rbind(subject_train,subject_test)

#get tidy data set 
tidy_data <- cbind(Subject=subject_total$V1,activity_data)

#get the groupings of the users 1 - 30 in tidy_data 
tidy_data <- sapply(split(tidy_data[,4:564],list(tidy_data$Subject, tidy_data$Activity)),colMeans) 

#output this data set to a file
write.table(tidy_data,file="outfile.txt",sep="\t")
