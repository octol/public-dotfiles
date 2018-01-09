import XMonad
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Magnifier
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.TwoPane
import XMonad.Layout.Combo
{-import XMonad.Layout.LayoutHints-}
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
{-import XMonad.Hooks.SetWMName-}
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Data.Ratio ((%))
import System.IO

myManageHook = composeAll
    [ className =? "famFrame" --> doFloat
    , className =? "com-mathworks-util-PostVMInit" --> doFloat
    , className =? "frame" --> doFloat
    , className =? "Figure 1" --> doFloat
    , className =? "gplt" --> doFloat
    , className =? "gnuplot" --> doFloat
    , className =? "Gnuplot" --> doFloat
    , className =? "Pinentry" --> doFloat
    , className =? "Gcr-prompter" --> doCenterFloat
    , className =? "Pidgin" --> doFloat
    , className =? "Pidgin" --> doShift "im"
    , className =? "Firefox" --> doShift "web"
    , className =? "Iceweasel" --> doShift "web"
    , className =? "Dogecoin-qt" --> doFloat
    , className =? "Display.im6" --> doCenterFloat
    , className =? "Virt-manager" --> doFloat
    , className =? "Virt-viewer" --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "VirtualBox" --> doFloat
    , className =? "Octave" --> doFloat
    , className =? "Vpnui" --> doFloat
    , className =? "Xfce4-notifyd" --> doIgnore
    ]

main = do
    xmonad =<< statusBar "xmobar" xmobarPP toggleStrutsKey myConfig

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig
        { manageHook = manageDocks <+> myManageHook
                                   <+> manageHook defaultConfig
        {-, layoutHook = avoidStruts $ layoutHook defaultConfig-}
        , layoutHook = myLayout
        , borderWidth           = 1
        , terminal              = "urxvt"
        , focusedBorderColor    = "#ff7700"
        , normalBorderColor     = "#464646"
        , workspaces            = myWorkSpaces
        , modMask               = myMod
        {-, startupHook           = setWMName "LG3D"-}
        }
        `additionalKeys`
        [
        ((mod4Mask, xK_F12), spawn "xscreensaver-command -l")
        ]

-- windows key
myMod = mod4Mask

-- configure the layout
myLayout =
        onWorkspace "im" ((avoidStruts $ myChat) ||| (smartBorders $ myTall)) $
        {-onWorkspace "web" (smartBorders $ (myTall ||| myMirrorTall ||| myTab ||| Full)) $-}
            (smartBorders (myTall ||| myMirrorTall ||| myTab ||| Full))
                where
                    myTab = avoidStruts $ tabbed shrinkText myTabConfig
                    myTallZoom = magnifiercz' 1.4 $ avoidStruts $ Tall nmaster delta ratio
                        where
                            -- The default number of windows in the master pane
                            nmaster = 1
                            -- Default proportion of screen occupied by master pane
                            ratio   = 63/100
                            -- Percent of screen to increment by when resizing panes
                            delta   = 3/100
                    myTall = avoidStruts $ Tall nmaster delta ratio
                        where
                            -- The default number of windows in the master pane
                            nmaster = 1
                            -- Default proportion of screen occupied by master pane
                            ratio   = 50/100
                            -- Percent of screen to increment by when resizing panes
                            delta   = 3/100
                    myMirrorTall = avoidStruts $ Mirror $ Tall nmaster delta ratio
                        where
                            -- The default number of windows in the master pane
                            nmaster = 1
                            -- Default proportion of screen occupied by master pane
                            ratio   = 50/100
                            -- Percent of screen to increment by when resizing panes
                            delta   = 3/100
                    myChat = withIM size roster $ Grid
                        where
                            -- Ratio of screen roster will occupy
                            size = 1%5
                            -- Match roster window
                            roster = Title "Buddy List"
                    --myChatFloat = simpleFloat
                    {-myCombo = avoidStruts $ combineTwo laymaster lay1 lay2  -}
                    {-    where                                               -}
                    {-        laymaster = TwoPane 0.03 0.5                    -}
                    {-        lay1 = tabbed shrinkText myTabConfig            -}
                    {-        lay2 = tabbed shrinkText myTabConfig            -}
                    myGrid = avoidStruts $ Grid

-- colors for the tabs
myTabConfig = defaultTheme { inactiveBorderColor        = "#464646"
                           , activeBorderColor          = "#ff7700"
                           , activeColor                = "#666666"
                           , inactiveColor              = "#1c1c1c"
                           , fontName                   = "xft:Terminus:size=8"
                           }

-- workspaces
{-myWorkSpaces = ["1","2","3","4","5","6","im","mail","web"]-}
{-myWorkSpaces = ["1","2","3","4","5","6","7","im","web"]-}
myWorkSpaces = ["1","2","3","4","5","6","7","mail","web"]

