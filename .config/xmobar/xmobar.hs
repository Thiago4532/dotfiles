-- IMPORTS
import Xmobar
import Data.List (intercalate)

join :: [[a]] -> [a]
join = intercalate []

-----------------------------------------------
-- Utils
--

mColor color s = join ["<fc=", color, ">", s, "</fc>"]
mAction action s = join ["<action=`", action, "`>", s, "</action>"]

mSeparator = mColor "#7c6f64" "  |  "
mLeftRightSep = "}{"

osIcon = mColor "#7daea3" "\xf303  Arch Linux"

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
        , fgColor = "#d4be98"
        , position = TopW L 100
        , iconRoot = ".config/xmobar/icons"
        , commands = [ Run $ Cpu ["-t", "\xf108  cpu: (<total>%)", "-L","3","-H","50","--high","#ea6962"] 20
                        , Run $ Memory ["-t","\xf233  mem: <used>M (<usedratio>%)"] 20
                        , Run $ Com "uname" ["-r"] "" 36000
                        , Run $ Date "\xf133  %b %d %Y - (%H:%M) " "date" 50
                        , Run $ Alsa "default" "Master" ["-t", "\xf028  vol: (<volume>%)<status>", "--", "-O", "", "-o", " [MUTE]", "-c", "red"]
                        , Run $ Battery ["-t", "\xf241   bat: (<left>% <acstatus>)"] 50
                        , Run $ Com "./.config/xmobar/scripts/trayer-padding-icon.sh" [] "trayerpad" 10
                        , Run StdinReader
                        ]
        , sepChar = "%"
        , alignSep = mLeftRightSep
        , template = join [ mAction "dmenu_run" osIcon
                           , mSeparator
                           , "%StdinReader%"
                           , mLeftRightSep
                           , "\xe712 %uname%"
                           , mSeparator
                           , mColor "#d8a657" $ mAction "kitty -e htop" "%cpu%"
                           , mSeparator
                           , mColor "#ea6962" $ mAction "kitty -e htop" "%memory%"
                           , mSeparator
                           , mColor "#a9b665" $ "%battery%"
                           , mSeparator
                           , mColor "#d386b9" $ mAction "pavucontrol" "%alsa:default:Master%"
                           , mSeparator
                           , mColor "#7daea3" "%date%"
                           , mSeparator
                           , "%trayerpad%"
                           ]
        }

main :: IO()
main = xmobar config
