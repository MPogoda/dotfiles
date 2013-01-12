import Data.List            (isPrefixOf)
import Control.Applicative  ((<$>))
import System.Exit          (exitWith, ExitCode(..))

import XMonad                       hiding (Tall(..))
import XMonad.Actions.WindowGo      (runOrRaise)
import XMonad.Hooks.DynamicLog      (statusBar, xmobarPP, xmobarColor, ppCurrent, wrap)
import XMonad.Hooks.EwmhDesktops    (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks     (docksEventHook, ToggleStruts(..))
import XMonad.Layout.NoBorders      (smartBorders)
import XMonad.Layout.ResizableTile  (ResizableTall(..), MirrorResize(..))
import XMonad.Layout.LayoutHints    (layoutHintsToCenter, hintsEventHook)
import XMonad.Util.EZConfig         (mkKeymap)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main :: IO ()
main = do
  xmonad =<< statusBar "xmobar" myPP toggleStrutsKey defaults
  where
    defaults = ewmh defaultConfig
      { terminal           = "urxvtc"
      , borderWidth        = 5
      , modMask            = mod4Mask
      , workspaces         = words "a s d f z x c v"
      , normalBorderColor  = darkGray
      , focusedBorderColor = darkOrange
      , layoutHook         = layoutHintsToCenter . smartBorders $ myLayout
      , manageHook         = myManageHook
      , handleEventHook    = myEventHook
      , keys               = myKeys
      , startupHook        = myStartup
      }
    -- Layouts -----------------------------------
    myLayout = tiled ||| Mirror tiled ||| Full
    tiled   = ResizableTall nmaster delta ratio []
    nmaster = 1     -- number of windows in master pane
    ratio   = toRational (2/(1+sqrt(5)::Double))
    delta   = 3/100 -- step of increasing

    -- Manage windows
    myManageHook = composeAll
      (
      [ myIgnores --> doIgnore -- Don't manage
      , myFloats  --> doFloat  -- Make floating
      ]
      ++
      -- shifting to workspace based on window class
      [ className =? x --> doShift w | (x, w) <- clsShifts ]
      ++
      -- shifting to workspace based on window name
      [ resource =? x --> doShift w  | (x, w) <- rcsShifts ]
      )
    myFloats = foldr1 (<||>)
      [ ("Figure" `isPrefixOf`) <$> title
      , className =? "feh"
      , className =? "mplayer2"
      , className =? "Steam"
      ]
    myIgnores = foldr1 (<||>)
      [ resource  =? "panel"
      , resource  =? "trayer"
      , className =? "stalonetray"
      ]
    -- [ ( className, workspace) ]
    clsShifts = [ ("Chromium-browser", "s")
                , ("Leechcraft", "a")
                , ("Djview", "z")
                , ("Okular", "z")
                , ("Kchmviewer", "z")
                , ("Steam", "v")
                ] :: [(String,  String)]
    rcsShifts = [ ("ncmpc", "d")
                ] :: [(String, String)]

    -- eventHook
    myEventHook = docksEventHook <+> hintsEventHook <+> fullscreenEventHook

    -- xmobar staff
    myPP = xmobarPP { ppCurrent = xmobarColor orange "" . wrap "<" ">" }
    toggleStrutsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

    -- Keys
    myKeys = \conf -> mkKeymap conf $
       [ ("M-<Return>",   spawn       $ term conf)
       , ("M-C-<Esc>",    spawn       $ "xkill")
       , ("M-r",          spawn       $ "dmenu_run")
       , ("M-<Space>",    sendMessage $ NextLayout)
       , ("M-S-<Space",   setLayout   $ XMonad.layoutHook conf)
       , ("M-n",          refresh)
       , ("M-j",          windows     $ W.focusDown)
       , ("M-k",          windows     $ W.focusUp)
       , ("M-m",          windows     $ W.focusMaster)
       , ("M-S-j",        windows     $ W.swapDown)
       , ("M-S-k",        windows     $ W.swapUp)
       , ("M-S-m",        windows     $ W.swapMaster)
       , ("M-h",          sendMessage $ Shrink)
       , ("M-l",          sendMessage $ Expand)
       , ("M-t",          withFocused $ windows . W.sink)
       , ("M-,",          sendMessage $ IncMasterN 1)
       , ("M-.",          sendMessage $ IncMasterN (-1))
       , ("M-u",          sendMessage $ MirrorShrink)
       , ("M-i",          sendMessage $ MirrorExpand)
       , ("M-b",          sendMessage $ ToggleStruts)
       , ("M-S-q",        io          $ exitWith ExitSuccess)
       , ("M-q",          restart "xmonad" True)

       -- xf86-keys stuff
       , ("<XF86HomePage>",         spawn $ "chromium")
       , ("<XF86Mail>",             spawn $ "chromium")
       , ("<XF86AudioLowerVolume>", spawn $ amixer "5%-")
       , ("<XF86AudioRaiseVolume>", spawn $ amixer "5%+")
       , ("<XF86AudioPrev>",        spawn $ "mpc prev")
       , ("<XF86AudioStop>",        spawn $ "mpc stop")
       , ("<XF86AudioPlay>",        spawn $ "mpc toggle")
       , ("<XF86AudioNext",         spawn $ "mpc next")

       , (prefix "c", kill)
       , (prefix "b", spawn $ "chromium")
       , (prefix "n", spawn $ ncmpcTerm conf)
       , (prefix "e", spawn $ "gvim")
       , (prefix "a", spawn $ sTerm conf $ "alsamixer")
       , (prefix "t", spawn $ sTerm conf $ "htop")
       , (prefix "o", spawn $ "okular")
       , (prefix "d", spawn $ "djview")
       ]
       ++
       -- M-[asdfzxcv]   : switch to corresponding workspace
       -- M-S-[asdfzxcv] : move window to " " " " " " "
       [ ( m ++ i, windows $ f j)
          | (i, j) <- zip (XMonad.workspaces conf) (XMonad.workspaces conf)
          , (m, f) <- [("M-", W.view), ("M-S-", W.shift)]
       ]
    amixer      = (++) "amixer -q set Master "
    prefix      = (++) "M-<Tab> "
    term        = XMonad.terminal
    sTerm c     = (++) (term c ++ " -name urxvt-am -e ")
    ncmpcTerm c = term c ++ " -name ncmpc -e ncmpc"

    -- colors
    orange     = "#ee9a00"
    darkOrange = "#9e4a00"
    darkGray   = "#3d3d3d"

    myStartup = do
      spawn "xsetroot -cursor_name left_ptr -gray"
      spawn "[ -f ~/.wallpaper ] && feh --bg-tile ~/.wallpaper"
      spawn "[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources"
      spawn "setxkbmap -layout us,ru -option grp:caps_toggle"
      spawn "pgrep kbdd || kbdd"
      spawn "pgrep urxvtd || urxvtd --opendisplay --fork"
      runOrRaise "leechcraft" (className =? "Leechcraft")
      spawn "pgrep stalonetray || stalonetray"
