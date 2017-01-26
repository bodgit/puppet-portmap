# portmap

Tested with Travis CI

[![Build Status](https://travis-ci.org/bodgit/puppet-portmap.svg?branch=master)](https://travis-ci.org/bodgit/puppet-portmap)
[![Coverage Status](https://coveralls.io/repos/bodgit/puppet-portmap/badge.svg?branch=master&service=github)](https://coveralls.io/github/bodgit/puppet-portmap?branch=master)
[![Puppet Forge](http://img.shields.io/puppetforge/v/bodgit/portmap.svg)](https://forge.puppetlabs.com/bodgit/portmap)
[![Dependency Status](https://gemnasium.com/bodgit/puppet-portmap.svg)](https://gemnasium.com/bodgit/puppet-portmap)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with portmap](#setup)
    * [Beginning with portmap](#beginning-with-portmap)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module manages the RPC port mapper.

## Setup

### Beginning with portmap

In the very simplest case, you can just include the following:

```puppet
include ::portmap
```

## Usage

The port mapper exposes no configuration options so the above example is all
that is necessary.

## Reference

The reference documentation is generated with
[puppet-strings](https://github.com/puppetlabs/puppet-strings) and the latest
version of the documentation is hosted at
[https://bodgit.github.io/puppet-portmap/](https://bodgit.github.io/puppet-portmap/).

## Limitations

This module has been built on and tested against Puppet 4.4.0 and higher.

The module has been tested on:

* RedHat Enterprise Linux 5/6/7
* Ubuntu 12.04/14.04/16.04
* Debian 6/7/8
* OpenBSD 6.0

## Development

The module has both [rspec-puppet](http://rspec-puppet.com) and
[beaker-rspec](https://github.com/puppetlabs/beaker-rspec) tests. Run them
with:

```
$ bundle exec rake test
$ PUPPET_INSTALL_TYPE=agent PUPPET_INSTALL_VERSION=x.y.z bundle exec rake beaker:<nodeset>
```

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-portmap).
