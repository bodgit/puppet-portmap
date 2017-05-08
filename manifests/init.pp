# Install the RPC port mapper.
#
# @example Declaring the class
#   include ::portmap
#
# @param manage_package Whether a package is needed to be installed.
# @param manage_service Whether service is running or not.
# @param package_name The package name, usually either `portmap` or `rpcbind`.
# @param service_name The service name, usually either `portmap` or `rpcbind`.
class portmap (
  Boolean          $manage_package   = $::portmap::params::manage_package,
  Boolean          $manage_service   = $::portmap::params::manage_service,
  Optional[String] $package_name     = $::portmap::params::package_name,
  String           $service_name     = $::portmap::params::service_name,
  String           $service_provider = $::portmap::params::service_provider,
) inherits ::portmap::params {

  contain ::portmap::install
  contain ::portmap::service

  Class['::portmap::install'] -> Class['::portmap::service']
}
