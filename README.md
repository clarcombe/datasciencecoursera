ReadMe.Md 
Pre requisites
Packages
Before running the run_analysis.R, please ensure that you have installed the following packages.
Install.packages(tidyr)
Install.packages (dplyr)
Install.packages (rapport)

Source Files
Additionally, please make sure that you set the working directory to the top level directory above the test and train directories for example
Setwd(“E:/Coursera/Course3/Course Project/getdata”) where
E:/Coursera/Course3/Course Project/getdata/test and E:/Coursera/Course3/Course Project/getdata/train are two subdirectories which contain the data.

Output file
The tidy data will be created in the current working directory with the filename of colins.tidydataset.txt. If you would like to look at the table you can use the following code (assuming the file is in the current working directory)

newtable<-read.table("colins.tidydataset.txt",sep=";")
View(newtable)


Objectives of the test
My understanding of the objective was to 

Combine all of the rows from all four data sets into the following type of result
Activity	tBodyAcceleratorMeanX	..Y..Z	tBodyAcceleratorStdX	…Y..Z	..MEAN	..STD
WALKING	    9999.99	                9999.99	9999.99	                9999.99	9999.99	9999.99
…LAYING	    9999.99	                9999.99	9999.99	                9999.99	9999.99	9999.99

For the Mean and Std I assumed this meant all columns ending in mean() and std(). All others are ignored

How the R script works

Load Relevant libraries
Initialise all of the variables for the filenames
Read the features file (column position of X data and X data label )
Only import mean and standard deviation columns mean() and std())
Make the column headings clear
Convert to CamelCase
And make them more meaningful
Transpose rows to make column names vector
Read train files and test files
Assign column names for Y files
From imported X files,select only columns containing() mean or std() - previously calculated
Add the enhanced column names to the x datasets
Merge Activity Columns (Y) with X 
Build one final dataset of train and test data
Read the activities file
And join this to the final dataset via the ActivityId column
Then remove the superfluous column ActivityId
Now create the tidy dataset, by grouping by the Activity
Then averaging by the Activity grouping
Finally write out the file


CodeBook Markdown

Tidy Data Text File
