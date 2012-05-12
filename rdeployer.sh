#!/bin/sh

###############################################################################
# Remote deployer script. Runs on the target device under root privileges.
# Temporarily mounts /system as read-write, copies file $1 from $3 to $2, 
# then remounts /system as read-only.
#
# Requires rooted device and BusyBox in /system/xbin to run. 
# (Use BusyBox Installer app. Search for :pname:com.jrummy.busybox.installer
# on the Market and install to get it.)
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
    echo "    [!!] FAIL"
    exit 1
  else
    echo "    [++] DONE"
    echo ""
  fi
}

AWK="/system/xbin/busybox awk"
systemdev=`mount | $AWK '{ if ($2 == "/system") { print $1 } }'`
systemfs=`mount | $AWK '{ if ($2 == "/system") { print $3 } }'`

echo "    [**] Temporarily remounting /system (device $systemdev, fs $systemfs) as read-write"
mount -o remount,rw -t $systemfs $systemdev /system
checkresult

echo "    [**] Copying file $3/$1 to $2"
cp "$3/$1" "$2/"
checkresult

echo "    [**] Setting permissions on the script"
chmod 777 "$2/$1"
checkresult

echo "    [**] Restoring /system (device $systemdev, fs $systemfs) to read-only"
mount -o remount,ro -t $systemfs $systemdev /system
checkresult

echo "    [**] Removing temp file $1 from $3"
rm "$3/$1"
checkresult
