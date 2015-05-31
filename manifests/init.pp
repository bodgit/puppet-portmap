#
class portmap (
  $manage_package = $::portmap::params::manage_package,
  $package_name   = $::portmap::params::package_name,
  $service_name   = $::portmap::params::service_name,
) inherits ::portmap::params {

  validate_bool($manage_package)
  if $manage_package {
    validate_string($package_name)
  }
  validate_string($service_name)

  include ::portmap::install
  include ::portmap::service

  anchor { 'portmap::begin': }
  anchor { 'portmap::end': }

  Anchor['portmap::begin'] -> Class['::portmap::install']
    -> Class['::portmap::service'] -> Anchor['portmap::end']
}
