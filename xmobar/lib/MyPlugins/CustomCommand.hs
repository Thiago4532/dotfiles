-- | A small xmobar plugin wrapper around 'ComX' that lets the caller
-- transform command output in Haskell before it is rendered.
--
-- Motivation:
-- the built-in 'Com'/'ComX' plugins can run a command and show its
-- stdout, but they do not provide a hook to post-process that output.
-- This wrapper keeps data collection in external scripts while keeping
-- xmobar presentation logic (colors, actions, separators, icons) in
-- the Haskell config.
--
-- In this repository it is used for @scripts/bat-discharging@:
-- the script emits a compact value such as @D12.34@ or @E12.34@ and
-- the callback in @xmobar.hs@ turns that into styled xmobar markup.
module MyPlugins.CustomCommand (CustomCommand(..)) where

import Xmobar
import Text.Read

-- | @CustomCommand program args render onFailure alias refreshRate@
--
-- This mirrors 'ComX', but adds a @render@ callback that receives the
-- command stdout and returns the final xmobar string.
data CustomCommand = CustomCommand Program Args (String -> String) String Alias Rate

instance Show CustomCommand where
    show _ = error "show not implemented for CustomCommand"

instance Read CustomCommand where
    readPrec = error "read not implemented for CustomCommand"

instance Exec CustomCommand where
    alias (CustomCommand p _ _ _ "" _) = p
    alias (CustomCommand p _ _ _ a _)  = a

    -- Delegate execution and failure handling to xmobar's 'ComX', then
    -- map the command output through the supplied renderer.
    start (CustomCommand prog args msgCb fail _ r) cb =
        start (ComX prog args fail "" r) (cb . msgCb)
