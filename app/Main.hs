{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Monad (replicateM)
import           Passphrase    (passphrase, rollDice)
import           RIO
import qualified RIO.Text      as T

main :: IO ()
main = do
  wordlist <- T.unpack <$> readFileUtf8 "data/eff-large-wordlist.txt"
  dice <- replicateM 6 $ rollDice 5 1 6
  runSimpleApp $ do
    logInfo . display . T.pack $ passphrase wordlist dice
