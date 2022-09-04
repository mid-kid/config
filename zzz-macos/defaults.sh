#!/bin/sh

# Disable indexing
sudo mdutil -a -i off

# Fix scrolling direction
defaults write "Apple Global Domain" com.apple.swipescrolldirection -int 0

# Set key repeat to fast
defaults write "Apple Global Domain" InitialKeyRepeat -int 15
defaults write "Apple Global Domain" KeyRepeat -int 2

# Autohide dock
defaults write com.apple.dock autohide -int 1

# Make VMs faster by reducing animations
defaults write com.apple.universalaccess reduceMotion -int 1
defaults write com.apple.universalaccess reduceTransparency -int 1
defaults write com.apple.dock launchanim -int 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Manual settings:
# System Preferences -> Energy Saver -> Turn display off after = Never
# System Preferences -> Desktop & Screen Saver -> Screen Saver -> Start After = Never
