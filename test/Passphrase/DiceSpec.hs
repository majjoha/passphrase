{-# LANGUAGE NoImplicitPrelude #-}
module Passphrase.DiceSpec (spec) where

import           Passphrase
import           RIO
import           Test.Hspec

spec :: Spec
spec = do
  describe "joinDigits" $ do
    it "joins a list of `Int`s to a single `Int`" $ do
      joinDigits [] `shouldBe` 0
      joinDigits [1] `shouldBe` 1
      joinDigits [1, 2, 3] `shouldBe` 123

  describe "rollDice" $ do
    it "returns a sequence of random numbers in a range" $ do
      rollDice 2 1 1 `shouldReturn` [1, 1]
