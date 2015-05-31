# portmap

Tested with Travis CI

[![Puppet Forge](http://img.shields.io/puppetforge/v/bodgit/portmap.svg)](https://forge.puppetlabs.com/bodgit/portmap)
[![Build Status](https://travis-ci.org/bodgit/puppet-portmap.svg?branch=master)](https://travis-ci.org/bodgit/puppet-portmap)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with portmap](#setup)
    * [What portmap affects](#what-portmap-affects)
    * [Beginning with portmap](#beginning-with-portmap)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Classes and Defined Types](#classes-and-defined-types)
        * [Class: portmap](#class-portmap)
    * [Examples](#examples)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages the RPC port mapper.

## Module Description

This module installs and manages either the `portmap` or `rpcbind` daemon, a
prerequisite for NFS and/or NIS services.

## Setup

### What portmap affects

* The package providing the RPC port mapper.
* The service controlling the `portmap` or `rpcbind` daemon.

### Beginning with portmap

```puppet
include ::portmap
```

## Usage

### Classes and Defined Types

#### Class: `portmap`

**Parameters within `portmap`:**

##### `manage_package`

Whether to manage a package or not. Some operating systems have a port mapper
as part of the base system.

##### `package_name`

The name of the package to install that provides the port mapper.

##### `service_name`

The name of the service

### Examples

Install and enable the port mapper:

```puppet
include ::portmap
```

## Reference

### Classes

#### Public Classes

* [`portmap`](#class-portmap): Main class for installing the RPC port mapper.

#### Private Classes

* `portmap::install`: Handles package installation.
* `portmap::params`: Different configuration data for different systems.
* `portmap::service`: Handles the `portmap` or `rpcbind` daemon.

## Limitations

This module has been built on and tested against Puppet 3.0 and higher.

The module has been tested on:

* RedHat/CentOS Enterprise Linux 5/6/7
* Ubuntu 12.04/14.04
* Debian 6/7
* OpenBSD 5.7

It should also probably work on:

* Fedora 19/20 (need vagrant boxes for tests)

Testing on other platforms has been light and cannot be guaranteed.

## Development

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-portmap).
