module Passphrase.Dice
  ( joinDigits
  ) where

joinDigits :: [Int] -> Int
joinDigits = foldl ((+) . (* 10)) 0
