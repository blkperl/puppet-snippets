
# This class installs the supported Oracle repositories
#
# FIXME:
# It should be replaced by a generic type/provider or module for managing
# IPS repositories

class publisher(
  $ssl_key = 'Oracle_Solaris_11_Support.key.pem',
  $ssl_cert = 'Oracle_Solaris_11_Support.certificate.pem',
  $ssl_dir = '/var/pkg/ssl',
  $origin_to_add = 'https://pkg.oracle.com/solaris/support/',
  $origin_to_remove = 'http://pkg.oracle.com/solaris/release/',
) {

  file { $ssl_dir:
    ensure => directory,
    mode   => '0755',
  }

  file { 'ssl_key':
    name    => "$ssl_dir/$ssl_key",
    content => hiera($ssl_key),
    require => File[$ssl_dir],
  }

  file { 'ssl_cert':
    name    => "$ssl_dir/$ssl_cert",
    content => hiera($ssl_cert),
    require => File[$ssl_dir],
  }

  exec { 'setup-oracle-support-repo':
    command => "pkg set-publisher -k $ssl_dir/$ssl_key \
      -c $ssl_dir/$ssl_cert \
      -g $origin_to_add \
      -G $origin_to_remove solaris",
    path    => ['/usr/bin', '/usr/sbin'],
    onlyif  => "pkg publisher -H  solaris | grep '$origin_to_remove'",
    require => [File['ssl_key'], File['ssl_cert']]
  }
}
