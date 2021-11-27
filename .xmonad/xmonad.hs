{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, PatternGuards, TypeSynonymInstances, DeriveDataTypeable, LambdaCase, MultiWayIf #-}
-- IMPORTS

import XMonad
import Control.Monad
import Data.List
import Data.Maybe
import Data.Monoid
import GHC.IO.Handle.Types (Handle)
import System.Exit
import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- Hooks
import XMonad.Hooks.DynamicBars
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

-- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants
import XMonad.Layout.IndependentScreens
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Minimize
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Simplest
import qualified XMonad.Layout.BoringWindows as BW

-- Actions
import XMonad.Actions.Commands
import XMonad.Actions.SpawnOn
import XMonad.Actions.Minimize

-- Utility
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

-- System
import System.Posix.Env (putEnv)

-- Configuration
import qualified Cfg.Colors as C
import qualified Cfg.Util as U

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "kitty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9","NSP"]

------------------------------------------------------------------------
-- Utility functions
--

picomCmd = "picom"

picomToggle :: X()
picomToggle = spawn $ "pkill -x picom || " ++ picomCmd


-- Fullscreen support
-- https://www.reddit.com/r/xmonad/comments/gc4b9i/what_is_the_best_way_to_make_xmonad_respect_true/
--
setFullscreenSupported :: X ()
setFullscreenSupported = addSupported ["_NET_WM_STATE", "_NET_WM_STATE_FULLSCREEN"]
    where
        addSupported props = withDisplay $ \dpy -> do
            r <- asks theRoot
            a <- getAtom "_NET_SUPPORTED"
            newSupportedList <- mapM (fmap fromIntegral . getAtom) props
            io $ do
              supportedList <- fmap (join . maybeToList) $ getWindowProperty32 dpy a r
              changeProperty32 dpy r a aTOM propModeReplace (nub $ newSupportedList ++ supportedList)

-- Float and center the window
-- https://www.reddit.com/r/xmonad/comments/gzq316/how_can_i_centre_a_floating_window_without/
--
centerWindow :: Window -> X ()
centerWindow win = do
    (_, W.RationalRect x y w h) <- floatLocation win
    windows $ W.float win (W.RationalRect ((1 - w) / 2) ((1 - h) / 2) w h)
    return ()

-- actionList :: [(String, X())]
-- actionList = 
--     [ ("mirror: Mirror the current layout",          sendMessage $ Toggle MIRROR)
--     , ("float: Float and center the focused window", withFocused $ centerWindow )] 

