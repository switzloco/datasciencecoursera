datasciencecoursera
===================

<Before the assignment>
This data was measured from 30 users (subjects) performing 6 different activities (Activities). The subjects carried a smartphone that recorded their gyroscope and accelerometer data. 

The data was then processed creating 581-features per measurement. The data was separated into Test and Training folders.

<Assignment work>

The feature data from both the Training and the Test folders was then combined with the Subject and Activity data from separate files.

At that point, the data frame had 583 columns (Activity, Subject, 581 feature columns).

Then, the features columns were reduced using Regular Expressions to only features that were means or standard deviations from the measurement data.

Then the Activities were uncoded from a 1-6 format to human readable Activity names such as "WALKING".

The feature column names were renamed using sub & regex commands to human-readable feature names.

The dataframe was then melted identifying the Activity and Subject column as the ID columns, and the remaining feature columns as the variables. The dataframe changed from wide to long/skinny.

The averages for each remaining feature were taken for each Activity-Subject combination, resulting in 180 average values (6 Activities for 30 Subjects).
