$openwrt_version = "15.05"
$openwrt_platform = "i386_i486"
$arch = "i486"
$gcc_version = "4.8"
$libc_version = "0.9.33.2"

$staging_dir = "/home/vagrant/openwrt/staging_dir"
$toolchain_dir = "${staging_dir}/toolchain-${openwrt_platform}_gcc-${gcc_version}-linaro_uClibc-${libc_version}"


package { ["git-core", "build-essential", "libssl-dev", "libncurses5-dev",
           "unzip", "subversion", "mercurial", "gawk"]:
  ensure => present
}

vcsrepo { "/home/vagrant/openwrt":
  owner => vagrant,
  group => vagrant,
  ensure => present,
  provider => git,
  source => "git://git.openwrt.org/${openwrt_version}/openwrt.git",
}

file { "/etc/profile.d/env.sh":
  content => "unset SED && export PATH=\$PATH:${staging_dir}/host/bin:${toolchain_dir}/bin STAGING_DIR=${toolchain_dir} CC=${arch}-openwrt-linux-uclibc-gcc LD=${arch}-openwrt-linux-uclibc-ld host_alias=${arch}-openwrt-linux-uclibc build_alias=${arch}-unknown-linux-gnu CFLAGS=${toolchain_dir}/include LDFLAGS=${toolchain_dir}/lib",
  mode => 755,
  require => Vcsrepo["/home/vagrant/openwrt"],
}

exec { "update_feeds":
  command => "/home/vagrant/openwrt/scripts/feeds update -a",
  require => Vcsrepo["/home/vagrant/openwrt"],
}

exec { "install_feeds":
  command => "/home/vagrant/openwrt/scripts/feeds install -a",
  require => Exec["update_feeds"],
}
