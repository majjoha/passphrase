{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module Main where

import           Control.Monad       (replicateM)
import           Options.Applicative
import           Passphrase          (passphrase, rollDice)
import           RIO
import qualified RIO.Text            as T

data Arguments = Arguments
  { argumentsWordlist :: !FilePath
  , argumentsLength   :: !Int
  }

defaultWordlist :: FilePath
defaultWordlist = "data/eff-large-wordlist.txt"

defaultLength :: Int
defaultLength = 6

arguments :: Parser Arguments
arguments = Arguments
  <$> wordlistFilePathArgument
  <*> lengthArgument
    where
      wordlistFilePathArgument =
        strArgument $
          help "Wordlist file"
          <> value defaultWordlist
          <> metavar "WORDLIST"
      lengthArgument =
        option auto $
          help "Number of words"
          <> short 'n'
          <> showDefault
          <> value defaultLength
          <> metavar "LENGTH"

argumentsInfo :: ParserInfo Arguments
argumentsInfo =
  info (arguments <**> helper) $
    fullDesc
    <> progDesc "Strong six-word Diceware passphrase generator"

main :: IO ()
main = do
  Arguments {..} <- execParser argumentsInfo
  wordlist <- T.unpack <$> readFileUtf8 argumentsWordlist
  dice <- replicateM argumentsLength $ rollDice 5 1 6
  runSimpleApp $ do
    logInfo . display . T.pack $ passphrase wordlist dice
