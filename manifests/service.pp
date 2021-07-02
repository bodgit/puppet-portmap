# @!visibility private
class portmap::service {

  service { $portmap::service_name:
    ensure     => $portmap::service_ensure,
    enable     => $portmap::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
