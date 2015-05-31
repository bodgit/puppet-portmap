source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :development, :test do
  gem 'rake',                        :require => false
  gem 'rspec',                       :require => false
  gem 'rspec-puppet', '~> 2.0.0',    :require => false
  gem 'puppetlabs_spec_helper',      :require => false
  gem 'puppet-lint', '~> 1.0.1',     :require => false
  gem 'librarian-puppet', '< 2.0.0', :require => false
  gem 'beaker',                      :require => false, :git => 'https://github.com/bodgit/beaker.git', :branch => 'openbsd'
  gem 'beaker-rspec',                :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
