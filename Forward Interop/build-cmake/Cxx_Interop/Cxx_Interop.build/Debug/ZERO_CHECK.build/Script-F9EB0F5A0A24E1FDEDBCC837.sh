#!/bin/sh
set -e
if test "$CONFIGURATION" = "Debug"; then :
  cd /Users/calebmeurer/Desktop/projects/ios-macos/paper/CxxInteropDemo-iOSApp/Cxx_Interop
  make -f /Users/calebmeurer/Desktop/projects/ios-macos/paper/CxxInteropDemo-iOSApp/Cxx_Interop/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "Release"; then :
  cd /Users/calebmeurer/Desktop/projects/ios-macos/paper/CxxInteropDemo-iOSApp/Cxx_Interop
  make -f /Users/calebmeurer/Desktop/projects/ios-macos/paper/CxxInteropDemo-iOSApp/Cxx_Interop/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "MinSizeRel"; then :
  cd /Users/calebmeurer/Desktop/projects/ios-macos/paper/CxxInteropDemo-iOSApp/Cxx_Interop
  make -f /Users/calebmeurer/Desktop/projects/ios-macos/paper/CxxInteropDemo-iOSApp/Cxx_Interop/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "RelWithDebInfo"; then :
  cd /Users/calebmeurer/Desktop/projects/ios-macos/paper/CxxInteropDemo-iOSApp/Cxx_Interop
  make -f /Users/calebmeurer/Desktop/projects/ios-macos/paper/CxxInteropDemo-iOSApp/Cxx_Interop/CMakeScripts/ReRunCMake.make
fi

