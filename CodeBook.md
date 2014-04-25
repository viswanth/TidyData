Enlisted below are the list variables used in the script.

X_train : Data frame used to store the training set
X_test: Data frame used to store the testing set

features: Data frame used to store the 561 features in the data
feat_list: A vector of the 561 feature names

X_total: The merged data set of X_train and X_test

rmean: Names of columns with mean in the name. (mean and meanFreq are both included)
rmeanf: Names of columns with meanFreq in the name.
meancol: Names of columns only with mean and not meanFreq.(Set difference on rmean and rmeanf)
stdcol: Names of columns with std in the name.

X_meanstd: Data set with only the features of meancol and stdcol.

y_train: Activity codes of training data
y_test: Activity codes of test data
y_total: Activty codes of entire data

activity_data: Final data set with descriptive activity names.

tidy_data: Tidy Data set grouped by Subject abd Activity

outfile.txt: The Output Tidy Data set file.
