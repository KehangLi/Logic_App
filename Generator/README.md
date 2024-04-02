# This is the question Generator 

## Before you run this Generator
* Creat a database, then import two tables(questions.sql, users.sql) to your database.
* The version of my mysql is 8.0.36
* You should change the corresponding information about database settings in the document conf.yaml.
* You can adjust the number of generated questions in the document conf.yaml as you want. Normally, the total number should not more than 200.
* After that, please turn to serverside project Logic_App_Backend. 
* Generator will check whether question text already exists or not, if question text exists, then the number of generating will correspondingly reduce.