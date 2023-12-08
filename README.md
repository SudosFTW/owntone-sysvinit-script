# owntone-sysvinit-script
This is a script to be placed into `/etc/init.d/` so users running Sysvinit as their init system can still start and stop OwnTone if they are building from source.
This script *might* also work with OpenRC. I have not tested this. Support for OpenRC is *not* guaranteed, **you have been warned.**

# Why?
I needed something to allow OwnTone to start at boot on my Dell KACE M300, a *Marvell Kirkwood*-based asset management appliance from 2011.
Originally shipping with Debian Squeeze, this device, with an updated u-boot firmware flash, runs Debian 12 Bookworm (*at time of writing*) with a modern 6.x kernel (*again, at time of writing*) with a rootfs made speficically for devices in the Kirkwood flattened-device-tree from a user on the Doozan forums named 'bodhi'. As of December 2023, The only two GNU/Linux operating systems still supporting *armel* as an official port are Gentoo and Debian. These Kirkwood devices are everywhere, with the M300 being the cheapest and absolute fastest (*at **2GHz!***) you can still get new-in-box old-stock (*once again, at time of writing.*) Other options in the lineup are the *PogoPlug* line of devices from Cloud Engines, Inc.
The M300 runs OwnTone surprisingly well, and even has enough horsepower for a single-core softFPU ARM chip to transcode FLAC/OGG/etc. files on-the-fly to a format iTunes can understand if I'm using it as a remote library for such. Sure, it uses up all the CPU power it has, but it works! 

As OwnTone is not in the Debian package repos, there is no existing sysvinit script for the project to my knowledge that would have been packaged with it.
The deb-multimedia OwnTone debian package has systemd scripts for such a reason but no sysvinit scripts. No one is actively offering a sysvinit script as nearly everyone has moved to systemd for their init system. While there is no real problem with this, the debian rootfs offered by *bodhi* uses sysvinit as its init system to be easy on the RAM requirements for some of the memory-starved Kirkwood devices (*i.e. PogoPlug V4 with 128MB of RAM*) and facilitate faster, less-resource-intensive booting.

You can use systemd as the init system on these devices and it works quite well so long as you have the RAM for it, but it's not recommended. OpenRC also functions as expected as an init system, but I have once again, not tested this script out with it.



# Installation:
- download `owntone-sysvinit-script.sh` to a directory of your choice.
- copy/move it into `/etc/init.d/` as filename `owntone` without any extension.
- `chomod -x /etc/init.d/owntone` to make it executable.
- run `sudo update-rc.d owntone defaults` to make sysvinit aware it needs to enable it on boot.

And you're done! OwnTone should now autostart at boot of the system it is installed on with sysvinit as the init system.
You may need to edit the script to match where you have `make install`'d OwnTone to, if necessary. This script should otherwise work with a textbook OwnTone source installation.
