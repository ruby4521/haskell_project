{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_my_project (
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
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/eddy/Desktop/cs583/my-project/haskell_project/.stack-work/install/x86_64-osx/372394fdf191ea1d75209a9ad089bdacc83092477c8ad6f75e4265a30a7be283/8.8.3/bin"
libdir     = "/Users/eddy/Desktop/cs583/my-project/haskell_project/.stack-work/install/x86_64-osx/372394fdf191ea1d75209a9ad089bdacc83092477c8ad6f75e4265a30a7be283/8.8.3/lib/x86_64-osx-ghc-8.8.3/my-project-0.1.0.0-5WexU1Fd3063gpKBcAmJ1i"
dynlibdir  = "/Users/eddy/Desktop/cs583/my-project/haskell_project/.stack-work/install/x86_64-osx/372394fdf191ea1d75209a9ad089bdacc83092477c8ad6f75e4265a30a7be283/8.8.3/lib/x86_64-osx-ghc-8.8.3"
datadir    = "/Users/eddy/Desktop/cs583/my-project/haskell_project/.stack-work/install/x86_64-osx/372394fdf191ea1d75209a9ad089bdacc83092477c8ad6f75e4265a30a7be283/8.8.3/share/x86_64-osx-ghc-8.8.3/my-project-0.1.0.0"
libexecdir = "/Users/eddy/Desktop/cs583/my-project/haskell_project/.stack-work/install/x86_64-osx/372394fdf191ea1d75209a9ad089bdacc83092477c8ad6f75e4265a30a7be283/8.8.3/libexec/x86_64-osx-ghc-8.8.3/my-project-0.1.0.0"
sysconfdir = "/Users/eddy/Desktop/cs583/my-project/haskell_project/.stack-work/install/x86_64-osx/372394fdf191ea1d75209a9ad089bdacc83092477c8ad6f75e4265a30a7be283/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "my_project_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "my_project_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "my_project_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "my_project_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_project_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_project_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
