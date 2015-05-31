require 'spec_helper'

shared_examples_for 'portmap' do
  it { should contain_anchor('portmap::begin') }
  it { should contain_anchor('portmap::end') }
  it { should contain_class('portmap') }
  it { should contain_class('portmap::install') }
  it { should contain_class('portmap::params') }
  it { should contain_class('portmap::service') }
end

describe 'portmap' do

  context 'on unsupported distributions' do
    let(:facts) do
      {
        :osfamily => 'Unsupported'
      }
    end

    it { expect { should compile}.to raise_error(/not supported on an Unsupported/) }
  end

  context 'on RedHat' do
    let(:facts) do
      {
        :osfamily => 'RedHat'
      }
    end

    [5, 6, 7].each do |version|
      context "version #{version}", :compile do
        let(:facts) do
          super().merge(
            {
              :operatingsystemmajrelease => version
            }
          )
        end

        it_behaves_like 'portmap'

        case version
        when 5
          it { should contain_package('portmap') }
          it { should contain_service('portmap') }
        else
          it { should contain_package('rpcbind') }
          it { should contain_service('rpcbind') }
        end
      end
    end
  end

  context 'on Ubuntu' do
    let(:facts) do
      {
        :osfamily        => 'Debian',
        :operatingsystem => 'Ubuntu',
        :lsbdistid       => 'Ubuntu'
      }
    end

    ['precise', 'trusty'].each do |codename|
      context codename, :compile do
        let(:facts) do
          super().merge(
            {
              :lsbdistcodename => codename
            }
          )
        end

        it_behaves_like 'portmap'

        case codename
        when 'precise'
          it { should contain_package('rpcbind') }
          it { should contain_service('portmap') }
        else
          it { should contain_package('rpcbind') }
          it { should contain_service('rpcbind') }
        end
      end
    end
  end

  context 'on Debian' do
    let(:facts) do
      {
        :osfamily        => 'Debian',
        :operatingsystem => 'Debian',
        :lsbdistid       => 'Debian'
      }
    end

    ['squeeze', 'wheezy'].each do |codename|
      context codename, :compile do
        let(:facts) do
          super().merge(
            {
              :lsbdistcodename => codename
            }
          )
        end

        it_behaves_like 'portmap'

        it { should contain_package('rpcbind') }
        it { should contain_service('rpcbind') }
      end
    end
  end

  context 'on OpenBSD', :compile do
    let(:facts) do
      {
        :osfamily => 'OpenBSD'
      }
    end

    it_behaves_like 'portmap'

    it { should have_package_resource_count(0) }
    it { should contain_service('portmap') }
  end
end
