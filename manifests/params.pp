# @!visibility private
class portmap::params {

  $manage_package = true
  $manage_service = true

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '5': {
          $package_name     = 'portmap'
          $service_name     = 'portmap'
          $service_provider = 'init'
        }
        '6': {
          $package_name     = 'rpcbind'
          $service_name     = 'rpcbind'
          $service_provider = 'init'
        }
        default: {
          $package_name     = 'rpcbind'
          $service_name     = 'rpcbind'
          $service_provider = 'systemd'
        }
      }
    }
    'Debian': {
      $package_name   = 'rpcbind'
      case $::lsbdistcodename {
        'precise': {
          $service_name     = 'portmap'
          $service_provider = 'upstart'
        }
        'trusty': {
          $service_name     = 'rpcbind'
          $service_provider = 'upstart'
        }
        'squeeze': {
          $service_name     = 'rpcbind'
          $service_provider = 'init'
        }
        'wheezy': {
          $service_name     = 'rpcbind'
          $service_provider = 'init'
        }
        default: {
          $service_name     = 'rpcbind'
          $service_provider = 'systemd'
        }
      }
    }
    'OpenBSD': {
      # Part of the base system
      $manage_package   = false
      $manage_service   = false
      $package_name     = undef
      $service_name     = 'portmap'
      $service_provider = undef
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
