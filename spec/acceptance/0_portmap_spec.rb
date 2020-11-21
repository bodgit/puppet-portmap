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
      include ::portmap
    EOS

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes:  true)
  end

  describe package(package_name), unless: fact('osfamily').eql?('OpenBSD') do
    it { is_expected.to be_installed }
  end

  describe service(service_name) do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  # Explicitly adding the '-p' changes the output on the rpcbind version
  describe command('rpcinfo -p') do
    its(:stdout) { is_expected.to match %r{100000 \s+ 2 \s+ tcp \s+ 111 \s+ portmapper}x }
    its(:stdout) { is_expected.to match %r{100000 \s+ 2 \s+ udp \s+ 111 \s+ portmapper}x }
    its(:exit_status) { is_expected.to eq 0 }
  end
end
