#
class portmap::params {

  case $::osfamily {
    'RedHat': {
      $manage_package = true
      case $::operatingsystemmajrelease {
        5: {
          $package_name = 'portmap'
          $service_name = 'portmap'
        }
        default: {
          $package_name = 'rpcbind'
          $service_name = 'rpcbind'
        }
      }
    }
    'Debian': {
      $manage_package = true
      $package_name   = 'rpcbind'
      $service_name   = $::lsbdistcodename ? {
        'precise' => 'portmap', # lolubuntu
        default   => 'rpcbind',
      }
    }
    'OpenBSD': {
      # Part of the base system
      $manage_package = false
      $service_name   = 'portmap'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.") # lint:ignore:80chars
    }
  }
}
