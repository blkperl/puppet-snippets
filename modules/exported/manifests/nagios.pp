class exported::nagios {

  # export nagos host file
  @@file { "${::fqdn}_nagios_host_file":
    ensure  => present,
    owner   => nagios,
    group   => nagios,
    path    => "/etc/nagios3/conf.d/$::fqdn.cfg",
    tag     => "env_nagios_$::environment",
  }

  # export nagios host resource
  @@nagios_host { "${::fqdn}_nagios_host":
    ensure    => present,
    alias     => $::hostname,
    host_name => $::hostname,
    address   => $::ipaddress,
    use       => 'generic-host',
    require   => File["/etc/nagios3/conf.d/$::fqdn.cfg"],
    tag       => "env_$::environment",
    target    => "/etc/nagios3/conf.d/$::fqdn.cfg",
  }

}
