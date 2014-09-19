
  ##Manually downloaded the ZIP file
  ##Unzipped to development folder, Tiny Data
  
  driveName <- "Tidy Data/UCI HAR Dataset"
  
  ##Import the first data set
  ##X test is the test set, Y test is the Activity
  
  features <- read.table("UCI HAR Dataset/features.txt")
  Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt",col.names = "Activity")
  X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
  
  ##print(row.names(Y_test))
  ##print(row.names(X_test))
  ##print(row.names(subject_test))
  
  
  ##Add Activity Column
  
  ##print(length(X_test))
  ##Adding X_test
  X_test <- cbind(subject_test,Y_test,X_test)
  ##print(length(X_test))
  
  
  ##col.names = features,
  
  X_train <-read.table("UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
  Y_train <-read.table("UCI HAR Dataset/train/Y_train.txt",col.names = "Activity")
  subject_train <-read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "Subject")
  
  X_train <- cbind(subject_train,Y_train,X_train)
  
  ##Add Activity Column
  
  ##merge sets
  
  total_set <- merge(X_test,X_train,all=TRUE)
  ##print(length(total_set))
  ##print(names(total_set[560:562]))
  
  ##Extract names that have means & st.deviations
  
  total_set <- total_set[grepl("Mean|std|mean|Subject|Activity", names( total_set ))]
  
  ##Rename columns
  
  ##f is Fourier Transform, only if first letter
  ##t is time domain, only if first letter
  ##Acc is Acceleration
  ##Mag is Magnitude
  
  names(total_set) <- sub("^t", "TimeDomain", names(total_set))
  names(total_set) <- sub("^f","FourierTransform",names(total_set))
  names(total_set) <- sub("Acc","Acceleration", names(total_set))
  names(total_set) <- sub("Freq","Frequency", names(total_set))
  names(total_set) <- sub("Mag", "Magnitude", names(total_set))
  names(total_set) <- sub("std","StandardDeviation",names(total_set))
  names(total_set) <- sub("\\.\\.\\.","InThe",names(total_set))
  names(total_set) <- sub("X","XAxis", names(total_set))
  names(total_set) <- sub("Y","YAxis", names(total_set))
  names(total_set) <- sub("Z","ZAxis", names(total_set))
  names(total_set) <- sub("AxisAxis","Axis",names(total_set))
  names(total_set) <- sub("mean","Mean", names(total_set))
  names(total_set) <- sub("\\.\\.","",names(total_set))
  names(total_set) <- sub("\\.","",names(total_set))
  names(total_set) <- sub("anglet","TimeDomainAngle",names(total_set))
  
  ##print(names(total_set))
  
  ##Rename activities
  total_set$Activity <- as.character(total_set$Activity)
  total_set$Activity[total_set$Activity == "1"] <- "WALKING"
  total_set$Activity[total_set$Activity == "2"] <- "WALKING_UPSTAIRS"
  total_set$Activity[total_set$Activity == "3"] <- "WALKING_DOWNSTAIRS"
  total_set$Activity[total_set$Activity == "4"] <- "SITTING"
  total_set$Activity[total_set$Activity == "5"] <- "STANDING"
  total_set$Activity[total_set$Activity == "6"] <- "LAYING"
  
  ## Melt Set
  
  setMelt <- melt(total_set,id=c("Activity","Subject"))
  
  ##Cast Set taking averages - HURRAY!
  
  casted_set <- dcast(setMelt, Activity + Subject ~ variable,mean)
  
  ##print(total_set$Activity[4000:4200])
  ##Calculate average for each activity and each subject

  