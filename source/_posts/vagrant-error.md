---
title: vagrant booting error
date: 2022-08-24 20:51:22
tags:
  - vagrant
  - virtual machine
  - ruby
---

## Error.1 NS_ERROR_FAILURE

Using macos to debug c program is annoying...

Tried to use vagrant vm, but I met error while booting the vm

```
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component MachineWrap, interface IMachine
```

### Solution

https://stackoverflow.com/questions/52689672/virtualbox-ns-error-failure-0x80004005-macos

I tried reinstall Virtualbox, not working

I tried reboot mbp, this time it worked

Don't know the root reason yet

## Error.2 `umount: /mnt: not mounted`

```bash
$ vagrant up

...

The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

umount /mnt

Stdout from the command:



Stderr from the command:

umount: /mnt: not mounted
```

then I can `vagrant ssh` into the machine, seem above error is not a big deal

But I want to make it go away...

### Reason

seems related to vagrant plugin `vagrant-vbguest`

```bash
vagrant plugin list
vagrant plugin uninstall vagrant-vbguest
```

### Solution


Unistall the plugin and reboot the vagrant vm

```bash
vagrant halt
vagrant destroy
vagrant up
vagrant ssh
```

## Error.3 `Remote connection disconnect. Retrying`

https://github.com/hashicorp/vagrant/issues/9834#issuecomment-460061515

### Reason

Seems related to vagrant .vagrant folder cache

### Solution

```bash
vagrant halt
vagrant destroy
rm -rf .vagrant

vagrant up
vagrant ssh
```



