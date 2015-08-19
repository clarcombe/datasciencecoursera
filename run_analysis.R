#Load Relevan libraries
library(tidyr)
library(dplyr)
library(rapport)

# Initialise all of the variables for the filenames
xtrainfile = file.path("train","X_train.txt")
ytrainfile = file.path("train","y_train.txt")
xtestfile = file.path("test","X_test.txt")
ytestfile = file.path("test","y_test.txt")
activitiesfile = file.path("activity_labels.txt")
featuresfile = file.path("features.txt")

# Read the features file (column position of X data and X data label )
features=read.table(file=featuresfile,colClasses = c("integer","character"))

# Only import mean and standard deviation columns mean() and std())
xcols=data.frame(features[grep("mean\\(\\)|std\\(\\)",features$V2),])
names(xcols)<-c("column","head")

# Make the column headings clear
# Convert to CamelCase
xcols$head<-tocamel(xcols$head)
# And make them more meaningful
xcols$head<-gsub("Acc","Accelerometer",xcols$head)
xcols$head<-gsub("Gyro","Gyroscope",xcols$head)
xcols$head<-gsub("Mag","Magnitude",xcols$head)
xcols$head<-gsub("BodyBody","Body",xcols$head)

#Transpose rows to make column names vector
names.xcols=t(xcols$head)

#Read train files and test files
xtrain<-read.table(file=xtrainfile)
xtest<-read.table(file=xtestfile)

ytrain<-read.table(file=ytrainfile)
ytest<-read.table(file=ytestfile)

#Assign column names for Y files
names(ytrain)<-"ActivityId"
names(ytest)<-"ActivityId"

#From imported X files,select only columns containing() mean or std() - previously calculated
xtrain<-select(xtrain,num_range("V",xcols$column))
xtest<-select(xtest,num_range("V",xcols$column))

# Add the enhanced column names to the x datasets
names(xtrain)<-names.xcols
names(xtest)<-names.xcols

# Merge Activity Columns (Y) with X 
train.ds<-bind_cols(ytrain,xtrain)
test.ds<-bind_cols(ytest,xtest)

# Build one final dataset of train and test data
one.ds<-bind_rows(train.ds,test.ds)

# Read the activities file
activities<-read.table(file=activitiesfile,col.names = c("ActivityId","Activity"))

# And join this to the final dataset via the ActivityId column
one.ds<-inner_join(activities,one.ds,by="ActivityId")

# Then remove the superfluous column ActivityId
one.ds$ActivityId<-NULL

# Now create the tidy dataset, by grouping by the Activity
two.ds<-group_by(one.ds,Activity)

# Then averaging by the Activity grouping
three.ds<-summarise_each(two.ds,funs(mean))

#Finally write out the file
tidy.ds.file<-file.path("colins.tidydataset.txt")
write.table(three.ds,tidy.ds.file,row.names=FALSE,sep=";")


