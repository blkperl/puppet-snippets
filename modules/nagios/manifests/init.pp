class nagios {

  # Fixme add exec to add nagiosadmin user
  package { 'nagios3':
    ensure => present
  }

  service { 'nagios3':
    ensure  => running,
    enable  => true,
    require => Package['nagios3'],
  }

  Nagios_host <<| tag == "env_$environment" |>> {
    notify  => Service['nagios3'],
  }

  File <<| tag == "env_nagios_$environment" |>> { }

}
