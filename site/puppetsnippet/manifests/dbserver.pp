class puppetsnippet::dbserver {

  class { 'postgresql::server':
    config_hash => {
      'ip_mask_allow_all_users'    => '10.0.0.0/8',
      'listen_addresses'           => '*',
      'ipv4acls'                   => ['hostssl all * 10.0.0.0/8 md5'],
      'manage_redhat_firewall'     => true,
  },
}

  Postgresql::Db <<| tag == "pgserver_$hostname" |>> {}

}
