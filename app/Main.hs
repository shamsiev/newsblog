{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.ByteString.Lazy.Internal (ByteString)
import Network.HTTP.Types
import Network.HTTP.Types.Header
import Network.Wai
import Network.Wai.Handler.Warp

--------------------------------------------------------------------------------
main :: IO ()
main = do
  let port = 3000
  putStrLn $ "Listening on port: " ++ show port
  run port app

--------------------------------------------------------------------------------
app :: Application
app req f =
  case pathInfo req of
    ["news"] -> f $ sendText "NEWS"
    ["authors"] ->
      case requestMethod req of
        "GET" -> f $ sendText "GETTING AUTHORS" -- for admins
        "POST" -> f $ sendText "CREATING AUTHORS" -- for admins
        "PUT" -> f $ sendText "EDITING AUTHORS" -- for admins
        "DELETE" -> f $ sendText "DELETING AUTHORS" -- for admins
    ["categories"] ->
      case requestMethod req of
        "GET" -> f $ sendText "GETTING CATEGORIES" -- for everyone
        "POST" -> f $ sendText "CREATING CATEGORIES" -- for admins
        "PUT" -> f $ sendText "EDITING CATEGORIES" -- for admins
        "DELETE" -> f $ sendText "DELETING CATEGORIES" -- for admins
    ["tags"] ->
      case requestMethod req of
        "GET" -> f $ sendText "GETTING TAGS" -- for everyone
        "POST" -> f $ sendText "CREATING TAGS" -- for admins
        "PUT" -> f $ sendText "EDITING TAGS" -- for admins
        "DELETE" -> f $ sendText "DELETING TAGS" -- for admins
    ["drafts"] ->
      case requestMethod req of
        "GET" -> f $ sendText "GETTING DRAFTS" -- for authors
        "POST" -> f $ sendText "CREATING DRAFTS" -- for authors
        "PUT" -> f $ sendText "EDITING DRAFTS" -- for authors
        "DELETE" -> f $ sendText "DELETING DRAFTS" -- for authors
    ["users"] ->
      case requestMethod req of
        "GET" -> f $ sendText "GETTING USERS" -- for everyone
        "POST" -> f $ sendText "CREATING USERS" -- for everyone
        "DELETE" -> f $ sendText "DELETING USERS" -- for admins
    -- ["comments"] -> -- for post
    --   case requestMethod req of
    --     "GET" -> f $ sendText "GETTING USERS" -- for everyone
    --     "POST" -> f $ sendText "CREATING USERS" -- for everyone
    --     "DELETE" -> f $ sendText "DELETING USERS" -- for admins
    _ -> f $ sendText "ERROR"

--------------------------------------------------------------------------------
sendText :: ByteString -> Response
sendText = responseLBS status200 [(hContentType, "text/plain")]
