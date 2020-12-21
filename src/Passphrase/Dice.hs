{-# LANGUAGE NoImplicitPrelude #-}
module Passphrase.Dice
  ( joinDigits
  , rollDice
  ) where

import           Control.Monad          (replicateM)
import           Crypto.Number.Generate (generateBetween)
import           RIO
import qualified RIO.List               as L

joinDigits :: [Integer] -> Integer
joinDigits = L.foldl ((+) . (* 10)) 0

rollDice :: Int -> Integer -> Integer -> IO [Integer]
rollDice rolls start end = replicateM rolls $ generateBetween start end
