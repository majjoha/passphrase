module Passphrase.Dice
  ( joinDigits
  , rollDice
  ) where

import           Control.Monad          (replicateM)
import           Crypto.Number.Generate (generateBetween)

joinDigits :: [Integer] -> Int
joinDigits digits = foldl ((+) . (* 10)) 0 $ map fromInteger digits

rollDice :: Int -> Integer -> Integer -> IO [Integer]
rollDice n start end = replicateM n $ generateBetween start end
