{-# LANGUAGE NoImplicitPrelude #-}
module Passphrase.CLI
  ( Arguments(..)
  , defaultWordlist
  , defaultLength
  , parseArguments
  ) where

import           Options.Applicative
import           RIO

data Arguments = Arguments
  { argumentsWordlist :: !FilePath
  , argumentsLength   :: !Int
  }

defaultWordlist :: FilePath
defaultWordlist = "data/eff-large-wordlist.txt"

defaultLength :: Int
defaultLength = 6

withInfo :: Parser a -> String -> ParserInfo a
withInfo options description = info (options <**> helper) $ progDesc description

parseWordlist :: Parser FilePath
parseWordlist =
  strArgument $
    help "Wordlist file"
      <> value defaultWordlist
      <> metavar "WORDLIST"

parseLength :: Parser Int
parseLength =
  option auto $
    help "Number of words"
      <> short 'n'
      <> showDefault
      <> value defaultLength
      <> metavar "LENGTH"

parser :: Parser Arguments
parser = Arguments
  <$> parseWordlist
  <*> parseLength

parseArguments :: IO Arguments
parseArguments =
  execParser $ parser `withInfo` "Strong Diceware passphrase generator"
