DROP DATABASE IF EXISTS haskell_project;
CREATE DATABASE IF NOT EXISTS haskell_project;
USE haskell_project;


DROP TABLE IF EXISTS Students;

CREATE TABLE IF NOT EXISTS Students (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(256) NOT NULL,
surname VARCHAR(256) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Teachers(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(256) NOT NULL,
surname VARCHAR(256) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Teacher_Student(
student_id INT NOT NULL,
teacher_id INT NOT NULL,
FOREIGN KEY (student_id) REFERENCES Students(id),
FOREIGN KEY (teacher_id) REFERENCES Teachers(id)
);

CREATE TABLE IF NOT EXISTS Lesson(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(256) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Task(
id INT NOT NULL AUTO_INCREMENT,
student_id INT NOT NULL,
lesson_id INT NOT NULL,
name VARCHAR(256) NOT NULL,
sum VARCHAR(256) NOT NULL,
time_end TIME NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Message(
id INT NOT NULL AUTO_INCREMENT,
reciever_id INT NOT NULL,
sender_id INT NOT NULL,
text VARCHAR(256) NOT NULL,
time DATETIME NOT NULL,
PRIMARY KEY (id)
);


INSERT INTO Students(name, surname) VALUES ('st1', 'st1_s');
INSERT INTO Students(name, surname) VALUES ('st2', 'st2_s');

INSERT INTO Teachers(name, surname) VALUES ('teacher1', 'teacher1_s');
INSERT INTO Teachers(name, surname) VALUES ('teacher2', 'teacher2_s');

INSERT INTO Lesson(name) VALUES ('section_1');
INSERT INTO Lesson(name) VALUES ('section_2');


INSERT INTO Task(student_id, lesson_id, name, sum, time_end) VALUES (1,1, 'OOOP','This is summary','12:20:00');

