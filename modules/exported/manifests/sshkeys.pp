class exported::sshkeys {

  @@sshkey { "$::hostname-dsa":
    type => dsa,
    key  => $sshdsakey
  }

  @@sshkey { "$::hostname-rsa":
    type => rsa,
    key  => $::sshrsakey
  }

  # collect all ssh keys
  Sshkey <<| |>>

}
