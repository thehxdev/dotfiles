{--

Simple Xmonad WM configuration.
My github: https://github.com/hxdevlover

--}

---------------------------------------------
-- Imports
---------------------------------------------
import XMonad
import Data.Monoid
import System.Exit
import Graphics.X11.ExtraTypes.XF86

-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.SimpleFloat
import XMonad.Util.SpawnOnce

-- Hooks
import XMonad.ManageHook
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog

-- Whatever
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.StackSet as W
import qualified Data.Map        as M


---------------------------------------------
-- Variables
---------------------------------------------
myTerminal      = "kitty"
myEmacs         = "emacsclient -c -a 'emacs' "
myBrowser       = "brave"
myFileManager   = "pcmanfm"
--myEditor        = myTerminal ++  " -e nvim"
rofiDrun        = "rofi -show drun"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 2

-- left alt      is mod1Mask
-- right alt     is mod3Mask
-- windows/super is mod4Mask
--
myModMask       = mod4Mask
altMask         = mod1Mask

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
myNormalBorderColor  = "#454545"
myFocusedBorderColor = "#ebdbb2"


---------------------------------------------
-- Key bindings
---------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,              xK_a      ), spawn $ XMonad.terminal conf)
    
    -- volume keys
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")

    -- launch rofi drun
    , ((modm,               xK_s     ), spawn $ rofiDrun)

    -- launch pcmanfm
    , ((modm,               xK_d     ), spawn $ myFileManager)

    -- launch brave
    , ((modm .|. shiftMask, xK_f     ), spawn $ myBrowser)

    -- launch emacs
    , ((modm,               xK_e     ), spawn $ myEmacs)

    -- launch flameshot gui
    , ((0,                  xK_Print ), spawn "flameshot gui")

    -- close focused window
    , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

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

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. controlMask,  xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask,    xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    
    --[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


---------------------------------------------
-- Mouse bindings
---------------------------------------------
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


---------------------------------------------
-- Layouts
---------------------------------------------
myLayout = avoidStruts(tiled ||| Full ||| simpleFloat)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


---------------------------------------------
-- Window rules
---------------------------------------------

-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.

myManageHook = composeAll
    [ className =? "MPlayer"          --> doFloat
    , className =? "confirm"          --> doFloat
    , className =? "Gimp"             --> doFloat
    , className =? "file_progress"    --> doFloat
    , className =? "dialog"           --> doFloat
    , className =? "download"         --> doFloat
    , className =? "error"            --> doFloat
    , className =? "notification"     --> doFloat
    , className =? "pinentry-gtk-2"   --> doFloat
    , className =? "splash"           --> doFloat
    , className =? "toolbar"          --> doFloat
    , className =? "Yad"              --> doCenterFloat
    , className =? "mpv"              --> doCenterFloat
    , className =? "rofi"             --> doIgnore >> doCenterFloat
    , className =? "TelegramDesktop"  --> doIgnore >> doCenterFloat
    , resource  =? "desktop_window"   --> doIgnore
    , resource  =? "kdesktop"         --> doIgnore ]


---------------------------------------------
-- Event handling
---------------------------------------------

-- EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty


---------------------------------------------
-- Status bars and logging
---------------------------------------------

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()


---------------------------------------------
-- Startup hook
---------------------------------------------

myStartupHook :: X ()
myStartupHook = do

  spawn "killall trayer"
  spawn ("sleep 0.5 && trayer --tint 0x3b3b3b --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --height 20")
  -- spawnOnce "nitrogen --restore &"
  -- spawnOnce "feh --bg-fill path/to/wallpaper.png"
  -- spawnOnce "nm-applet"
  -- spawnOnce "volumeicon"
  -- spawnOnce "picom"
  -- spawnOnce "lxsession"

  setWMName "LG3D"


---------------------------------------------
-- Command to launch the bar.
---------------------------------------------

-- Xmobar and the configuratino path
myBar = "xmobar $HOME/.config/xmobar/xmobarrc"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#ffffff" "" . wrap "|" "|" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


---------------------------------------------
-- Main
---------------------------------------------

main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

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
        layoutHook         = spacingWithEdge 4 $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
