require 'spec_helper_acceptance'

describe 'portmap' do
  case fact('osfamily')
  when 'RedHat'
    package_name = 'rpcbind'
    case fact('operatingsystemmajrelease')
    when '6'
      service_name = 'rpcbind'
    else
      service_name = 'rpcbind.socket'
    end
  when 'Debian'
    package_name = 'rpcbind'
    case fact('operatingsystem')
    when 'Ubuntu'
      case fact('operatingsystemrelease')
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
      include ::portmap
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes  => true)
  end

  describe package(package_name), :unless => fact('osfamily').eql?('OpenBSD') do
    it { should be_installed }
  end

  describe service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end

  # Explicitly adding the '-p' changes the output on the rpcbind version
  describe command('rpcinfo -p') do
    its(:stdout) { should match /100000 \s+ 2 \s+ tcp \s+ 111 \s+ portmapper/x }
    its(:stdout) { should match /100000 \s+ 2 \s+ udp \s+ 111 \s+ portmapper/x }
    its(:exit_status) { should eq 0 }
  end
end
