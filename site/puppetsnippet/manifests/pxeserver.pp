class puppetsnippet::pxeserver {

  include pxe

  $ubuntu = {
    "arch" => ['amd64'],
    "ver"  => ['precise'],
    "os"   => "ubuntu"
  }

  resource_permute('pxe::images', $ubuntu)

  pxe::menu {
    'Main Menu':
      file      => "default",
      template  => "pxe/menu_default.erb";
  }

  pxe::menu::entry {
    "Installations":
      file    => "default",
      append  => "pxelinux.cfg/menu_install",
  }

}
