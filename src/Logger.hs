{-# LANGUAGE OverloadedStrings #-}

module Logger where

import Data.Text (Text, unpack)
import Data.Yaml (FromJSON(parseJSON), (.:), withObject, withText)
import Prelude hiding (error, log)

--------------------------------------------------------------------------------
newtype Handle =
  Handle
    { log :: Level -> Text -> IO ()
    }

--------------------------------------------------------------------------------
data Config =
  Config
    { cType :: Text
    , cLevel :: Level
    , cFilePath :: Maybe FilePath
    }
  deriving (Show)

instance FromJSON Config where
  parseJSON =
    withObject "Logger.Config" $ \o ->
      Config <$> o .: "type" <*> o .: "level" <*> o .: "file_path"

--------------------------------------------------------------------------------
data Level
  = Debug
  | Info
  | Warning
  | Error
  deriving (Ord, Eq)

instance Show Level where
  show Debug = "DEBUG"
  show Info = " INFO"
  show Warning = " WARN"
  show Error = "ERROR"

instance FromJSON Level where
  parseJSON =
    withText "Logger.Level" $ \t ->
      case t of
        "debug" -> pure Debug
        "info" -> pure Info
        "warning" -> pure Warning
        "error" -> pure Error
        _ -> fail $ "Unknown level: " ++ unpack t

--------------------------------------------------------------------------------
debug :: Handle -> Text -> IO ()
debug h = log h Debug

info :: Handle -> Text -> IO ()
info h = log h Info

warning :: Handle -> Text -> IO ()
warning h = log h Warning

error :: Handle -> Text -> IO ()
error h = log h Error
