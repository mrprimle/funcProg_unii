{-# LANGUAGE OverloadedStrings #-}
module SQLConnection where

import Data.Text as T ( Text )
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
import qualified Data.ByteString.Lazy.Char8 as BtSt ( pack )


connectDB :: IO MySQLConn
connectDB =
    connect
        defaultConnectInfo { ciPort = 3306,
                             ciUser = "root",
                             ciPassword = "home12345",
                             ciDatabase = "haskell_project"
                            }


closeDB :: MySQLConn -> IO ()
closeDB = close

getRidOfStream :: IO ([ColumnDef], Streams.InputStream [MySQLValue]) -> IO [[MySQLValue]]
getRidOfStream all = do
    (defs, is) <- all
    Streams.toList is

getDBName :: MySQLConn -> IO [[MySQLValue]]
getDBName conn = getRidOfStream (query_ conn "SELECT DATABASE();")
