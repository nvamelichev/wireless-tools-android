#!/bin/bash

###############################################################################
# Sets configurable parameters for the build.
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

# Path to Android NDK
NDK="/opt/necessitas/android-ndk-r6b"
# Path to Android SDK
SDK="/opt/necessitas/android-sdk"
# Target Android Platform
TARGET="android-9"
# Target Architecture
ARCH="arch-arm"
# Application Binary Interface
ABI="armeabi"

# Location for temporary files on the device
DEVTEMP="/sdcard/tmp"
# Destination (under /system) for the produced executables on the device
DEVDEST="/system/xbin"
