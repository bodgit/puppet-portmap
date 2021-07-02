# frozen_string_literal: true

def portmap_settings_hash
  portmap = {}

  case host_inventory['facter']['os']['family']
  when 'Debian'
    portmap['have_package'] = true
    portmap['package']      = 'rpcbind'
    portmap['service']      = 'rpcbind.socket'
  when 'OpenBSD'
    portmap['have_package'] = false
    portmap['service']      = 'portmap'
  when 'RedHat'
    portmap['have_package'] = true
    portmap['package']      = 'rpcbind'
    portmap['service']      = host_inventory['facter']['os']['release']['major'].eql?('6') ? 'rpcbind' : 'rpcbind.socket'
  else
    raise 'unknown operating system'
  end

  portmap
end
