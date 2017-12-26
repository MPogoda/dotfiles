import Data.List            (isPrefixOf)
import Control.Applicative  ((<$>))
-- for exiting xmonad
import System.Exit          (exitWith, ExitCode(..))

import XMonad
-- for statusbar
import XMonad.Hooks.DynamicLog      (statusBar, xmobarPP, xmobarColor, PP(..), wrap)
import XMonad.Hooks.EwmhDesktops    (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks     (docksEventHook, ToggleStruts(..))
-- honor size hints
import XMonad.Layout.LayoutHints    (layoutHintsToCenter, hintsEventHook)
-- for auto-toggling fullscreen on fullscreen windows (like flash)
import XMonad.Hooks.ManageHelpers   (isFullscreen, doFullFloat, isDialog)
-- urgency stuff
import XMonad.Hooks.UrgencyHook     (withUrgencyHook, NoUrgencyHook(..))
-- auto-borders
import XMonad.Layout.NoBorders      (smartBorders)
-- enable resizing for non-master windows
import XMonad.Layout.ResizableTile  (ResizableTall(..), MirrorResize(..))
-- hiding & showing some windows
import XMonad.Util.NamedScratchpad  (namedScratchpadAction, namedScratchpadManageHook, NamedScratchpad(..), nonFloating, customFloating)
-- easy way to specify shortcuts (including emacs-like submaps)
import XMonad.Util.EZConfig         (mkKeymap, checkKeymap)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main :: IO ()
main = do
  xmonad =<< statusBar "xmobar" myPP toggleStrutsKey defaults
  where
    defaults = ewmh $ withUrgencyHook NoUrgencyHook $ def
              { terminal           = myTerminal
              , borderWidth        = 5
              , modMask            = mod4Mask
              , workspaces         = myWorkspaces
              , normalBorderColor  = "#1b1d1e"
              , focusedBorderColor = "#a0a0a0"
              , layoutHook         = layoutHintsToCenter . smartBorders $ myLayout
              , manageHook         = myManageHook <+> namedScratchpadManageHook scratchpads
              , handleEventHook    = myEventHook
              , keys               = \c -> mkKeymap c myKeys
              , startupHook        = return () >> checkKeymap defaults myKeys
              }

-- xmobar pretty printing stuff
myPP :: PP
myPP = xmobarPP { ppCurrent = xmobarColor orange ""
                -- separator between elements
                , ppSep     = xmobarColor orange "" " \xe0b1 "
                -- order in which we have to show elements (title is ignored)
                , ppOrder   = \(ws:l:_) -> [l, ws]
                -- show only workspaces that are predefined by me
                , ppHidden  = \w -> if elem w myWorkspaces then w else ""
                -- short 'titles' for layouts
                , ppLayout  = \n -> case n of
                                "Full" -> "[ ]"
                                "ResizableTall" -> "[|]"
                                "Mirror ResizableTall" -> "[-]"
                                _      -> n
                }
-- dummy line. needed for statusBar function.
toggleStrutsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

-- terminal i'm using
myTerminal = "st" :: String

-- list of workspaces
myWorkspaces = words "a r s t d z x c v" :: [String]

-- list of screens
myScreens = words "1 2" :: [String]

-- Layouts
myLayout = Full ||| tiled ||| Mirror tiled
  where
    tiled   = ResizableTall nmaster delta ratio []
    nmaster = 1     -- number of windows in master pane
    ratio   = toRational (2/(1+sqrt(5)::Double)) -- phi
    delta   = 3/100 -- step of increasing

-- How we should manage windows
myManageHook :: ManageHook
myManageHook = composeAll
            (
            [ myIgnores    --> doIgnore     -- Don't manage
            , myFloats     --> doFloat      -- Make floating
            , isFullscreen --> doFullFloat  -- Auto-fullscreen
            ]
            ++
            [ x --> doShift w | (x, w) <- myShifts ] -- Perform shifts
            )
  where
    -- list of conditions when we have make window floating
    myFloats = foldr1 (<||>)
      [ ("Figure" `isPrefixOf`) <$> title
      , className =? "feh"
      , className =? "mplayer2"
      , className =? "Steam"
      , isDialog
      ]
    -- list of conditions when we have to ignore window (don't manage it)
    myIgnores = foldr1 (<||>)
      [ resource  =? "panel"
      , className =? "stalonetray"
      ]
    -- when condition from first part of tuple succeed, move that window to #2
    myShifts = map (\(x, y) -> (className =? x, y)) clsShifts
    -- [ ( className, workspace) ]
    clsShifts = [ ("Firefox", "r")

                , ("Leechcraft", "a")
                , ("Skype", "a")
                , ("TelegramDesktop", "a")
                , ("Google-chrome", "a")
                ] :: [(String,  String)]

-- eventHook
myEventHook = docksEventHook <+> hintsEventHook <+> fullscreenEventHook

-- Keys
myKeys = [ ("M-<Return>",   spawn       $ myTerminal ++ " -e tmux")
         , ("M-S-<Return>", spawn       $ myTerminal )
         , ("M-C-<Esc>",    spawn       $ "xkill")
         , ("M-p",          spawn       $ "dmenu_run -fn Monospace-32")
         -- cycle through all possible layouts
         , ("M-<Space>",    sendMessage $ NextLayout)
         -- restore default layout
         , ("M-n",          refresh)
         -- cycle through all windows
         , ("M-j",          windows     $ W.focusDown)
         , ("M-k",          windows     $ W.focusUp)
         -- jump to master pane
         , ("M-m",          windows     $ W.focusMaster)
         -- moving stuff
         , ("M-S-j",        windows     $ W.swapDown)
         , ("M-S-k",        windows     $ W.swapUp)
         , ("M-S-m",        windows     $ W.swapMaster)
         -- enlarging|shrinking stuff
         , ("M-h",          sendMessage $ Shrink)
         , ("M-l",          sendMessage $ Expand)
         , ("M-u",          sendMessage $ MirrorShrink)
         , ("M-i",          sendMessage $ MirrorExpand)
         -- make floating windows non-floating
         , ("M-g",          withFocused $ windows . W.sink)
         -- increase/decrease number of windows in master pane
         , ("M-,",          sendMessage $ IncMasterN 1)
         , ("M-.",          sendMessage $ IncMasterN (-1))
         -- statusbar stuff
         , ("M-b",          sendMessage $ ToggleStruts)

         , ("M-S-q",        io          $ exitWith ExitSuccess)
         , ("M-q",          restart "xmonad" True)

         -- close current window
         , (prefix "c", kill)
         -- shortcuts
         , (prefix "b", spawn $ "firefox")
         , (prefix "o", namedScratchpadAction scratchpads "org")
         , (prefix "r", namedScratchpadAction scratchpads "term")
         , (prefix "d", namedScratchpadAction scratchpads "dashboard")
         ]
         ++
         -- M-[asdfgzxcv]   : switch to corresponding workspace
         -- M-S-[asdfgzxcv] : move window to " " " " " " "
         [ ( m ++ i, windows $ f i)
            | i <- myWorkspaces
            , (m, f) <- [("M-", W.greedyView), ("M-S-", W.shift)]
         ]
         ++
         -- M-[1234] : switch to screen 1, 2, 3…
         -- M-S-[1234] : move client to screen 123…
         [ ( m ++ i, screenWorkspace sc >>= flip whenJust (windows . f))
           | (i, sc) <- zip myScreens [0..]
           , (m, f) <- [("M-", W.view), ("M-S-", W.shift)]
         ]
  where
    -- prefix that is used in my emacs-like keybidings
    prefix  = (++) "M-<Tab> " :: String -> String

scratchpads :: [NamedScratchpad]
scratchpads = [ NS "dashboard" (myTerminal ++ " -c dashboard -e ~/.tmux/dashboard.sh")
                  (className =? "dashboard") nonFloating
              , NS "term" (myTerminal ++ " -c term -e tmux") (className =? "term")
                  (customFloating $ W.RationalRect 0 (2/3) 1 (1/3))
              , NS "org" (myTerminal ++ " -c org -e nvim ~/plan.org") (className =? "org")
                  (customFloating $ W.RationalRect (1/8) (1/8) (3/4) (3/4))
              ]

-- colors
orange     = "#fd971f" :: String
