-- Imports                                     
import System.IO
import System.Exit

import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers(doFullFloat, doCenterFloat, isFullscreen, isDialog)
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.SpawnOn
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
import XMonad.Actions.CycleWS
import XMonad.Hooks.UrgencyHook
import qualified Codec.Binary.UTF8.String as UTF8

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Cross(simpleCross)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.ByteString as B
import Control.Monad (liftM2)
import qualified DBus as D
import qualified DBus.Client as D

myStartupHook = do
    spawn "$HOME/.config/xmonad/scripts/autostart.sh"

-- Defining the colours
normBord = "#4c566a" -- Border colour for when a window is not in focus
focdBord = "#FF0000" -- Border colour for when a window is in focus

myModMask = mod4Mask -- Super key
encodeCChar = map fromIntegral . B.unpack
myFocusFollowsMouse = True
myBorderWidth = 2
myWorkspaces    = ["I","II","III","IV","V","VI","VII","VIII","IX"]
myBaseConfig = desktopConfig

-- window manipulations
myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title =? t --> doFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myIgnores]
    ]
    where
    myCFloats = ["feh", "mpv"]
    myTFloats = ["Downloads", "Save As..."]
    myRFloats = []
    myIgnores = ["desktop_window"]

myLayout = smartBorders (gaps [(U,29), (D,9), (R,9), (L,9)] ( avoidStruts $ spacingRaw True (Border 2 2 2 2) True (Border 5 5 5 5) True $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ tiled ) ||| noBorders(Full))
    where
        tiled = Tall nmaster delta tiled_ratio
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2


myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, 1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)) -- mod-button1, Set the window to floating mode and move by dragging
    , ((modMask, 2), (\w -> focus w >> windows W.shiftMaster)) -- mod-button2, Raise the window to the top of the stack
    , ((modMask, 3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)) -- mod-button3, Set the window to floating mode and resize by dragging
    ]

-- Keybinds
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  -- Super + function keys
  [ ((modMask .|. shiftMask , xK_Return ), spawn $ "wezterm" ) -- Spawn terminal, specifically wezterm
  , ((modMask, xK_p ), spawn $ "rofi -show drun") -- Spawn application launcher, like dmenu but prettier
  , ((modMask .|. shiftMask, xK_p ), spawn "firefox --new-instance --new-window --private-window")
  , ((modMask .|. shiftMask, xK_f ), spawn "firefox --new-instance --browser")
  , ((modMask, xK_s ), spawn "flameshot full -p $HOME/Pictures/screenshots") -- Spawn screenshot utility to screenshot the full screen
  , ((modMask .|. shiftMask, xK_s ), spawn "flameshot gui -s -p $HOME/Pictures/screenshots") -- Spawn screenshot utility to select screenshot area
  , ((modMask, xK_e ), spawn "Thunar") -- Spawn GUI file manager
  , ((modMask .|. shiftMask, xK_c ), kill) -- Close windows
  , ((modMask, xK_y), spawn $ "polybar-msg cmd toggle" ) -- Toggle Polybar on / off
  , ((modMask, xK_Tab ), windows W.focusDown) -- Switch focus to next window, pretty much an alt tab
  , ((modMask, xK_j ), windows W.focusDown) -- Switch focus to the next window, VIM style
  , ((modMask, xK_k ), windows W.focusUp) -- Switch focus to the previous window, VIM style
  , ((modMask, xK_m ), windows W.focusMaster) -- Switch focus to the master window
  , ((modMask, xK_Return ), windows W.swapMaster) -- Swap window with focus with Master window
  , ((modMask .|. shiftMask, xK_j ), windows W.swapDown) -- Swap window in focus with window below it
  , ((modMask .|. shiftMask, xK_k ), windows W.swapUp) -- Swap window in focus with the one above it
  , ((modMask .|. shiftMask, xK_m ), windows W.swapMaster) -- Swap window in focus with the Master window
  , ((modMask, xK_h ), sendMessage Shrink) -- Decrease Master stack size
  , ((modMask, xK_l ), sendMessage Expand) -- Increase Master stack size
  , ((modMask, xK_v), spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd'") -- View clipboard
  , ((modMask .|. shiftMask, xK_v), spawn "greenclip clear") -- Clear clipboard
  , ((modMask, xK_q ), spawn $ "xmonad --recompile && xmonad --restart") -- Reload xmonad
  , ((modMask .|. shiftMask , xK_q ), io (exitWith ExitSuccess)) -- Quit xmonad
  -- Multimedia keys
  , ((0, xF86XK_AudioMute), spawn $ "amixer -q set Master toggle") -- Mute audio output, uses ALSA though
  , ((0, xF86XK_AudioLowerVolume), spawn $ "amixer -q set Master 5%-") -- Lower audio volume by 5%
  , ((0, xF86XK_AudioRaiseVolume), spawn $ "amixer -q set Master 5%+") -- Raise audio volume by 5%
  , ((0, xF86XK_MonBrightnessUp),  spawn $ "brightnessctl s 5%+") -- Increase brightness by 5%
  , ((0, xF86XK_MonBrightnessDown), spawn $ "brightnessctl s 5%-") -- Decrease brightness by 5%
  , ((0, xF86XK_AudioPlay), spawn "playerctl play-pause") -- Pause / resume audio player
  , ((0, xF86XK_AudioPrev), spawn "playerctl previous") -- Play previous track
  , ((0, xF86XK_AudioNext), spawn "playerctl next") -- Play next track

  --  Xmonad layout keys
  , ((modMask, xK_space), sendMessage NextLayout) -- Cycle through layouts
  , ((controlMask .|. mod1Mask , xK_Left ), prevWS) -- Switch to workspace to the left of the current one
  , ((controlMask .|. mod1Mask , xK_Right ), nextWS) -- Switch to workspace to the right of the current one
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf) -- Set layout to default layout
  , ((modMask, xK_j), windows W.focusDown) -- Focus next window
  , ((modMask, xK_k), windows W.focusUp) -- Focus previous window
  , ((modMask .|. shiftMask, xK_m), windows W.focusMaster) -- Focus master window
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown) -- Swap window with focus with the one below it
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp) -- Swap the focused window with the previous window.
  , ((controlMask .|. shiftMask , xK_h), sendMessage Shrink) -- Shrink the master area.
  , ((controlMask .|. shiftMask , xK_l), sendMessage Expand) -- Expand the master area.
  , ((controlMask .|. shiftMask , xK_t), withFocused $ windows . W.sink) -- Push window back into tiling.
  , ((controlMask .|. modMask, xK_Left), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Right), sendMessage (IncMasterN (-1))) -- Decrement the number of windows in the master area.
  ]
  ++

  [((m .|. modMask, k), windows $ f i)

   | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]


      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)
      , (\i -> W.greedyView i . W.shift i, shiftMask)]]

  ++

  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_Left, xK_Right] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

main :: IO ()
main = do

    dbus <- D.connectSession
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]


    xmonad . ewmh $ ewmhFullscreen
            myBaseConfig

                {startupHook = myStartupHook
, layoutHook = myLayout ||| layoutHook myBaseConfig
, manageHook = manageSpawn <+> myManageHook <+> manageHook myBaseConfig
, modMask = myModMask
, borderWidth = myBorderWidth
, handleEventHook    = handleEventHook myBaseConfig
, focusFollowsMouse = myFocusFollowsMouse
, workspaces = myWorkspaces
, focusedBorderColor = focdBord
, normalBorderColor = normBord
, keys = myKeys
, mouseBindings = myMouseBindings
}
