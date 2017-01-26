require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

hosts.each do |host|
  # Just assume the OpenBSD box has Puppet installed already
  if host['platform'] !~ /^openbsd-/i
    run_puppet_install_helper_on(host)
  end
end

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      puppet_module_install(:source => proj_root, :module_name => 'portmap')
    end
  end
end
