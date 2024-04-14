module MyPlugins.CustomCommand (CustomCommand(..)) where

import Xmobar
import Text.Read

data CustomCommand = CustomCommand Program Args (String -> String) String Alias Rate

instance Show CustomCommand where
    show _ = error "show not implemented for CustomCommand"

instance Read CustomCommand where
    readPrec = error "read not implemented for CustomCommand"

instance Exec CustomCommand where
    alias (CustomCommand p _ _ _ "" _) = p
    alias (CustomCommand p _ _ _ a _)  = a

    start (CustomCommand prog args msgCb fail _ r) cb =
        start (ComX prog args fail "" r) (cb . msgCb)
