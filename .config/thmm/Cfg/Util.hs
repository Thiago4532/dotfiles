module Cfg.Util where

--------------------------------------
-- Colors utility

-- Convert "#ff0000" to "0xff0000"
color2hex :: String -> String
color2hex (_:c) = '0':'x':c
