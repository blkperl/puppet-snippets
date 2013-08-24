class exported::sshkeys {

  @@sshkey { "${::fqdn}_dsa":
    host_aliases => [ $::fqdn, $::hostname, $::ipaddress ],
    type         => dsa,
    key          => $::sshdsakey,
  }

  @@sshkey { "${::fqdn}_rsa":
    host_aliases => [ $::fqdn, $::hostname, $::ipaddress ],
    type         => rsa,
    key          => $::sshrsakey,
  }

  # collect all ssh keys
  Sshkey <<| |>>

}
