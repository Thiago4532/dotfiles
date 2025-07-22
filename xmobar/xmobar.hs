-- IMPORTS
import Xmobar
import Data.List (intercalate)
import System.Environment (getArgs)

import qualified Cfg.Colors as C
import MyPlugins.CustomCommand

----------------------------------------------
-- Utils
--

join' :: [[a]] -> [a]
join' = intercalate []

mColor color s = join' ["<fc=", color, ">", s, "</fc>"]
mAction action s = join' ["<action=`", action, "`>", s, "</action>"]

mSeparator = mColor C.separator "  |  "
mLeftRightSep = "}{"

osIcon = mColor C.blue "\xf303  Arch Linux"

-----------------------------------------------
-- Configuration
--

batWattsCb :: String -> String
batWattsCb "" = ""
batWattsCb (gpu:watts) = color $ mAction "scripts/bat-notify" $ join' ["\xf140b", watts, " W", mSeparator]
    where color = case gpu of
                    'E' -> mColor C.red
                    _   -> mColor C.yellow

config :: Config
config = defaultConfig {
        font = "Ubuntu Nerd Font Bold 9"
        , border = NoBorder
        , bgColor = C.background
        , fgColor = C.white
        , position = TopW L 100
        , iconRoot = "icons"
        , commands = [ Run $ Cpu ["-t", "\xf108  <total>%", "-L","3","-H","50","--high",C.red] 20
                        , Run $ Memory ["-t","\xf233  <usedratio>%"] 20
                        , Run $ Com "uname" ["-r"] "" 36000
                        , Run $ CustomCommand "scripts/bat-discharging" [""] batWattsCb "" "bat-watts" 15
                        , Run $ Date "\xf133  %b %d %Y - (%H:%M) " "date" 10
                        , Run $ Alsa "default" "Master" ["-t", "\xf028  <volume>%<status>", "--", "-O", "", "-o", " [MUTE]", "-c", "red"]
                        , Run $ Battery ["-t", "\xf241   <left>% <acstatus>"] 50
                        , Run $ CommandReader "scripts/trayer-padding-icon" "trayerpad"
                        -- , Run $ CommandReader "/home/thiagomm/acti/logger/hub-activity.sh" "hub-activity"
                        , Run $ CommandReader "scripts/xmobar-message.sh" "hub-activity"
                        , Run $ Kbd []
                        , Run $ UnsafeXMonadLog
                     ]
        , sepChar = "%"
        , alignSep = mLeftRightSep
        , template = join' [ osIcon
                           , mSeparator
                           , "%UnsafeXMonadLog%"
                           , mLeftRightSep
                           -- , mColor C.red $ mAction "notifica" "Amanda"
                           -- , mSeparator
                           , "%hub-activity%"
                           , "%bat-watts%"
                        -- , mSeparator
                           , "\xe712 %uname%"
                           , mSeparator
                           , mColor C.cyan $ mAction "keyboard cycle" "\xf11c  %kbd%"
                           , mSeparator
                           , mColor C.yellow $ mAction "kitty -e htop" "%cpu%"
                           , mSeparator
                           , mColor C.red $ mAction "kitty -e htop" "%memory%"
                           , mSeparator
                           , mColor C.green $ mAction "xfce4-power-manager-settings" "%battery%"
                           , mSeparator
                           , mColor C.magenta $ mAction "pavucontrol" "%alsa:default:Master%"
                           , mSeparator
                           , mColor C.blue $ mAction "kitty -e calcurse" "%date%"
                           , mSeparator
                           , "%trayerpad%"
                           ]
        }

main :: IO()
main = xmobar config 
