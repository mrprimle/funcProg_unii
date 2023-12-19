module Converter where


import Data.Text as T ( Text )
import Data.Time.Calendar as C ( Day, fromGregorian )
import Database.MySQL.Base
import qualified Data.ByteString.Lazy.Char8 as BSU
import Data.Binary.Put (runPut)
import Data.Int (Int32)
import Data.Time (parseTimeOrError, defaultTimeLocale )
import System.Console.Haskeline
    ( defaultSettings, getInputLine, runInputT )
import Data.ByteString.Lazy.Char8 (unpack)

genStruct :: [[MySQLValue]] -> Int -> [MySQLValue]
genStruct xs ind = foldr (\x -> (++) [x !! ind]) [] xs

myToString :: MySQLValue -> String
myToString val = unpack (runPut (putTextField val))

myToInt32 :: MySQLValue -> Int32
myToInt32 val = strToInt32 (myToString val)

readMaybe :: Read a => String -> Maybe a
readMaybe s = case reads s of
                  [(val, "")] -> Just val
                  _           -> Nothing
                  
strToInt32 :: String -> Int32
strToInt32 s = case (readMaybe s :: Maybe Int32) of
                Just val -> val
                _        -> 0

