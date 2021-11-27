-- IMPORTS
import Xmobar
import Data.List (intercalate)
import System.Environment (getEnv)

import qualified Cfg.Colors as C

join' :: [[a]] -> [a]
join' = intercalate []

----------------------------------------------
-- Utils
--

mColor color s = join' ["<fc=", color, ">", s, "</fc>"]
mAction action s = join' ["<action=`", action, "`>", s, "</action>"]

mSeparator = mColor C.separator "  |  "
mLeftRightSep = "}{"

osIcon = mColor C.blue "\xf303  Arch Linux"

-----------------------------------------------
-- Configuration
--

config :: Config
config = defaultConfig {
        font = "xft:Ubuntu Nerd Font:weight=bold:pixelsize=12:antialias=true:hinting=true"
        , additionalFonts = [ "xft:Noto Color Emoji:pixelsize=12::antialias=true:hinting=true" ]
        , borderColor = "black"
        , border = TopB
        , bgColor = C.background
        , fgColor = C.white
        , position = TopW L 100
        , iconRoot = ".config/xmobar/icons"
        , commands = [ Run $ Cpu ["-t", "\xf108  cpu: (<total>%)", "-L","3","-H","50","--high",C.red] 20
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
        , template = join' [ osIcon
                           , mSeparator
                           , "%UnsafeStdinReader%"
                           , mLeftRightSep
                           , "\xe712 %uname%"
                           , mSeparator
                           , mColor C.cyan $ mAction "keyboard cycle" "\xf11c  key: %kbd%"
                           , mSeparator
                           , mColor C.yellow $ mAction "kitty -e htop" "%cpu%"
                           , mSeparator
                           , mColor C.red $ mAction "kitty -e htop" "%memory%"
                           , mSeparator
                           , mColor C.green $ "%battery%"
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
