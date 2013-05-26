node default inherits basenode {

}

node basenode {

  include puppetsnippet
}

node /dbserver[0-9]/ inherits 'basenode' {
  include puppetsnippet::dbserver
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
  include puppetsnippet::pxeserver
}

node 'dhcpserver' inherits 'basenode' {
  include puppetsnippet::dhcpserver
}
