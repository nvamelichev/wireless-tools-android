#!/bin/bash

###############################################################################
# Starts NDK build in the current directory.
# Compiled executables will be placed under the `libs' directory.
#
# To properly copy built executables to the device call deploy.sh.
# 
# You need installed Android NDK r6b or higher to compile. 
# A suitable NDK can be always obtained from Google:
#    http://developer.android.com/sdk/ndk/index.html
#
# If you develop C++ applications using Qt and wish to deploy to Android, you
# might be interested in the Necessitas project:
#    http://necessitas.sf.net
# which, as of this writing, comes bundled with NDK r6b.
#
#
# Copyright 2012 Nickolay Amelichev
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
###############################################################################

# Read configuration
source ./config.sh

# Build dir
BUILDDIR="$PWD"

# Copy missing ethernet.h header to NDK
cp /usr/include/net/ethernet.h $NDK/platforms/$TARGET/$ARCH/usr/include/net/

# Start build
$NDK/ndk-build NDK_PROJECT_PATH=$BUILDDIR/ \
    APP_BUILD_SCRIPT=/$BUILDDIR/Android.mk \
    SYSROOT=$NDK/platforms/$TARGET/$ARCH/
