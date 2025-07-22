module MyPlugins.UnsafeWatch (UnsafeWatch(..)) where

import Xmobar

import Control.Concurrent (threadDelay)
import Control.Monad (forever)

import System.IO
import System.Process

data UnsafeWatch = UnsafeWatch Program Args Alias
    deriving (Read, Show)

instance Exec UnsafeWatch where
    alias (UnsafeWatch p _ "") = p
    alias (UnsafeWatch _ _ a) = a

    start (UnsafeWatch "" _ _) cb = return "Empty" >>= cb
    start (UnsafeWatch p as _) cb =
        let createProc = (proc p as) {std_out = CreatePipe}
        in withCreateProcess createProc $ \_ (Just pOut) _ _ -> do
            hSetBuffering pOut LineBuffering

            forever $ hGetLine pOut >>= cb
