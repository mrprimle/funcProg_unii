module Lesson where


import qualified Data.Text as T ( Text, pack )
import Database.MySQL.Base
import Data.Int (Int32)
import qualified Text.PrettyPrint as TPrettyP ( ($+$), text, vcat, Doc, (<>), render )

import SQLConnection
import Table
import Converter


data LessonInfo = LessonInfo{
        tableName :: String,
        fieldNames :: [String],
        ids :: [Int32],
        names :: [String]
    } deriving Show



emptyLessonInstance :: LessonInfo
emptyLessonInstance = LessonInfo "Lesson" ["id", "name"] [] []

instance Table LessonInfo where
    getName tableInfo = tableName tableInfo

    getFieldNames tableInfo = [fieldNames tableInfo !! 0 | not (null (ids tableInfo))] ++
                        [fieldNames tableInfo !! 1 | not (null (names tableInfo))]

    getFieldValues (LessonInfo _ _ ids names) =
        map MySQLInt32 ids ++
        map (MySQLText . T.pack) names

    getMainFieldTables tableInfo = LessonInfo {
            tableName = tableName tableInfo,
            fieldNames = fieldNames tableInfo,
            ids = [],
            names = names tableInfo
        }
    
    isEmpty tableInfo = null (ids tableInfo) || null (names tableInfo)

    len tableInfo = fromEnum (not (null (ids tableInfo))) +
                    fromEnum (not (null (names tableInfo)))


     

    fromMySQLValues res = do
        vals <- res
        return (LessonInfo {
            tableName = tableName emptyLessonInstance,
            fieldNames = fieldNames emptyLessonInstance,
            ids = map myToInt32 (genStruct vals 0),
            names = map myToString (genStruct vals 1)
        })

    