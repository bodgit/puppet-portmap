require 'spec_helper'

describe 'portmap' do
  context 'on unsupported distributions' do
    let(:facts) do
      {
        osfamily: 'Unsupported',
      }
    end

    it { is_expected.to compile.and_raise_error(%r{not supported on an Unsupported}) }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('portmap') }
      it { is_expected.to contain_class('portmap::install') }
      it { is_expected.to contain_class('portmap::params') }
      it { is_expected.to contain_class('portmap::service') }

      # rubocop:disable RepeatedExample

      case facts[:osfamily]
      when 'Debian'
        it { is_expected.to contain_package('rpcbind') }
        case facts[:operatingsystem]
        when 'Ubuntu'
          case facts[:operatingsystemrelease]
          when '14.04'
            it { is_expected.to contain_service('rpcbind') }
          else
            it { is_expected.to contain_service('rpcbind.socket') }
          end
        else
          it { is_expected.to contain_service('rpcbind') }
        end
      when 'OpenBSD'
        it { is_expected.to have_package_resource_count(0) }
        it { is_expected.to contain_service('portmap') }
      when 'RedHat'
        it { is_expected.to contain_package('rpcbind') }
        case facts[:operatingsystemmajrelease]
        when '6'
          it { is_expected.to contain_service('rpcbind') }
        else
          it { is_expected.to contain_service('rpcbind.socket') }
        end
      end
    end
  end
end
