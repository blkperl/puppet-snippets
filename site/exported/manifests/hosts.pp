class exported::hosts {

  # export host file
  @@host { $::hostname:
    ensure       => 'present',
    host_aliases => [$::hostname, $::fqdn],
    ip           => $::ipaddress,
    target       => '/etc/hosts',
  }

  # collect all hosts
  Host <<| |>>
}
