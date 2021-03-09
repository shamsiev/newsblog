{-# LANGUAGE OverloadedStrings #-}

module Spec.Logger where

import Logger
  ( Level(Debug, Error, Info, Warning)
  , Logger(NoLogger)
  , debug
  , error
  , info
  , warning
  )
import Logger.Test (new)
import Prelude hiding (error)
import Test.Hspec (SpecWith, describe, it, shouldBe, shouldNotBe)

--------------------------------------------------------------------------------
test1 :: SpecWith ()
test1 =
  describe "Logger.debug" $ do
    it "minLevel = Debug" $ do
      h <- new Debug
      logger <- debug h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Info" $ do
      h <- new Info
      logger <- debug h "message"
      logger `shouldBe` NoLogger
    it "minLevel = Warning" $ do
      h <- new Warning
      logger <- debug h "message"
      logger `shouldBe` NoLogger
    it "minLevel = Error" $ do
      h <- new Error
      logger <- debug h "message"
      logger `shouldBe` NoLogger

--------------------------------------------------------------------------------
test2 :: SpecWith ()
test2 =
  describe "Logger.info" $ do
    it "minLevel = Debug" $ do
      h <- new Debug
      logger <- info h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Info" $ do
      h <- new Info
      logger <- info h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Warning" $ do
      h <- new Warning
      logger <- info h "message"
      logger `shouldBe` NoLogger
    it "minLevel = Error" $ do
      h <- new Error
      logger <- info h "message"
      logger `shouldBe` NoLogger

--------------------------------------------------------------------------------
test3 :: SpecWith ()
test3 =
  describe "Logger.warning" $ do
    it "minLevel = Debug" $ do
      h <- new Debug
      logger <- warning h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Info" $ do
      h <- new Info
      logger <- warning h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Warning" $ do
      h <- new Warning
      logger <- warning h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Error" $ do
      h <- new Error
      logger <- warning h "message"
      logger `shouldBe` NoLogger

--------------------------------------------------------------------------------
test4 :: SpecWith ()
test4 =
  describe "Logger.error" $ do
    it "minLevel = Debug" $ do
      h <- new Debug
      logger <- error h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Info" $ do
      h <- new Info
      logger <- error h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Warning" $ do
      h <- new Warning
      logger <- error h "message"
      logger `shouldNotBe` NoLogger
    it "minLevel = Error" $ do
      h <- new Error
      logger <- error h "message"
      logger `shouldNotBe` NoLogger
