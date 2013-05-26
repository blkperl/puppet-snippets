class puppetsnippet {

  # puppet export examples
  include exported::hosts
  include exported::sshkeys
  include exported::nagios

  class { 'rsyslog::client':
    log_remote     => true,
    remote_type    => 'tcp',
    log_local      => true,
    log_auth_local => false,
    custom_config  => undef,
    server         => 'logmaster.lan',
    port           => '514',
  }

}
