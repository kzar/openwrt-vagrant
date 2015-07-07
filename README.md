# openwrt-vagrant

## Intro

Simple Vagrantfile for creating a Debian based [OpenWrt Buildroot](http://wiki.openwrt.org/doc/howto/build) virtual machine. Intended purpose is [for cross compilation](http://wiki.openwrt.org/doc/devel/crosscompile), specifically I was trying to compile [the Cannon CAPT 2.6 printer driver](http://support-au.canon.com.au/contents/AU/EN/0100459602.html) for OpenWrt.


## Usage

First of all you will need to create a VM and build OpenWrt Build root

     # Create the VM and ssh into it
     vagrant up
     vagrant ssh

     # Configure and build OpenWrt
     cd ~/openwrt
     make menuconfig
     make

Next you can cross compile things for buildroot using the `cross-compile` script. (The script sets a bunch of environment variables before calling the command with arguments as passed to it.)

     # Cross-compile something
     cross-compile your-make-configure-command


## Compiling Cannon CAPT driver

**This doesn't actually work, I've given up for now :(**

     sudo apt-get install libcups2-dev libc6-dev-i386 libglib2.0-dev libgtk2.0-dev libglade2-dev intltool libtool-bin

     wget -O ~/capt-2.6.tar.gz http://pdisp01.c-wss.com/gdl/WWUFORedirectTarget.do?id=MDEwMDAwNDU5NjAz&cmp=ABS&lang=EN
     cd ~/ && tar xvzf capt-2.6.tar.gz
     cd ~/Linux_CAPT_PrinterDriver_V260_uk_EN/Src
     tar xvzf cndrvcups-common-2.60-1.tar.gz
     tar xvzf cndrvcups-capt-2.60-1.tar.gz

     cd cndrvcups-common-2.60-1 && cross-compile make gen
     # KABOOM! - cups/cups.h is missing, despite all packages being installed.
     #           Not sure how to fix that, I can't find it either

     cd ../cndrvcups-capt-2.60-1 && cross-compile sh allgen.sh
