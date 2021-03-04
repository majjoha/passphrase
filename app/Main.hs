{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module Main where

import           Control.Monad (replicateM)
import           Passphrase    (Arguments (..), parseArguments, passphrase,
                                rollDice, versionNumber)
import           RIO
import qualified RIO.Text      as T

main :: IO ()
main = do
  Arguments {..} <- parseArguments
  wordlist <- T.unpack <$> readFileUtf8 argumentsWordlist
  dice <- replicateM argumentsLength $ rollDice 5 1 6
  let result = if argumentsVersion
               then versionNumber
               else passphrase wordlist dice

  runSimpleApp $ do
    logInfo . display . T.pack $ result
