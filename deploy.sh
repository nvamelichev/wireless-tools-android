#!/bin/bash

###############################################################################
# Deploys compiled executables from the `libs' directory straight to
# the connected Android device.
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

checkresult() {
  if [ "$?" -ne 0 ]; then
    echo "[!!] FAIL"
    exit 1
  else
    echo "[++] DONE"
    echo ""
  fi
}

checkresult2() {
  if [ "$?" -ne 0 ]; then
    echo "  [!!] FAIL"
    exit 1
  else
    echo "  [++] DONE"
    echo ""
  fi
}

# Read configuration
source ./config.sh

# Build results directory
RESULTS="$PWD/libs/$ABI"
# Path to adb
ADB="$SDK/platform-tools/adb"

# Copy "rdeployer.sh" remote deploy script and set its permissions
echo "[**] Copying deploy script to remote device"
DEPLOYER="rdeployer.sh"
$ADB push $DEPLOYER "$DEVTEMP/$DEPLOYER" 2> /dev/null
checkresult

echo "[**] Setting execute permission on the deployer script"
$ADB shell "su -c \"chmod 777 $DEVTEMP/$DEPLOYER\""
checkresult

# Deploy: copy to remote, run deployer script from the temp directory
# on the remote
for file in $RESULTS/*; do
        filename=`echo $file | awk -F/ '{print $(NF)}'`
        echo "[**] Deploying $filename: "
                
        echo "  [**] Copying $filename to remote device"
        $ADB push "$file" "$DEVTEMP/$filename" 2> /dev/null
        checkresult2
        
        echo "  [**] Copying $filename to $DEVDEST on the device:"
        adbcmd="sh $DEVTEMP/$DEPLOYER \"$filename\" \"$DEVDEST\" \"$DEVTEMP\""
        $ADB shell "su -c \"$adbcmd\""
        checkresult2
done

# Cleanup
echo "[**] Removing deploy script from the remote device"
$ADB shell "rm $DEVTEMP/$DEPLOYER"
checkresult
