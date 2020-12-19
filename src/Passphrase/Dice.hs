module Passphrase.Dice
  ( joinDigits
  , rollDice
  ) where

import           Control.Monad          (replicateM)
import           Crypto.Number.Generate (generateBetween)

joinDigits :: [Integer] -> Int
joinDigits d = foldl ((+) . (* 10)) 0 $ map (\x -> fromInteger x :: Int) d

rollDice :: Int -> Integer -> Integer -> IO [Integer]
rollDice n start end = replicateM n $ generateBetween start end
