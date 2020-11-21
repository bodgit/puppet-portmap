# @!visibility private
class portmap::params {

  $service_enable = true
  $service_ensure = 'running'

  case $facts['os']['family'] {
    'RedHat': {
      $manage_package = true
      $package_name   = 'rpcbind'

      case $facts['os']['release']['major'] {
        '6': {
          $service_name = 'rpcbind'
        }
        default: {
          $service_name = 'rpcbind.socket'
        }
      }
    }
    'Debian': {
      $manage_package = true
      $package_name   = 'rpcbind'

      case $facts['os']['name'] {
        'Ubuntu': {
          case $facts['os']['release']['full'] {
            '14.04': {
              $service_name = 'rpcbind'
            }
            default: {
              $service_name = 'rpcbind.socket'
            }
          }
        }
        default: {
          $service_name = 'rpcbind'
        }
      }
    }
    'OpenBSD': {
      # Part of the base system
      $manage_package = false
      $package_name   = undef
      $service_name   = 'portmap'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${facts['os']['family']} based system.")
    }
  }
}
