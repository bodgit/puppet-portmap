#
class portmap::install {

  if $::portmap::manage_package {
    package { $::portmap::package_name:
      ensure => present,
    }
  }
}
