class puppetsnippet::logserver {

  include postgresql::server

  class { 'rsyslog::server':
      enable_tcp                => true,
      enable_udp                => true,
      enable_onefile            => false,
      server_dir                => '/srv/log/',
      custom_config             => undef,
      high_precision_timestamps => false,
  }

  class { 'rsyslog::database':
    backend  => 'pgsql',
    server   => 'logmaster.lan',
    database => 'Syslog',
    username => 'rsyslog',
    password => 'secret-logger',
  }

  postgresql::db { 'Syslog':
    user     => 'rsyslog',
    password => 'secret-logger'
  }

  Postgresql::Db['Syslog'] -> Class['rsyslog::database']

}
