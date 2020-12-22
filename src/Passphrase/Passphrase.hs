{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Passphrase.Passphrase
  ( passphrase
  , toTuple
  ) where

import           Passphrase.Dice (joinDigits)
import           RIO
import qualified RIO.List        as L
import qualified RIO.Map         as Map

passphrase :: String -> [[Integer]] -> String
passphrase wordlist dice =
  unwords $ map (\index -> Map.findWithDefault "" index wordMap) indices
    where
      indices = map joinDigits dice
      wordMap = Map.fromList $ map (toTuple . words) $ lines wordlist

toTuple :: [String] -> (Integer, String)
toTuple [] = (0, "")
toTuple (index:word) = (fromMaybe 0 index', fromMaybe "" word')
  where
    index' = readMaybe index :: Maybe Integer
    word' = L.headMaybe word
