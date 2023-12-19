module Task where


import qualified Data.Text as T ( Text, pack )
import Database.MySQL.Base
import Data.Int (Int32)
import qualified Text.PrettyPrint as TPrettyP ( ($+$), text, vcat, Doc, (<>), render )

import SQLConnection
import Table
import Converter

data TaskInfo = TaskInfo{
        tableName :: String,
        fieldNames :: [String],
        ids :: [Int32],
        studentIds :: [Int32],
        lessonIds :: [Int32],
        names :: [String],
        sums :: [String],
        timeEnd :: [String]

    } deriving Show

emptyTaskInstance :: TaskInfo
emptyTaskInstance = TaskInfo "Task" ["id", "student_id", "lesson_id", "name", "sum", "time_end"] [] [] [] [] [] []

instance Table TaskInfo where
    getName tableInfo = tableName tableInfo

    getFieldNames tableInfo = [fieldNames tableInfo !! 0 | not (null (ids tableInfo))] ++
                        [fieldNames tableInfo !! 1 | not (null (studentIds tableInfo))] ++ 
                        [fieldNames tableInfo !! 2 | not (null (lessonIds tableInfo))] ++
                        [fieldNames tableInfo !! 3 | not (null (names tableInfo))] ++
                        [fieldNames tableInfo !! 4 | not (null (sums tableInfo))] ++
                        [fieldNames tableInfo !! 5 | not (null (timeEnd tableInfo))]

    getFieldValues (TaskInfo _ _ ids studentIds lessonIds names sums timeEnd) =
        map MySQLInt32 ids ++
        map MySQLInt32 studentIds ++
        map MySQLInt32 lessonIds ++
        map (MySQLText . T.pack) names ++
        map (MySQLText . T.pack) sums ++
        map (MySQLText . T.pack) timeEnd

    getMainFieldTables tableInfo = TaskInfo {
            tableName = tableName tableInfo,
            fieldNames = fieldNames tableInfo,
            ids = [],
            studentIds = studentIds tableInfo,
            lessonIds = lessonIds tableInfo,
            names = names tableInfo,
            sums = sums tableInfo,
            timeEnd = timeEnd tableInfo
        }
    
    isEmpty tableInfo = null (ids tableInfo) || null (studentIds tableInfo) ||
                        null (studentIds tableInfo) || null (lessonIds tableInfo) ||
                        null (names tableInfo) || null (sums tableInfo) || null (timeEnd tableInfo)

    len tableInfo = fromEnum (not (null (ids tableInfo))) +
                    fromEnum (not (null (studentIds tableInfo))) +
                    fromEnum (not (null (lessonIds tableInfo))) +
                    fromEnum (not (null (names tableInfo))) +
                    fromEnum (not (null (sums tableInfo))) +
                    fromEnum (not (null (timeEnd tableInfo)))
                   
    fromMySQLValues res = do
        vals <- res
        return (TaskInfo {
            tableName = tableName emptyTaskInstance,
            fieldNames = fieldNames emptyTaskInstance,
            ids = map myToInt32 (genStruct vals 0),
            studentIds = map myToInt32 (genStruct vals 1),
            lessonIds = map myToInt32 (genStruct vals 2),
            names = map myToString (genStruct vals 3),
            sums = map myToString (genStruct vals 4),
            timeEnd = map myToString (genStruct vals 5)
        })

    