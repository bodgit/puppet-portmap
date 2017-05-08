# @!visibility private
class portmap::service {

  if $::portmap::service_status == 'running' {
    $portmap_ensure = 'running'
    $portmap_enable = true
  }
  elsif $::portmap::service_status == 'mask' {
    $portmap_ensure = 'stopped'
    $portmap_enable = 'mask'
  }
  else {
    $portmap_ensure = 'stopped'
    $portmap_enable = false
  }

  service { $::portmap::service_name:
    ensure     => $portmap_ensure,
    enable     => $portmap_enable,
    hasstatus  => true,
    hasrestart => true;
  }

  if $::portmap::service_provider == 'systemd' {
    service { "${::portmap::service_name}.socket":
      ensure     => $portmap_ensure,
      enable     => $portmap_enable,
      hasstatus  => true,
      hasrestart => true;
    }
  }
}
