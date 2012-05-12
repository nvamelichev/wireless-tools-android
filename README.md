wireless-tools-android
======================

Allows to build [wireless-tools](http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html) binaries for Android ICS devices.

Based off [wireless-tools-29](http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/wireless_tools.29.tar.gz).

Prerequisities
==============
Development machine:
* Linux machine, preferably running Ubuntu. (I tested on Ubuntu 10.04 LTS). Probably should work on other Linuxes too.
* Android NDK r6b or higher
* Corresponding Android SDK
* bash 3.0 or higher

Mobile device (I tested on HTC Sensation):
* Android 4 (ICS) or higher. Might work on lower versions if you experiment with *config.sh* and have corresponding SDK and NDK.
* Rooted!
* Superuser (*su*)
* BusyBox in */system/xbin*. Use BusyBox Installer app to install it. (Search for *:pname:com.jrummy.busybox.installer*
on the Market.)

Building
========
1. Review (and, if needed, change) build configuration in *config.sh*. You would probably need to change NDK and SDK locations, at least.
2. Review *Android.mk* file. I needed to build *iwlist* and *iwconfig* only, if you need other utilities from *wireless-tools*, add build instructions for them.
3. Run *build.sh*.
4. Result will be put into the *libs* directory. Enjoy!

Deploying to Device
===================
1. Attach device to your development machine via USB.
2. Make sure you enabled USB debug mode on the device.
3. Ensure that */etc/udev/rules.d/51-android.rules* contains lines allowing you to connect. Easy way to verify: connect the device, and run *adb devices*. If it complains about permissions, udev settings are not set correctly. Find out the correct settings string and add it to the */etc/udev/rules.d/51-android.rules* file. Then restart *udev* and reconnect the device. *adb devices* now should give something meaninful in response.
4. Review (and, if needed, change) deploy configuration in *config.sh*. DEVTEMP is any temporary directory always available for writing. DEVDEST is the destination directory, where the compiled wireless-tools executables will appear (I recommend */system/xbin*).
5. Run *deploy.sh*.
6. If everything went smoothly, there would be *iwlist* and *iwconfig* executables on the device in the desired folder (typically */system/xbin*). To verify that fact, use a terminal emulator.