------------------------------------------------------------------------

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- toggle picom
    , ((modm .|. shiftMask, xK_F12   ), picomToggle)

    -- launch rofi (run)
    , ((modm,               xK_p     ), spawn "rofi -modi run -no-show-icons -show")
    
    -- launch rofi
    , ((modm .|. shiftMask, xK_p     ), spawn "rofi -show")
    , ((modm .|. shiftMask, xK_r     ), spawn "rofi -show window")
    
    -- emoji picker
    , ((modm .|. shiftMask, xK_e     ), spawn "rofimoji")

    -- launch networkmanager_dmenu
    , ((modm,               xK_w     ), spawn "networkmanager_dmenu")
    
    -- launch firefox
    , ((modm              , xK_f     ), spawn "firefox")

    -- launch KeePassXC
    , ((modm .|. shiftMask, xK_h     ), namedScratchpadAction scratchpads "keepassxc")

    -- launch popup terminal
    , ((modm .|. controlMask, xK_Return), namedScratchpadAction scratchpads "popupTerminal")

    -- launch vimwiki
    , ((modm              , xK_v     ), spawn "kitty nvim -- ~/Documents/vimwiki/index.wiki")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)


    -- Toggle gaps
    , ((modm .|. shiftMask, xK_g     ), sendMessage $ Toggle SPACING)

    -- Toggle fullscreen
    , ((modm .|. shiftMask, xK_f     ), sendMessage $ Toggle NBFULL)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), BW.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), BW.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), BW.focusUp  )

    -- Move focus to the master window
    -- , ((modm,               xK_m     ), withFocused minimizeWindow  )
    -- , ((modm .|. shiftMask, xK_m     ), withLastMinimized maximizeWindowAndFocus)

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    , ((modm,               xK_a), sendMessage MirrorShrink)
    , ((modm,               xK_z), sendMessage MirrorExpand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Float and center the focused window
    , ((modm .|. shiftMask, xK_t     ), withFocused $ centerWindow )
    
    -- Toggle mirror
    , ((modm .|. shiftMask, xK_m     ), sendMessage $ Toggle MIRROR)

    -- Action dmenu
    -- , ((modm .|. shiftMask, xK_a     ), runCommand actionList  )

    -- Increment the number of windows in the master area
    , ((modm .|. shiftMask, xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm .|. shiftMask, xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
    
    -- Cycle through keyboard layouts
    , ((modm .|. shiftMask, xK_u     ), spawn "keyboard cycle")

    -- Volume down
    , ((modm              , xK_q     ), spawn "xmonad --recompile; pkill xmobar; xmonad --restart")

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; pkill xmobar; xmonad --restart")
    
    -- Reset wifi
    , ((modm .|. shiftMask, xK_minus   ), spawn "reset-wifi")

    -- Session lock
    , ((modm .|. controlMask, xK_l   ), spawn "loginctl lock-session")

    -- Take a interactive screenshot (PrtSc)
    , ((noModMask         , 0xff61   ), spawn "maim -s --format=png | xclip -selection clipboard -t image/png && notify-send -t 1000 'Copied screenshot to clipboard!'")

    -- Take a screenshot (M-PrtSc)
    , ((modm              , 0xff61   ), spawn "maim --format=png | xclip -selection clipboard -t image/png && notify-send -t 1000 'Copied screenshot to clipboard!'")

    -- OCR script
    , ((modm              , xK_g     ), spawn "cgrab")
    
    -- OCR script
    , ((modm .|. shiftMask, xK_o     ), spawn "ocr")

    -- dunst: Pop one notification from history
    , ((modm              , xK_comma ), spawn "dunstctl history-pop")

    -- dunst: Close the last notification
    , ((modm           , xK_semicolon), spawn "dunstctl close")

    -- dunst: Action
    , ((modm              , xK_period), spawn "dunstctl action")
    
    -- Play/Pause music (XF86AudioPlay)
    , ((noModMask         ,0x1008ff14), spawn "playerctl play-pause")

    -- Previous music (XF86AudioPrev)
    , ((noModMask         ,0x1008ff16), spawn "playerctl previous")

    -- Next music (XF86AudioForward)
    , ((noModMask         ,0x1008ff17), spawn "playerctl next")

    -- Volume mute (XF86AudioMute)
    , ((noModMask         ,0x1008ff12), spawn "volume mute")

    -- Volume down (XF86AudioLowerVolume)
    , ((noModMask         ,0x1008ff11), spawn "volume -s 5 down")

    -- Volume up (XF86AudioRaiseVolume)
    , ((noModMask         ,0x1008ff13), spawn "volume -s 5 up")

    -- Brightness down (XF86MonBrightnessDown)
    , ((noModMask         ,0x1008ff03), spawn "brightness down")

    -- Brightness up (XF86MonBrightnessUp)
    , ((noModMask         ,0x1008ff02), spawn "brightness up")

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e}, Switch to physical/Xinerama screens 1, 2
    -- mod-shift-{w,e}, Move client to screen 1, 2
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_d, xK_s] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

mySmartBorders :: LayoutClass l a =>
     l a -> ModifiedLayout (ConfigurableBorder Ambiguity) l a
mySmartBorders = lessBorders OtherIndicated

mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

data SPACING = SPACING deriving (Read, Show, Eq, Typeable)
instance Transformer SPACING Window where
    transform _ x k = k (mySpacing 10 x) (\(ModifiedLayout _ x') -> x')

tall      = renamed [Replace "Tall"]
            $ mySmartBorders
            $ ResizableTall 1 (3/100) (1/2) []
grid      = mySmartBorders
            $ Grid (16/10)
accordion = mySmartBorders
            $ Accordion

myLayoutHook = avoidStruts $ BW.boringWindows
                           $ mkToggle (single MIRROR)
                           $ mkToggle (single NBFULL)
                           $ mkToggle (single SPACING) 
                           $ myLayout
    where myLayout =     tall
                     ||| grid
                     ||| accordion

------------------------------------------------------------------------
-- Window rules:

(=*) :: Eq a => Query [a] -> [a] -> Query Bool
q =* x = fmap (isInfixOf x) q

popupFloat = customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3) 
scratchpads = [ NS "keepassxc" "keepassxc"
                    (className =? "KeePassXC")
                    popupFloat,
                NS "popupTerminal" "kitty --class popup-terminal"
                    (className =? "popup-terminal")
                    popupFloat
              ]

myManageHook = composeOne [
      className =? "notification"                        -?> doFloat
    , className =? "MPlayer"                             -?> doFloat
    , className =? "Gimp"                                -?> doFloat
    , title     =? "LearnOpenGL"                         -?> doCenterFloat
    , title     =? "Picture-in-Picture"                  -?> doFloat
    , resource  =? "desktop_window"                      -?> doIgnore
    , resource  =? "kdesktop"                            -?> doIgnore
    , className =? "TelegramDesktop"                     -?> popupFloat
    , className =? "discord"                             -?> doShift ( myWorkspaces !! 8 )
    ] <+> manageSpawn
      <+> namedScratchpadManageHook scratchpads

------------------------------------------------------------------------
-- Event handling

myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Startup hook

xmobarSpawn :: ScreenId -> IO Handle
xmobarSpawn 0 = spawnPipe "xmobar-ghcup"
xmobarSpawn 1 = spawnPipe "xmobar-ghcup ~/.config/xmobar/xmobar-1.hs"

myStartupHook = do
    spawnOnce "setxkbmap -option altwin:swap_alt_win"
    setFullscreenSupported

    spawn "xset r rate 300 33"
    spawnOnce "xss-lock -- slock"
    spawnOnce "clingo"
    spawnOnce "dex -a"

    spawnAndDoOnce (doShift "NSP" <+> popupFloat) "keepassxc"

    spawnOnce "nitrogen --restore && conky"
    spawnOnce picomCmd

    dynStatusBarStartup xmobarSpawn mempty

    spawnOnce $ join ["pkill trayer; trayer --edge top --distance 2 --monitor primary"
                                        , " --align right --widthtype request"
                                        , " --iconspacing 8 --padding 6 --SetDockType true"
                                        , " --SetPartialStrut true --expand true --transparent true"
                                        , " --alpha 0 --height 16"
                                        , " --tint ", U.color2hex C.background]

------------------------------------------------------------------------
-- Log hook

-- Clickable workspaces
clickableWorkspaces :: String -> String
clickableWorkspaces =
    flip xmobarAction "1" =<< wrap "xdotool key 'super+" "'"

-- Xmobar PP
myXmobarPP currentColor = namedScratchpadFilterOutWorkspacePP $ xmobarPP
    { ppCurrent = xmobarColor currentColor "" . wrap "[" "]"
    , ppVisible = wrap "(" ")"
    , ppTitle = xmobarColor C.green "" . shorten 50
    , ppSep = xmobarColor C.separator "" "  |  "
    , ppLayout = xmobarAction "xdotool key 'super+space'"   "1"
               . xmobarAction "xdotool key 'super+shift+m'" "2"
               . xmobarAction "xdotool key 'super+shift+g'" "3"
               . xmobarColor C.magenta ""
    }

-- Active Xmobar
activeBar = myPP {
          ppCurrent =  ppCurrent myPP
        , ppVisible = ppVisible myPP . clickableWorkspaces
        , ppHidden = clickableWorkspaces
        } where myPP = myXmobarPP C.yellow

-- Non-active Xmobar
nonActiveBar = myXmobarPP C.red

------------------------------------------------------------------------
-- Run xmonad with the settings you specify.
--

javaHack :: XConfig l -> XConfig l
javaHack conf = conf
  { startupHook = startupHook conf
                    *> io (putEnv "_JAVA_AWT_WM_NONREPARENTING=1")
  }

main = do
    xmonad $ javaHack $ ewmh $ docks defaults {
        logHook = multiPP activeBar nonActiveBar
        }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = C.normalBorder,
        focusedBorderColor = C.focusedBorder,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook
    }
