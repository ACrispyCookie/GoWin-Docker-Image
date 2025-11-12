#!/bin/bash
#
# This script applies the necessary environment variable fixes
# to run the GoWin IDE on modern Linux systems.
#

# 1. Fix libfreetype conflict
# Force the IDE to use the system's libfreetype instead of its own bundled one.
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libfreetype.so.6

# 2. Fix Qt Platform/Plugin issues
# Explicitly set the Qt platform plugin path and integration.
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins
export QT_QPA_PLATFORM=xcb
export QT_XCB_GL_INTEGRATION=none

# 3. Launch the IDE
# Note: Adjust the path if your GoWin version installed differently
exec /opt/gowin/IDE/bin/gw_ide
