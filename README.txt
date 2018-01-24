==================================================================
Tidy data set generated from
Human Activity Recognition Using Smartphones Dataset
Version 1.0
by
Biswajit Khandai for Coursera Project

==================================================================
Source data and description of the source data was taken from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
==================================================================

The dataset included the following files

"README.txt"       : This file

"run_analsys.R"    : An R script that takes the original data and performs the merging
                     of the training and test data. It also does further post-processing
                     by grouping and averaging the measurements by Subject and Activity.
                     The script is documented by comments within the script.

"Codebook.txt"     : A file containing the names of the features/parameters that were
                     directly measured/computed from the measured values.

"merged_data.txt"  : The first output data file as required in Step 4 of the course
                     project. It has the training and the test data merged into a single
                     set. Only the features that have "mean" or "std" in their names are
                     retained, and the names are simplified somewhat by replacing commas
                     and parentheses etc. with underscores. The names are quite self-
                     descriptive.

"average_data.txt" : The second output data file as required in Step 4 of the course
                     project. It groups all the rows of "merged_data.txt" into groups
                     (by Subjects and Activities). It then computes the average of each
                     such group. It turns out that measurements exist for all 180 possible
                     Subject-Activity combinations (30 Subjects x 6 Activities).


Notes:
======
- Features are normalized and bounded within [-1,1].


License:
========
Use of the "source" dataset is acknowledged by referencing
the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using
a Multiclass Hardware-Friendly Support Vector Machine. International
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or
explicit can be addressed to the authors or their institutions for its
use or misuse. Any commercial use is prohibited.

Biswajit Khandai
January 2018
