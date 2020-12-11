module Passphrase.Dice
  ( joinDigits
  , rollDice
  ) where

import           Control.Monad (replicateM)
import           System.Random

joinDigits :: [Int] -> Int
joinDigits = foldl ((+) . (* 10)) 0

rollDice :: Int -> Int -> Int -> IO [Int]
rollDice n start end = replicateM n $ randomRIO (start, end)
