{-# LANGUAGE NoImplicitPrelude #-}
module Passphrase.CLISpec (spec) where

import           Passphrase
import           RIO
import           Test.Hspec

spec :: Spec
spec = do
  describe "defaultWordlist" $ do
    it "returns `data/eff-large-wordlist.txt`" $ do
      defaultWordlist `shouldBe` "data/eff-large-wordlist.txt"

  describe "defaultLength" $ do
    it "returns 6" $ do
      defaultLength `shouldBe` 6
