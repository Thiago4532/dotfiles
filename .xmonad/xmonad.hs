{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, PatternGuards, TypeSynonymInstances, DeriveDataTypeable, LambdaCase, MultiWayIf #-}
-- IMPORTS

-- Base
import XMonad
import Control.Monad
import Data.List
import Data.Maybe
import Data.Monoid
import System.Exit
import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

-- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants
import XMonad.Layout.IndependentScreens (countScreens)
import XMonad.Layout.LayoutModifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing

-- Actions

-- Utility
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

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
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#32302f"
myFocusedBorderColor = "#d152ab"

------------------------------------------------------------------------
-- Utility functions
--

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

------------------------------------------------------------------------

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. controlMask,  xK_t  ), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch networkmanager_dmenu
    , ((modm,               xK_y     ), spawn "networkmanager_dmenu")
    
    -- launch firefox
    , ((modm              , xK_f     ), spawn "firefox &")

    -- launch qalc
    , ((modm              , xK_o     ), spawn "kitty -e qalc &")

    -- launch htop
    , ((modm .|. shiftMask, xK_h     ), spawn "kitty -e htop &")

    -- launch pavucontrol
    , ((modm .|. shiftMask, xK_p     ), spawn "pavucontrol")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    -- Toggle mirror
    , ((modm .|. shiftMask, xK_m     ), sendMessage $ Toggle MIRROR)
    
    -- Toggle gaps
    , ((modm .|. shiftMask, xK_g     ), sendMessage $ Toggle SPACING)

    -- Toggle fullscreen
    , ((modm .|. shiftMask, xK_f     ), sendMessage $ Toggle NBFULL)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

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

    -- Session lock
    , ((modm .|. controlMask, xK_l   ), spawn "loginctl lock-session")

    -- Turn off screen
    , ((modm .|. shiftMask  , xK_l   ), spawn "notify-send DPMS 'Turning off the screen...'; sleep 1; xset dpms force off")

    -- Restart WiFi (M-S-PrtSc)
    , ((modm .|. shiftMask, 0xff61   ), spawn "reset-wifi &")

    -- Take a interactive screenshot (PrtSc)
    , ((noModMask         , 0xff61   ), spawn "maim -s --format=png | xclip -selection clipboard -t image/png && notify-send -t 1000 'Copied screenshot to clipboard!'")

    -- Take a screenshot (M-PrtSc)
    , ((modm              , 0xff61   ), spawn "maim --format=png | xclip -selection clipboard -t image/png && notify-send -t 1000 'Copied screenshot to clipboard!'")
    
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
    , ((noModMask         ,0x1008ff11), spawn "volume down")

    -- Volume up (XF86AudioRaiseVolume)
    , ((noModMask         ,0x1008ff13), spawn "volume up")

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
        | (key, sc) <- zip [xK_e, xK_w] [0..]
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

-- mySmartBorders :: LayoutClass l a =>
--      l a -> ModifiedLayout (ConfigurableBorder Ambiguity) l a
-- mySmartBorders = lessBorders OtherIndicated

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

data SPACING = SPACING deriving (Read, Show, Eq, Typeable)
instance Transformer SPACING Window where
    transform _ x k = k (mySpacing 10 x) (\(ModifiedLayout _ x') -> x')

tall      = renamed [Replace "Tall"]
            $ smartBorders
            $ ResizableTall 1 (3/100) (1/2) []
grid      = smartBorders
            $ Grid (16/10)
accordion = smartBorders
            $ Accordion

myLayoutHook = avoidStruts $ mkToggle (single MIRROR)
                           $ mkToggle (single NBFULL)
                           $ mkToggle (single SPACING) 
                           $ myLayout
    where myLayout =     tall
                     ||| grid
                     ||| accordion

------------------------------------------------------------------------
-- Window rules:

myManageHook = composeAll [
      className =? "MPlayer"                             --> doFloat
    , className =? "Gimp"                                --> doFloat
    , className =? "notification"                        --> doFloat
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat
    , resource  =? "desktop_window"                      --> doIgnore
    , resource  =? "kdesktop"                            --> doIgnore
    , className =? "discord"                             --> doShift ( myWorkspaces !! 8 )
    ]

------------------------------------------------------------------------
-- Event handling

myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Startup hook

myStartupHook = do
    spawnOnce "xset r rate 300 30 &"
    spawnOnce "setxkbmap -option altwin:swap_alt_win &"
    setFullscreenSupported

    spawnOnce "lxsession &"
    spawnOnce "xss-lock -- i3lock -B 5 --composite --nofork --indicator --pass-screen-keys --pass-volume-keys &"

    spawnOnce "nitrogen --restore &"
    spawnOnce "picom --experimental-backends &"
    spawnOnce "nm-applet &"
    spawnOnce "trayer --edge top --distance 2 --monitor primary --align right --widthtype request --iconspacing 8 --padding 6 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x282828 --height 16 &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

clickableWorkspaces =
    flip xmobarAction "1" =<< wrap "xdotool key 'super+" "'"

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    n <- countScreens
    xmproc <- spawnPipe "xmobar"

    xmonad $ ewmh $ docks defaults {
        logHook = dynamicLogWithPP $ xmobarPP
                            { ppOutput = hPutStrLn xmproc
                            , ppCurrent = xmobarColor "#d8a657" "" . wrap "[" "]"
                            , ppTitle = xmobarColor "#a9b665" "" . shorten 50
                            , ppHidden = clickableWorkspaces
                            }
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
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook
    }
