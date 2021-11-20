module Self.Colors where

----------------------------------------
-- Colors
black = "#32302f"
red = "#ea6962"
green = "#a9b665"
yellow = "#d8a657"
orange = "#e78a4e"
blue = "#7daea3"
magenta = "#d3869b"
violet = "#a587d3"
cyan = "#89b482"
white = "#d4be98"

background = "#282828"
foreground = white

normalBorder = black
focusedBorder = red

separator = "#7c6f64"

----------------------------------------
-- Functions

-- Convert "#ff0000" to "0xff0000"
hashtag2hex :: String -> String
hashtag2hex (_:c) = '0':'x':c
