library("dpylr")

activityPeformed_vector <- read.table("C:/Users/sanka/datasciencecoursera/UCI HAR Dataset/train/Y_train.txt", header = TRUE, sep = ' ')
activityPeformed_vector1 <- read.table("C:/Users/sanka/datasciencecoursera/UCI HAR Dataset/test/Y_test.txt", header = TRUE, sep = ' ')
colnames(activityPeformed_vector) <- "activity"
colnames(activityPeformed_vector1) <- "activity"
merged_activity.data <- rbind(activityPeformed_vector, activityPeformed_vector1)
train_subject <-  read.table("C:/Users/sanka/datasciencecoursera/UCI HAR Dataset/train/subject_train.txt", header = TRUE, sep = ' ')
test_subject <- read.table("C:/Users/sanka/datasciencecoursera/UCI HAR Dataset/test/subject_test.txt", header = TRUE, sep = ' ')
colnames(train_subject) <- "ID"
colnames(test_subject) <- "ID"
merged_subject.data <- rbind(train_subject, test_subject)
X_Train <- read.csv("C:/Users/sanka/datasciencecoursera/UCI HAR Dataset/train/X_train.txt", sep="")
X_test <- read.csv("C:/Users/sanka/datasciencecoursera/UCI HAR Dataset/test/X_test.txt", sep="")
merged.data <- rbind(X_Train, X_test)
merged_all.data <- cbind(merged_subject.data, merged_activity.data, merged.data)
merged_array <- array(NA, dim=c(30,6,561))

for(i in 1:30)
{
  for(j in 1:6)
  {
    for(k in 3:563)
    {
      merged_array[i,j,k - 2] <- mean(merged_all.data[merged_all.data$ID == i & merged_all.data$activity == j, k])
    } 
  }  
} 

id_activity = matrix(0, ncol = 2, nrow = 180)

for(l in 1:180)
{
  a = (l %/% 6) + 1
  b = l %% 6
  
  id_activity[l, 1] = a
  id_activity[l, 2] = b
}

l = NULL

for(l in 1:180)
{
  if(l %% 6 == 0)
  {
    id_activity[l, 1] = id_activity[l, 1] - 1
    id_activity[l, 2] = id_activity[l, 2] + 6
  }
}

i = NULL
j = NULL
k = NULL
l = NULL
mns = NULL

for(i in 1:30)
{
  for(j in 1:6)
  {
    mrow = merged_array[i,j, ]
    mns = rbind(mns, mrow)
  }
}

merged_all_matrix = cbind(id_activity, mns)
merged_all_new <- as.data.frame(merged_all_matrix)

colnames(merged_all_new)[1] <- "ID"
colnames(merged_all_new)[2] <- "activity"

L = readLines("C:/Users/sanka/datasciencecoursera/UCI HAR Dataset/features.txt")
L_split <- strsplit(L, "\n")

for(k in 3:563)
{
  colnames(merged_all_new)[k] <- L_split[[k-2]]
}

P = grep("mean()|std()", names(merged_all_new), value=TRUE)
J = grep("(meanFreq())", names(merged_all_new), value=TRUE)
R = setdiff(P, J)

merged_filtered <- merged_all_new[ , union(c("ID", "activity"),R)] 

for(i in 1:180)
{
  if(i %% 6 == 1)
  {
           merged_filtered[i, 2] <- "WALKING"
  }
         
  if(i %% 6 == 2)
  {
           merged_filtered[i, 2] <- "WALKING_UPSTAIRS"
  }
         
  if(i %% 6 == 3)
  {
           merged_filtered[i, 2] <- "WALKING_DOWNSTAIRS"
  }
         
  if(i %% 6 == 4)
  {
           merged_filtered[i, 2] <- "SITTING"
  }
       
  if(i %% 6 == 5)
  {
           merged_filtered[i, 2] <- "STANDING"
  }
         
  if(i %% 6 == 0)
  {
           merged_filtered[i, 2] <- "LAYING"
  }
}
