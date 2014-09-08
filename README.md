### Fellows, it left 15 minutes for me to write a documentation before the deadline to submit all project, so please be mercy. Documentation will not be cool. 

Note! Before running the script be sure you have "sqldf" R package installed at your machine. Otherwise, please run 
install.packages("sqldf") command before starting

Short description for the run_analysis.R: (for detailed description, please, see CodeBook.md or run_analysis.R)  
Step 1. First we combine datasets from Test and Train files with observations  
Step 2. We open file with column names and assign them to dataset. Also we get a subset only with means and std's  
Step 3. Then we join activities and their descriptions to the observation dataset  
Step 4. Then we join Subjects (people's codes) to the observation dataset  
Step 5. At last we calculate average of required fields (mean and std columns) grouped by activityName and SubNo

And write in a tudyDS.txt file