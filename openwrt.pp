$openwrt_version = "15.05"

package { ["git-core", "build-essential", "libssl-dev", "libncurses5-dev",
           "unzip", "subversion", "mercurial", "gawk", "xsltproc", "gettext",
           "bin86"]:
  ensure => present
}

vcsrepo { "/home/vagrant/openwrt":
  owner => vagrant,
  group => vagrant,
  ensure => present,
  provider => git,
  source => "git://git.openwrt.org/${openwrt_version}/openwrt.git",
}

file { "/usr/local/bin/cross-compile":
  source => "/vagrant/cross-compile",
  mode => 755,
}

file { "/home/vagrant/openwrt/feeds.conf":
  source => "/vagrant/feeds.conf",
  subscribe => Vcsrepo["/home/vagrant/openwrt"],
}

exec { "update_feeds":
  command => "/home/vagrant/openwrt/scripts/feeds update -a",
  subscribe => File["/home/vagrant/openwrt/feeds.conf"],
}

exec { "install_feeds":
  command => "/home/vagrant/openwrt/scripts/feeds install -a",
  subscribe => Exec["update_feeds"],
}
