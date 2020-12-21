{-# LANGUAGE NoImplicitPrelude #-}
module Passphrase.Dice
  ( joinDigits
  , rollDice
  ) where

import           Control.Monad          (replicateM)
import           Crypto.Number.Generate (generateBetween)
import           RIO
import qualified RIO.List               as L

joinDigits :: [Integer] -> Int
joinDigits digits = fromIntegral $ L.foldl ((+) . (* 10)) 0 digits

rollDice :: Int -> Integer -> Integer -> IO [Integer]
rollDice n start end = replicateM n $ generateBetween start end
