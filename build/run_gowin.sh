#!/bin/bash

# --- GoWin IDE Linux Fix Script ---
# This script applies the necessary patches to run the GoWin IDE
# inside a modern Docker container.

# PROBLEM 1: GoWin bundles an old 'libfreetype' that is incompatible
# with the system's 'fontconfig'.
# FIX: Preload the system's 'libfreetype.so.6' to override the bundled one.

# PROBLEM 2 (You found this): The 'programmer' executable bundles an old
# 'libz.so.1' that is incompatible with the system's 'libpng16'.
# FIX: Preload the system's 'libz.so.1' to override the bundled one.

# Set the preload list. This forces all child processes (the IDE and
# the programmer) to use the system libraries we specify.
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libfreetype.so.6:/lib/x86_64-linux-gnu/libz.so.1

# Set the correct Qt plugin path for the container's environment
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins

# Set the Qt platform to xcb (X11)
export QT_QPA_PLATFORM=xcb

# Disable Qt's XCB-GL integration, which can cause issues
export QT_XCB_GL_INTEGRATION=none

# Launch the IDE. All environment variables set above will be
# inherited by this process and any child process it starts.
echo "Starting GoWin IDE with runtime patches..."
exec /opt/gowin/IDE/bin/gw_ide
