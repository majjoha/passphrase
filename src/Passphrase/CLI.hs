{-# LANGUAGE NoImplicitPrelude #-}
module Passphrase.CLI
  ( Arguments(..)
  , defaultWordlist
  , defaultLength
  , parseArguments
  , versionNumber
  ) where

import           Data.Version        (showVersion)
import           Options.Applicative
import           Paths_passphrase    (version)
import           RIO

data Arguments = Arguments
  { argumentsWordlist :: !FilePath
  , argumentsLength   :: !Int
  , argumentsVersion  :: !Bool
  }

defaultWordlist :: FilePath
defaultWordlist = "data/eff-large-wordlist.txt"

defaultLength :: Int
defaultLength = 6

versionNumber :: String
versionNumber = showVersion version

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

parseVersion :: Parser Bool
parseVersion =
  switch $
    help "Print version information and exit"
      <> short 'v'
      <> long "version"

parser :: Parser Arguments
parser = Arguments
  <$> parseWordlist
  <*> parseLength
  <*> parseVersion

parseArguments :: IO Arguments
parseArguments =
  execParser $ parser `withInfo` "Strong Diceware passphrase generator"
