{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_AlternativeVote (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [1,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/jozefstodulski/Library/Haskell/bin"
libdir     = "/Users/jozefstodulski/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/lib/ghc/AlternativeVote-1.0"
dynlibdir  = "/Users/jozefstodulski/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/lib/ghc/AlternativeVote-1.0"
datadir    = "/Users/jozefstodulski/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/share/AlternativeVote-1.0"
libexecdir = "/Users/jozefstodulski/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/libexec"
sysconfdir = "/Users/jozefstodulski/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "AlternativeVote_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "AlternativeVote_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "AlternativeVote_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "AlternativeVote_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "AlternativeVote_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "AlternativeVote_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
