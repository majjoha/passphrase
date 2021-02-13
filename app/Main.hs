{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module Main where

import           Control.Monad       (replicateM)
import           Options.Applicative
import           Passphrase          (passphrase, rollDice)
import           RIO
import qualified RIO.Text            as T

newtype Arguments = Arguments
  { argumentsWordlist :: FilePath
  }

defaultWordlist :: FilePath
defaultWordlist = "data/eff-large-wordlist.txt"

arguments :: Parser Arguments
arguments = Arguments
  <$> wordlistFilePathArgument
  where
    wordlistFilePathArgument =
      strArgument $
           help "Word list file"
        <> value defaultWordlist
        <> metavar "WORDFILE"

argumentsInfo :: ParserInfo Arguments
argumentsInfo =
  info (helper <*> arguments) $
       fullDesc
    <> progDesc "Strong six-word Diceware passphrase generator"

main :: IO ()
main = do
  Arguments {..} <- execParser argumentsInfo
  wordlist <- T.unpack <$> readFileUtf8 argumentsWordlist
  dice <- replicateM 6 $ rollDice 5 1 6
  runSimpleApp $ do
    logInfo . display . T.pack $ passphrase wordlist dice
