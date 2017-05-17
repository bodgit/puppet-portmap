require 'spec_helper_acceptance'

describe 'portmap' do
  case fact('osfamily')
  when 'RedHat'
    case fact('operatingsystemmajrelease')
    when '5'
      package_name = 'portmap'
      service_name = 'portmap'
    when '6'
      package_name = 'rpcbind'
      service_name = 'rpcbind'
    else
      package_name = 'rpcbind'
      service_name = 'rpcbind.socket'
    end
  when 'Debian'
    package_name = 'rpcbind'
    case fact('operatingsystem')
    when 'Ubuntu'
      case fact('operatingsystemrelease')
      when '12.04'
        service_name = 'portmap'
      when '14.04'
        service_name = 'rpcbind'
      else
        service_name = 'rpcbind.socket'
      end
    else
      service_name = 'rpcbind'
    end
  when 'OpenBSD'
    service_name = 'portmap'
  end

  it 'should work with no errors' do
    pp = <<-EOS
      class { '::portmap':
        service_enable => false,
        service_ensure => stopped,
      }
    EOS

    apply_manifest(pp, :catch_failures => true)
    # Debian 8 has some sort of bug that restarts rpcbind the first time you stop it
    apply_manifest(pp, :catch_failures => true) if (fact('operatingsystem').eql?('Debian') and fact('operatingsystemmajrelease').eql?('8'))
    apply_manifest(pp, :catch_changes  => true)
  end

  describe package(package_name), :unless => fact('osfamily').eql?('OpenBSD') do
    it { should be_installed }
  end

  describe service(service_name) do
    # For some reason this fails on Ubuntu 14.04 despite Puppet thinking it is disabled
    it { should_not be_enabled } unless (fact('operatingsystem').eql?('Ubuntu') and fact('operatingsystemrelease').eql?('14.04'))
    it { should_not be_running }
  end

  describe command('rpcinfo -p') do
    its(:exit_status) { should eq 1 }
  end
end
