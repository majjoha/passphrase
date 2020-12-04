module Passphrase.PassphraseSpec (spec) where

import           Passphrase.Passphrase
import           Test.Hspec

spec :: Spec
spec = do
  describe "passphrase" $
    it "returns" $ do
      passphrase `shouldReturn` ()
