module Message where


import qualified Data.Text as T ( Text, pack )
import Database.MySQL.Base
import Data.Int (Int32)
import qualified Text.PrettyPrint as TPrettyP ( ($+$), text, vcat, Doc, (<>), render )

import SQLConnection
import Table
import Converter


data MessageInfo = MessageInfo{
        tableName :: String,
        fieldNames :: [String],
        ids :: [Int32],
        recieverids :: [Int32],
        senderids :: [Int32],
        time :: [String],
        text :: [String]
    } deriving Show



emptyMessageInstance :: MessageInfo
emptyMessageInstance = MessageInfo "Message" ["id", "reciever_id", "sender_id", "time", "text"] [] [] [] [] []

instance Table MessageInfo where
    getName tableInfo = tableName tableInfo

    getFieldNames tableInfo = [fieldNames tableInfo !! 0 | not (null (ids tableInfo))] ++
                        [fieldNames tableInfo !! 1 | not (null (recieverids tableInfo))] ++
                        [fieldNames tableInfo !! 2 | not (null (senderids tableInfo))] ++
                        [fieldNames tableInfo !! 3 | not (null (time tableInfo))] ++
                        [fieldNames tableInfo !! 4 | not (null (text tableInfo))]

    getFieldValues (MessageInfo _ _ ids recieverids senderids time text) =
        map MySQLInt32 ids ++
        map MySQLInt32 recieverids ++
        map MySQLInt32 senderids ++
        map (MySQLText . T.pack) time ++
        map (MySQLText . T.pack) text

    getMainFieldTables tableInfo = MessageInfo {
            tableName = tableName tableInfo,
            fieldNames = fieldNames tableInfo,
            ids = [],
            recieverids = recieverids tableInfo,
            senderids = senderids tableInfo,
            time = time tableInfo,
            text = text tableInfo
        }
    
    isEmpty tableInfo = null (ids tableInfo) || null (recieverids tableInfo) || 
                        null (senderids tableInfo) || null (time tableInfo) || null (text tableInfo)

    len tableInfo = fromEnum (not (null (ids tableInfo))) +
                    fromEnum (not (null (recieverids tableInfo))) +
                    fromEnum (not (null (senderids tableInfo))) +
                    fromEnum (not (null (time tableInfo))) +
                    fromEnum (not (null (text tableInfo)))

    fromMySQLValues res = do
        vals <- res
        return (MessageInfo {
            tableName = tableName emptyMessageInstance,
            fieldNames = fieldNames emptyMessageInstance,
            ids = map myToInt32 (genStruct vals 0),
            recieverids = map myToInt32 (genStruct vals 1),
            senderids = map myToInt32 (genStruct vals 2),
            time = map myToString (genStruct vals 3),
            text = map myToString (genStruct vals 4)
        })

    