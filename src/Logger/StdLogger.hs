{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module Logger.StdLogger
  ( new
  ) where

import Control.Monad (when)
import Data.Text (Text, pack)
import qualified Data.Text.IO as TextIO
import Data.Time.Clock (getCurrentTime)
import Data.Time.Format (defaultTimeLocale, formatTime)
import Logger (Config(..), Handle(Handle), Level)

--------------------------------------------------------------------------------
new :: Config -> IO Handle
new Config {..} = return (Handle $ stdLogger cLevel)

stdLogger :: Level -> Level -> Text -> IO ()
stdLogger cLevel level message =
  when (level >= cLevel) $ do
    time <- getCurrentTime
    let timestr = formatTime defaultTimeLocale "%F %T.%q" time
    TextIO.putStrLn $
      pack ("[" ++ timestr ++ " " ++ show level ++ "]") <> message
