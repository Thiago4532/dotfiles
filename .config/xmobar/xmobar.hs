-- IMPORTS
import Xmobar
import Control.Exception (try, SomeException)
import Data.List (intercalate)
import System.Environment (getEnv)

join :: [[a]] -> [a]
join = intercalate []

----------------------------------------------
-- Utils
--

mColor color s = join ["<fc=", color, ">", s, "</fc>"]
mAction action s = join ["<action=`", action, "`>", s, "</action>"]

mSeparator = mColor "#7c6f64" "  |  "
mLeftRightSep = "}{"

-- Colors
myBlack = "#32302f"
myRed = "#ea6962"
myGreen = "#a9b665"
myYellow = "#d8a657"
myBlue = "#7daea3"
myMagenta = "#d3869b"
myCyan = "#89b482"
myWhite = "#d4be98"

osIcon = mColor myBlue "\xf303  Arch Linux"

-----------------------------------------------
-- Configuration
--

config :: Config
config = defaultConfig {
        font = "xft:Ubuntu Nerd Font:weight=bold:pixelsize=12:antialias=true:hinting=true"
        , additionalFonts = [ "xft:Noto Color Emoji:pixelsize=12:antialias=true:hinting=true" ]
        , borderColor = "black"
        , border = TopB
        , bgColor = "#282828"
        , fgColor = myWhite
        , position = TopW L 100
        , iconRoot = ".config/xmobar/icons"
        , commands = [ Run $ Cpu ["-t", "\xf108  cpu: (<total>%)", "-L","3","-H","50","--high",myRed] 20
                        , Run $ Memory ["-t","\xf233  mem: <used>M (<usedratio>%)"] 20
                        , Run $ Com "uname" ["-r"] "" 36000
                        , Run $ Date "\xf133  %b %d %Y - (%H:%M) " "date" 10
                        , Run $ Alsa "default" "Master" ["-t", "\xf028  vol: (<volume>%)<status>", "--", "-O", "", "-o", " [MUTE]", "-c", "red"]
                        , Run $ Battery ["-t", "\xf241   bat: (<left>% <acstatus>)"] 50
                        , Run $ Com "./.config/xmobar/scripts/trayer-padding-icon.sh" [] "trayerpad" 20
                        , Run $ Kbd []
                        , Run $ UnsafeStdinReader
                        ]
        , sepChar = "%"
        , alignSep = mLeftRightSep
        , template = join [ osIcon
                           , mSeparator
                           , "%UnsafeStdinReader%"
                           , mLeftRightSep
                           , "\xe712 %uname%"
                           , mSeparator
                           , mColor myCyan $ mAction "keyboard cycle" "\xf11c  key: %kbd%"
                           , mSeparator
                           , mColor myYellow $ mAction "kitty -e htop" "%cpu%"
                           , mSeparator
                           , mColor myRed $ mAction "kitty -e htop" "%memory%"
                           , mSeparator
                           , mColor myGreen $ "%battery%"
                           , mSeparator
                           , mColor myMagenta $ mAction "pavucontrol" "%alsa:default:Master%"
                           , mSeparator
                           , mColor myBlue $ mAction "kitty -e calcurse" "%date%"
                           , mSeparator
                           , "%trayerpad%"
                           ]
        }

main :: IO()
main = xmobar config 
