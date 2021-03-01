{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module Logger.FileLogger where

import Control.Monad (when)
import Data.Text (Text, pack)
import qualified Data.Text.IO as TextIO
import Data.Time.Clock (getCurrentTime)
import Data.Time.Format (defaultTimeLocale, formatTime)
import Logger (Config(..), Handle(Handle), Level)
import qualified System.IO as IO

--------------------------------------------------------------------------------
new :: Config -> IO Handle
new Config {..} =
  case cFilePath of
    Nothing -> fail "file_path is not specified"
    Just filePath -> return (Handle $ fileLogger cLevel filePath)

fileLogger :: Level -> FilePath -> Level -> Text -> IO ()
fileLogger cLevel filePath level message =
  when (level >= cLevel) $ do
    fh <- IO.openFile filePath IO.AppendMode
    IO.hSetEncoding fh =<< IO.mkTextEncoding "UTF-8//TRANSLIT"
    time <- getCurrentTime
    let timestr = formatTime defaultTimeLocale "%F %T.%q" time
    TextIO.putStrLn $
      pack ("[" ++ timestr ++ " " ++ show level ++ "]") <> message
    IO.hClose fh
