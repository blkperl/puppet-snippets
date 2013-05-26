node default inherits basenode {

}

node basenode {

  include puppetsnippet
}

node /dbserver[0-9]/ inherits 'basenode' {
  include puppetsnippet::logserver
}

node 'logmaster' inherits 'basenode' {

  include puppetsnippet::logserver
}

node 'puppetmaster' inherits 'basenode' {

  package { 'puppetmaster': ensure => latest}
  include puppetdb
  include puppetdb::master::config
}

node 'pro-master' inherits 'basenode' {

  # FIXME: Add code for puppetmaster
  include puppetdb
  include puppetdb::master::config

}

node 'pro-nagios-server' inherits 'basenode' {

  include nagios

}

node 'tftpserver' inherits 'basenode' {
  include pxe

  $ubuntu = {
    "arch" => ['amd64'],
    "ver"  => ['precise'],
    "os"   => "ubuntu"
  }

  resource_permute('pxe::images', $ubuntu)

  pxe::menu {
    'Main Menu':
      file      => "default",
      template  => "pxe/menu_default.erb";
  }

  pxe::menu::entry {
    "Installations":
      file    => "default",
      append  => "pxelinux.cfg/menu_install",
  }

}

node 'dhcpserver' inherits 'basenode' {

  class { 'dhcp':
    dnsdomain    => [
      'lan',
      '1.0.10.in-addr.arpa',
      ],
    nameservers  => ['8.8.8.8'],
    ntpservers   => ['us.pool.ntp.org'],
    interfaces   => ['eth0'],
    #dnsupdatekey => "/etc/bind/keys.d/$ddnskeyname",
    #require      => Bind::Key[ $ddnskeyname ],
    pxeserver    => '10.0.3.2',
    pxefilename  => 'pxelinux.0',
  }

  dhcp::pool{ 'lan':
    network => '10.0.3.1',
    mask    => '255.255.255.0',
    range   => '10.0.1.100 10.0.1.200',
    gateway => '10.0.3.1',
  }

}
