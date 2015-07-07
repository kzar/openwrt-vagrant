# openwrt-vagrant

## Intro

Simple Vagrantfile for creating a Debian based [OpenWrt Buildroot](http://wiki.openwrt.org/doc/howto/build) virtual machine. Intended purpose is [for cross compilation](http://wiki.openwrt.org/doc/devel/crosscompile), specifically I was trying to compile [the Cannon CAPT 2.6 printer driver](http://support-au.canon.com.au/contents/AU/EN/0100459602.html) for OpenWrt.


## Usage

     # Create the VM and ssh into it
     vagrant up
     vagrant ssh

     # Clear cross compilation environment variables
     unset CC LD STAGING_DIR host_alias build_alias CFLAGS LDFLAGS

     # Configure and build OpenWrt
     cd ~/openwrt
     make menuconfig
     make

     # Restore environment variables
     /etc/profile.d/env.sh

_(You're going to have to change some of the variables at the top of `modules/openwrt.pp` if you're not targeting i486.)_


## Compiling Cannon CAPT driver

_Work in progress..._

     sudo apt-get install libcups2-dev libc6-dev-i386 libglib2.0-dev libgtk2.0-dev libglade2-dev intltool libtool-bin

     wget -O ~/capt-2.6.tar.gz http://pdisp01.c-wss.com/gdl/WWUFORedirectTarget.do?id=MDEwMDAwNDU5NjAz&cmp=ABS&lang=EN
     cd ~/ && tar xvzf capt-2.6.tar.gz
     cd ~/Linux_CAPT_PrinterDriver_V260_uk_EN/Src
     tar xvzf cndrvcups-common-2.60-1.tar.gz
     tar xvzf cndrvcups-capt-2.60-1.tar.gz

     cd cndrvcups-common-2.60-1 && make gen      # KABOOM! :(
     cd ../cndrvcups-capt-2.60-1 && ./allgen.sh
