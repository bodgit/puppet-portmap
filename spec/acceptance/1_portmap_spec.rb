require 'spec_helper_acceptance'

describe 'portmap' do
  case fact('osfamily')
  when 'RedHat'
    package_name = 'rpcbind'
    service_name = case fact('operatingsystemmajrelease')
                   when '6'
                     'rpcbind'
                   else
                     'rpcbind.socket'
                   end
  when 'Debian'
    package_name = 'rpcbind'
    service_name = case fact('operatingsystem')
                   when 'Ubuntu'
                     case fact('operatingsystemrelease')
                     when '14.04'
                       'rpcbind'
                     else
                       'rpcbind.socket'
                     end
                   else
                     'rpcbind'
                   end
  when 'OpenBSD'
    service_name = 'portmap'
  end

  it 'works with no errors' do
    pp = <<-EOS
      class { '::portmap':
        service_enable => false,
        service_ensure => stopped,
      }
    EOS

    apply_manifest(pp, catch_failures: true)
    # Debian 8 has some sort of bug that restarts rpcbind the first time you stop it
    apply_manifest(pp, catch_failures: true) if fact('operatingsystem').eql?('Debian') && fact('operatingsystemmajrelease').eql?('8')
    apply_manifest(pp, catch_changes:  true)
  end

  describe package(package_name), unless: fact('osfamily').eql?('OpenBSD') do
    it { is_expected.to be_installed }
  end

  describe service(service_name) do
    # For some reason this fails on Ubuntu 14.04 despite Puppet thinking it is disabled
    it { is_expected.not_to be_enabled } unless fact('operatingsystem').eql?('Ubuntu') && fact('operatingsystemrelease').eql?('14.04')
    it { is_expected.not_to be_running }
  end

  describe command('rpcinfo -p') do
    its(:exit_status) { is_expected.to eq 1 }
  end
end
