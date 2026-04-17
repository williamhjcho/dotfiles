#!/usr/bin/env bash

# Mac OS X configuration
#
# This configuration applies to the latest version of macOS (currently 11.3),
# and sets up preferences and configurations for all the built-in services and
# apps. Third-party app config should be done elsewhere.
#
# Options:
#   --no-restart: Don't restart any apps or services after running the script.
#
# If you want to figure out what default needs changing, do the following:
#
#   1. `cd /tmp`
#   2. Store current defaults in file: `defaults read > before`
#   3. Make a change to your system.
#   4. Store new defaults in file: `defaults read > after`
#   5. Diff the files: `diff before after`
#
# @see: http://secrets.blacktree.com/?showapp=com.apple.finder
# @see: https://github.com/herrbischoff/awesome-macos-command-line
#
# adapted from Jeff Geerling's dotfiles

if [[ $EUID -eq 0 ]]; then
  TARGET_USER="${SUDO_USER:-$(stat -f%Su /dev/console)}"
else
  TARGET_USER="${USER}"
fi

TARGET_HOME="$(dscl . -read "/Users/${TARGET_USER}" NFSHomeDirectory | awk '{print $2}')"

run_as_target_user() {
  if [[ $EUID -eq 0 && "${TARGET_USER}" != "root" ]]; then
    sudo -H -u "${TARGET_USER}" "$@"
  else
    "$@"
  fi
}

user_defaults() {
  run_as_target_user defaults "$@"
}

user_chflags() {
  run_as_target_user chflags "$@"
}

###############################################################################
# General UI/UX                                                               #
###############################################################################
echo "Setting General UI/UX"

user_defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
user_defaults delete NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically

# status bar visibility: true = always
user_defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -int 1
user_defaults write NSGlobalDomain _HIHideMenuBar -int 0

# disable siri
user_defaults write com.apple.assistant.support "Assistant Enabled" -int 0

# Save to disk (not to iCloud) by default
# defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
# defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Restart automatically if the computer freezes
# if [[ $EUID -eq 0 ]]; then
# 	systemsetup -setrestartfreeze on
# fi

# Disable smart quotes as they’re annoying when typing code
user_defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
user_defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

user_defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
user_defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
user_defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################
echo "Setting Trackpad & acessories"

# Set a blazingly fast keyboard repeat rate, and make it happen more quickly.
# (The KeyRepeat option requires logging out and back in to take effect.)
user_defaults write NSGlobalDomain InitialKeyRepeat -int 15
user_defaults write NSGlobalDomain KeyRepeat -int 1

# Disable auto-correct
user_defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Trackpad two finger tap right click
user_defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
user_defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Trackpad tap to click
user_defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
user_defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Trackpad haptic feedback
user_defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
user_defaults write NSGlobalDomain ContextMenuGesture -int 1

# Disable press-and-hold for keys in favor of key repeat
user_defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Adds three-finger drag gesture
user_defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
user_defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool false
user_defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -bool false
user_defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false
user_defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -bool false
user_defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -bool false

###############################################################################
# Screen                                                                      #
###############################################################################
echo "Setting Screen"

# Save screenshots to Downloads folder.
user_defaults write com.apple.screencapture location -string "${TARGET_HOME}/Downloads"

# shows mouse in captures
user_defaults write com.apple.screencapture showsClicks -bool true

# Disable shadow in screenshots
user_defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
###############################################################################
echo "Setting Finder"

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
# defaults write com.appfe.finder NewWindowTarget -string "PfDe"
# defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for hard drives, servers, and removable media on the desktop
# defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
# defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
# defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
user_defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
user_defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
# defaults write com.apple.finder ShowStatusBar -bool true

# Finder: allow text selection in Quick Look
# defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
user_defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
user_defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
# defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
# defaults write NSGlobalDomain com.apple.springing.delay -float 0.1

# Avoid creating .DS_Store files on network volumes
user_defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set the size of icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
user_defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show the ~/Library folder
user_chflags nohidden "${TARGET_HOME}/Library"

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################
echo "Setting Dock, Dashboard, and hot corners"

# dock settings
user_defaults write com.apple.dock tilesize -int 30
user_defaults write com.apple.dock largesize -int 33
user_defaults write com.apple.dock magnification -int 1
user_defaults write com.apple.dock mineffect -string "scale"
user_defaults write com.apple.dock orientation -string "bottom"

# this is a fix for aerospace app
user_defaults write com.apple.dock expose-group-apps -bool true

# disable most recent space rearranging automatically
user_defaults write com.apple.dock "mru-spaces" -bool false

# disable launchpad gesture
user_defaults write com.apple.dock showLaunchpadGestureEnabled -bool false

# Make Dock icons of hidden applications translucent
user_defaults write com.apple.dock showhidden -bool true

# Make Dock autohide
user_defaults write com.apple.dock autohide -bool true
user_defaults write com.apple.dock show-recents -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock screen
# Bottom left screen corner
user_defaults write com.apple.dock wvous-bl-corner -int 13
user_defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# # Enable the Develop menu and the Web Inspector in Safari
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
#
# # Add a context menu item for showing the Web Inspector in web views
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
# defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############################################################################
# Spotlight                                                                   #
###############################################################################
echo "Setting Spotlight"

if [[ $EUID -eq 0 ]]; then
  # Disable Spotlight indexing for any volume that gets mounted and has not yet
  # been indexed before.
  # Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
  defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

  # Restart spotlight
  killall mds >/dev/null 2>&1
fi

###############################################################################
# Activity Monitor                                                            #
###############################################################################
echo "Setting Activity Monitor"

# Show the main window when launching Activity Monitor
user_defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor
user_defaults write com.apple.ActivityMonitor ShowCategory -int 0

###############################################################################
# Messages                                                                    #
###############################################################################

# Disable smart quotes as it’s annoying for messages that contain code
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# App Store                                                                   #
###############################################################################
echo "Setting App Store"

# Disable in-app rating requests from apps downloaded from the App Store.
user_defaults write com.apple.appstore InAppReviewEnabled -int 0

###############################################################################
# Kill/restart affected applications                                          #
###############################################################################
echo "Last step"

# Restart affected applications if `--no-restart` flag is not present.
if [[ ! ($* == *--no-restart*) ]]; then
  for app in "cfprefsd" "Dock" "Finder" "Mail" "SystemUIServer" "Terminal"; do
    killall "${app}" >/dev/null 2>&1
  done
fi

printf "Please log out and log back in to make all settings take effect.\n"
