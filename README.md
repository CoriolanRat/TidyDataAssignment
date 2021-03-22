---
title: "README"
output: html_document
---

The R script is run_analysis.R

activity_label, features are extracted as a data frame.
The test and train data sets are extracted as data frame independently (subject1 and subject2, set1 and set2, activity1 and activity2) and then combined using rbind command.

The data frame containing all the activity is run through a function to replace the code of the activity by its actual name (1 == WALKING etc).

list_of_measurements uses the grep command to return all the columns indexes of our data set where the mean() and std() functions have been applied.

A subset of the main data set is created by subsetting set using list_of_measurement and creating a new data frame called mydata that contains only the columns with mean() and std() measurements. The list of subjects and activity names is added to the data frame using the cbind command.

Finally, a loop over the total number of subjects and number of activities is used to create a temporary data frame containing for each subject and each activity, the measurements and calculate an average on each column. This is processed as a new data frame called new_data and after each loop, the new average (corresponding to a new subject and new activity) is appended at the end of the data frame using rbind command. A final command is used to rename the columns of the new_data using meaningful measurement names (same names as mydata data frame).


