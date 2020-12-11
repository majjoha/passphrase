module Passphrase.DiceSpec (spec) where

import           Passphrase.Dice
import           Test.Hspec

spec :: Spec
spec = do
  describe "joinDigits" $ do
    it "joins a list of `Int`s to a single `Int`" $ do
      joinDigits [] `shouldBe` 0
      joinDigits [1] `shouldBe` 1
      joinDigits [1, 2, 3] `shouldBe` 123
