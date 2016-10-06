# vagrant-template
A file organization for a Vagrant box with multiple synced folders, using both vagrant-hostsupdater and vagrant-winnfsd plugins.
Salt is used for provisioning.

## All

```bash
$ vagrant plugin install vagrant-vbguest
```

## Windows

```
$ vagrant plugin install vagrant-winnfsd
```

## Not Windows

```
$ vagrant plugin install vagrant-hostsupdater
```