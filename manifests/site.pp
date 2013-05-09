node basenode {

  include puppetsnippet
}

node /pro-client[1-9]/ inherits 'basenode' {

}

node 'pro-master' inherits 'basenode' {

  # FIXME: Add code for puppetmaster
  include puppetdb
  include puppetdb::master::config

}

node 'pro-nagios-server' inherits 'basenode' {

  include nagios

}

node /web[1-9]/ inherits 'basenode' {

}
