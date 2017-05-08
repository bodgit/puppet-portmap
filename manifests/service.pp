# @!visibility private
class portmap::service {

  if $::portmap::manage_service {
    $portmap_service = 'running'
    $portmap_enable  = true
  }
  else {
    $portmap_service = 'stopped'
    $portmap_enable  = false
  }

  service { $::portmap::service_name:
    ensure     => $portmap_service,
    enable     => $portmap_enable,
    hasstatus  => true,
    hasrestart => true;
  }

  if $::portmap::service_provider == 'systemd' {
    service { "${::portmap::service_name}.socket":
      ensure     => $portmap_service,
      enable     => $portmap_enable,
      hasstatus  => true,
      hasrestart => true;
    }
  }
}
