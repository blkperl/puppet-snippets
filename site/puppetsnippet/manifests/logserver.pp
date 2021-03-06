class puppetsnippet::logserver {

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
    server   => 'dbserver02.lan',
    database => 'Syslog',
    username => 'rsyslog',
    password => 'secret-logger',
  }

  # Export database to one of the database server
  @@postgresql::db { 'Syslog':
    user     => 'rsyslog',
    password => 'secret-logger',
    tag      => "pgserver_dbserver2",
  }

}
