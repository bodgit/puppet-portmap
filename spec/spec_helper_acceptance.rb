require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

hosts.each do |host|
  install_puppet({ :default_action => 'gem_install' })
end

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => proj_root, :module_name => 'portmap')
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
