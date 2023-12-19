module CheckTables where

import Database.MySQL.Base

import Table
import Students
import Teachers
import Lesson
import Task
import Message
import SQLConnection

checkStudents :: MySQLConn -> IO ()
checkStudents conn = do
    res <- addValue (StudentsInfo "Students" ["id", "name", "surname"] [] ["l"] ["m"]) conn
    print (res)

    res <- readAllValues emptyStudentsInstance conn
    print (res)

    res <- readValue (StudentsInfo "Students" ["id", "name", "surname"] [] ["l"] ["m"]) conn
    print res

    res <- updateValue (StudentsInfo "Students" ["id", "name", "surname"] [] ["u"] ["v"]) (StudentsInfo "Students" ["id", "name", "surname"] [] ["l"] ["m"]) conn
    print res

    res <- readAllValues emptyStudentsInstance conn
    print res

    deleteValue (StudentsInfo "Students" ["id", "name", "surname"] [] ["u"] ["v"]) conn
    print res

    res <- readAllValues emptyStudentsInstance conn
    print res

checkTeachers :: MySQLConn -> IO ()
checkTeachers conn = do
    res <- addValue (TeachersInfo "Teachers" ["id", "name", "surname"] [] ["l"] ["m"]) conn
    print (res)

    res <- readAllValues emptyTeachersInstance conn
    print (res)

    res <- readValue (TeachersInfo "Teachers" ["id", "name", "surname"] [] ["l"] ["m"]) conn
    print res

    res <- updateValue (TeachersInfo "Teachers" ["id", "name", "surname"] [] ["u"] ["v"]) (TeachersInfo "Teachers" ["id", "name", "surname"] [] ["l"] ["m"]) conn
    print res

    res <- readAllValues emptyTeachersInstance conn
    print res

    deleteValue (TeachersInfo "Teachers" ["id", "name", "surname"] [] ["u"] ["v"]) conn
    print res

    res <- readAllValues emptyTeachersInstance conn
    print res


checkLesson :: MySQLConn -> IO ()
checkLesson conn = do
    res <- addValue (LessonInfo "Lesson" ["id", "name"] [] ["s"]) conn
    print (res)

    res <- readAllValues emptyLessonInstance conn
    print (res)

    res <- readValue (LessonInfo "Lesson" ["id", "name"] [] ["s"]) conn
    print res

    res <- updateValue (LessonInfo "Lesson" ["id", "name"] [] ["s_s"]) (LessonInfo "Lesson" ["id", "name"] [] ["s"]) conn
    print res

    res <- readAllValues emptyLessonInstance conn
    print res

    res <- deleteValue (LessonInfo "Lesson" ["id", "name"] [] ["s_s"]) conn
    print res

    res <- readAllValues emptyLessonInstance conn
    print res

checkTask :: MySQLConn -> IO ()
checkTask conn = do
    res <- readAllValues emptyTaskInstance conn
    print (res)

    res <- addValue newData  conn
    print (res)

    res <- readAllValues emptyTaskInstance conn
    print (res)

    res <- readValue newData conn
    print res

    res <- updateValue updatedData newData conn
    print res

    res <- readAllValues emptyTaskInstance conn
    print res

    res <- deleteValue updatedData conn
    print res

    res <- readAllValues emptyTaskInstance conn
    print res

    where
        newData = (TaskInfo "Task" ["id", "student_id", "lesson_id", "name", "sum", "time_end"] [] [1] [1] ["Maths"] ["This summary of Maths course"] ["14:05:00"])
        updatedData = (TaskInfo "Task" ["id", "student_id", "lesson_id", "name", "sum", "time_end"] [] [1] [1] ["OOP"] ["This summary of OOP course"] ["14:10:00"])

    
checkMessage :: MySQLConn -> IO ()
checkMessage conn = do
    res <- readAllValues emptyMessageInstance conn
    print (res)

    res <- addValue newData  conn
    print (res)

    res <- readAllValues emptyMessageInstance conn
    print (res)

    res <- readValue newData conn
    print res

    res <- updateValue updatedData newData conn
    print res

    res <- readAllValues emptyMessageInstance conn
    print res

    res <- deleteValue updatedData conn
    print res

    res <- readAllValues emptyMessageInstance conn
    print res

    where
        newData = (MessageInfo "Message" ["id", "reciever_id", "sender_id", "time", "text"]) [] [1] [2] ["2021-11-15 15:10:00"] ["Message text"]
        updatedData = (MessageInfo "Message" ["id", "reciever_id", "sender_id", "time", "text"]) [] [1] [2] ["2021-11-15 11:10:00"] ["Message text"]




checkAllTables :: MySQLConn -> IO ()
checkAllTables conn = do 
    checkStudents conn
    checkTeachers conn
    checkLesson conn
    checkTask conn
    checkMessage conn
    