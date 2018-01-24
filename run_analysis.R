#################################################################
# Script developed by Biswajit Khandai for Course project of
# Johns Hopkins Course on Data Cleaning
# January, 2018
#################################################################

library(dplyr)

# For a space-separated file with no headers, we will use read.table()
# not read.csv(), and header=FALSE. Also, if the number of spaces can
# be one or more, we will not use sep=" ". read.table() knows how to handle
# multiple spaces.

# "features.txt" has just one column. It has the names of
# 561 measurements. The quantity of each easurement for each subject
# appears as a column in each row of X_train.txt or X_test.txt

features_df <- read.table ("features.txt", header = FALSE, 
                           stringsAsFactors = FALSE)
measurement_names <- features_df$V2

# Replace parentheses, commas, and hyphens with underscore,
# and eliminate trailing underscores
measurement_names <- gsub("[(),-]+", "_", measurement_names)
measurement_names <- gsub("_$", "", measurement_names)

# "activity_labels.txt" contains two columns - the IDs and the names of
# 6 different activities,
# e.g. Walking, standing, laying etc.
activity_df <- read.table ("activity_labels.txt", header = FALSE,
                           stringsAsFactors = FALSE)
all_activity_names <- activity_df$V2

# "train/X_train.txt" has 7532 rows and 561 columns
# Each row represents a subject (individual) and all 561 direct and derived
# measurements for that individual

trng_tbl <- read.table("train/X_train.txt", header = FALSE,
                        stringsAsFactors = FALSE)

# "train/y_train.txt" has 7532 rows and 1 column.
# Each row has the label of the activity for the corresponding row of
# measurements subject (individual) and all 561 direct and derived
# measurements for that individual

trng_activity_ids <- read.table("train/y_train.txt", header = FALSE,
                                   stringsAsFactors = FALSE)

# We have to index into all_activity_names, which is a small list of
# activity names by trng_activty_ids, which is a list of 7532 ids. This
# ability is a nice feature of R.
trng_activity_labels <- all_activity_names[c(as.integer(trng_activity_ids$V1))]

# This is not a data frame. We need to convert it to a data frame
trng_activity_labels <- data.frame(trng_activity_labels)

# Right now, the colname is also "trng_activity_labels" (default).
# We will change it to "ActivityLabel"
colnames(trng_activity_labels) <- c("ActivityLabel")


# subject_train.txt contains the ID of the subject that each row of X_train.txt
# corresponds to.

trng_subject_ids <- read.table("train/subject_train.txt", header = FALSE,
                                stringsAsFactors = FALSE)

# Give the name "SubjectID" to this vector of subject-ids
names(trng_subject_ids) <- c("SubjectID")

# Modify the V1, V2, ... V561 column Ids in trng_tbl to match the
# measurement names
colnames(trng_tbl) <- measurement_names

# Now Insert the train_subject_ids vector (with column name = "SubjectID")
# as the first column of train_tbl

trng_tbl <- cbind(trng_subject_ids, trng_activity_labels, trng_tbl)

##################################################
# NOW DO THE SAME THING FOR THE TEST DATA        
##################################################

# "test/X_test.txt" has 2947 rows and 561 columns
# Each row represents a subject (individual) and all 561 direct and derived
# measurements for that individual

test_tbl <- read.table("test/X_test.txt", header = FALSE,
                       stringsAsFactors = FALSE)

# "test/y_test.txt" has 2947 rows and 1 column.
# Each row has the label of the activity for the corresponding row of
# measurements subject (individual) and all 561 direct and derived
# measurements for that individual

test_activity_ids <- read.table("test/y_test.txt", header = FALSE,
                                stringsAsFactors = FALSE)

# We have to index into all_activity_names, which is a small list of
# activity names by test_activty_ids, which is a list of 2947 ids. This
# ability is a nice feature of R.
test_activity_labels <- all_activity_names[c(as.integer(test_activity_ids$V1))]

# This is not a data frame. We need to convert it to a data frame
test_activity_labels <- data.frame(test_activity_labels)

# Right now, the colname is also "test_activity_labels" (default).
# We will change it to "ActivityLabel"
colnames(test_activity_labels) <- c("ActivityLabel")


# subject_test.txt contains the ID of the subject that each row of X_test.txt
# corresponds to.

test_subject_ids <- read.table("test/subject_test.txt", header = FALSE,
                               stringsAsFactors = FALSE)

# Give the name "SubjectID" to this vector of subject-ids
names(test_subject_ids) <- c("SubjectID")

# Modify the V1, V2, ... V561 column Ids in test_tbl to match the
# measurement names
colnames(test_tbl) <- measurement_names

# Now Insert the test_subject_ids vector (with column name = "SubjectID")
# as the first column of test_tbl

test_tbl <- cbind(test_subject_ids, test_activity_labels, test_tbl)

merged_tbl <- rbind(trng_tbl, test_tbl)

# Identify the columns that have mean and/or std in their names
mean_std_colnames = colnames(test_tbl)
mean_std_colids = grep("mean|std", mean_std_colnames, ignore.case = TRUE)
mean_std_colnames = mean_std_colnames[mean_std_colids]

# Keep only col1, col2, and the mean/std columns from merged table.
merged_tbl <- cbind(merged_tbl[1], merged_tbl[2], merged_tbl[c(mean_std_colids)])

# We have our final table. Time to write it out
write.table(merged_tbl, "merged_data.txt", row.names = FALSE)

# We can do group by explicitly, but it would be redundant, since we are
# going to use a "by" in the aggregate function
# merged_tbl2 <- group_by(merged_tbl, SubjectID, ActivityLabel)

avg_tbl <- aggregate(x = merged_tbl[, 3:88],
                     by = list(merged_tbl$SubjectID, merged_tbl$ActivityLabel),
                     FUN = mean)

# We have our averages table. Time to write it out
write.table(avg_tbl, "average_data.txt", row.names = FALSE)

