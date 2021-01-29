{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

import           Control.Monad (replicateM)
import           Options.Applicative
import           Passphrase    (passphrase, rollDice)
import           RIO
import qualified RIO.Text      as T

data Arguments = Arguments
  { wordlistFilePath :: FilePath
  }

defaultWordlist :: FilePath
defaultWordlist = "data/eff-large-wordlist.txt"

main :: IO ()
main = do
  Arguments {..} <- execParser argumentsInfo
  wordlist <- T.unpack <$> readFileUtf8 wordlistFilePath
  dice <- replicateM 6 $ rollDice 5 1 6
  runSimpleApp $ do
    logInfo . display . T.pack $ passphrase wordlist dice

argumentsInfo :: ParserInfo Arguments
argumentsInfo =
  info (helper <*> arguments) $
       fullDesc
    <> header "Passphrase"
    <> progDesc "Diceware passphrase generator"

arguments :: Parser Arguments
arguments = Arguments
  <$> wordlistFilePathArgument
  where
    wordlistFilePathArgument =
      strArgument $
           help "Word list file"
        <> value defaultWordlist
        <> metavar "WORDFILE"
