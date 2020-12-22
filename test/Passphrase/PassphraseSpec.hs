{-# LANGUAGE NoImplicitPrelude #-}
module Passphrase.PassphraseSpec (spec) where

import           Passphrase (passphrase, toTuple)
import           RIO
import qualified RIO.Text   as T
import           Test.Hspec

spec :: Spec
spec = do
  describe "passphrase" $ do
    it "generates a passphrase" $ do
      wordlist <- T.unpack <$> readFileUtf8 "data/eff-large-wordlist.txt"
      let dice = [ [2, 1, 2, 1, 5]
                 , [1, 1, 1, 1, 1]
                 , [6, 1, 5, 2, 2]
                 ]
      passphrase wordlist dice `shouldBe` "cough abacus syndrome"

  describe "toTuple" $ do
    context "when the list is empty" $ do
      it "returns a pair of (0, '')" $ do
        toTuple [] `shouldBe` (0, "")

    context "when two strings are provided" $ do
      it "returns a pair of the two first values" $ do
        toTuple ["11111", "abacus"] `shouldBe` (11111, "abacus")

    context "when more than two strings are provided" $ do
      it "returns a pair of the two first values" $ do
        toTuple ["42", "foo", "bar", "baz"] `shouldBe` (42, "foo")
