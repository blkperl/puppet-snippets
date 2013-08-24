class puppetsnippt::dhcpserver {

  class { 'dhcp':
    dnsdomain    => [
      'lan',
      '1.0.10.in-addr.arpa',
      ],
    nameservers  => ['8.8.8.8'],
    ntpservers   => ['us.pool.ntp.org'],
    interfaces   => ['eth0'],
    #dnsupdatekey => "/etc/bind/keys.d/$ddnskeyname",
    #require      => Bind::Key[ $ddnskeyname ],
    pxeserver    => '10.0.3.2',
    pxefilename  => 'pxelinux.0',
  }

  dhcp::pool{ 'lan':
    network => '10.0.3.1',
    mask    => '255.255.255.0',
    range   => '10.0.1.100 10.0.1.200',
    gateway => '10.0.3.1',
  }

}
