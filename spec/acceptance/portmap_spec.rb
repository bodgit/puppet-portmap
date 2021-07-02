require 'spec_helper_acceptance'

portmap_hash = portmap_settings_hash

describe 'portmap' do
  context 'default parameters' do
    let(:pp) do
      <<-MANIFEST
        include portmap
      MANIFEST
    end

    it 'applies idempotently' do
      idempotent_apply(pp)
    end

    describe package(portmap_hash['package']), if: portmap_hash['have_package'] do
      it { is_expected.to be_installed }
    end

    describe service(portmap_hash['service']) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    # Explicitly adding the '-p' changes the output on the rpcbind version
    describe command('rpcinfo -p') do
      its(:stdout) do
        is_expected.to match %r{100000 \s+ 2 \s+ tcp \s+ 111 \s+ portmapper}x
        is_expected.to match %r{100000 \s+ 2 \s+ udp \s+ 111 \s+ portmapper}x
      end
      its(:exit_status) { is_expected.to eq 0 }
    end
  end

  context 'stopped and disabled' do
    let(:pp) do
      <<-MANIFEST
        class { 'portmap':
          service_enable => false,
          service_ensure => stopped,
        }
      MANIFEST
    end

    it 'applies idempotently' do
      idempotent_apply(pp)
    end

    describe package(portmap_hash['package']), if: portmap_hash['have_package'] do
      it { is_expected.to be_installed }
    end

    describe service(portmap_hash['service']) do
      it { is_expected.not_to be_enabled }
      it { is_expected.not_to be_running }
    end

    describe command('rpcinfo -p') do
      its(:exit_status) { is_expected.to eq 1 }
    end
  end
end
