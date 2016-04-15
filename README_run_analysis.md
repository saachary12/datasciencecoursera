The first 17 lines are where the files are accessed and the relevant information is merged. After that, all the information is merged together.
We then proceed to take the means of all the values for the ids (1-30) and activities (1-6) and store them in a 3-array.
From there, we set up a data frame based on the id and activity combinations (180 in total).
We did this by binding the rows to matrix construted with the combinations present. 
We added the names of the features to the data frame.
We used grep to remove the data based on the -mean() or -std(). 
And the we did the data removal based on the criterion collected with grep.
1-6 represent the ids for the activities. 
