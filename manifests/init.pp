# Install the RPC port mapper.
#
# @example Declaring the class
#   include ::portmap
#
# @param manage_package Whether a package is needed to be installed.
# @param package_name The package name, usually either `portmap` or `rpcbind`.
# @param service_enable Whether to enable the service or not.
# @param service_ensure Whether the service should be running or stopped.
# @param service_name The service name, usually either `portmap` or `rpcbind`.
class portmap (
  Boolean                    $manage_package = $::portmap::params::manage_package,
  Optional[String]           $package_name   = $::portmap::params::package_name,
  Boolean                    $service_enable = $::portmap::params::service_enable,
  Enum['running', 'stopped'] $service_ensure = $::portmap::params::service_ensure,
  String                     $service_name   = $::portmap::params::service_name,
) inherits ::portmap::params {

  contain ::portmap::install
  contain ::portmap::service

  Class['::portmap::install'] -> Class['::portmap::service']
}
