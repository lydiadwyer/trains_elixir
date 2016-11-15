# trains_elixir

# use VirtualBox or VMWare to create this machine
#### Run to get started
```shell
cd /local/folder
vagrant up
```
# wait until finished
# current script should autorun these commands, except ssh

```shell
vagrant ssh
#cd /var/www/trains_elixir/
#mix deps.get
#npm install
#mix ecto.drop
#mix ecto.create
#mix ecto.migrate
#mix run priv/repo/seeds.exs
```
# current script should autorun these commands


# go to localhost:4000/traintime
# train times should appear, else troubleshoot

# seeds.exs is not currently running automatically every X minutes, must be manually run to get data





# Elixir provisioning for Vagrant

## What is it for?

Developers can use a Virtual Machine (VM) for development in order to quickly get up and running with a system that has Elixir installed. Everyone will have the same setup regardless of the host machine.

The VM will have:
* Linux (Ubuntu)
* Erlang
* Elixir
* PostgreSQL
* nodejs 7 and other dependencies for the Phoenix framework



## Version control

 `Vagrantfile` and `vagrant_provision.sh` should be added to version control.
On the other hand it is recommended to ignore the `.vagrant` directory. If you are using git you could add this line to `.gitignore`:
`.vagrant/*`

## Phoenix / inotify auto-reload issues

Warning: There are issues with Phoenix auto reloading and Vagrant. This appears to be because
of inotify being incompatible with the `/vagrant` directory being connected to the host file system.

Vagrant can still be used for instance for doing releases of a Phoenix project.

## Warning: Hex dependencies

If you do `mix deps.get` on the vagrant machine it will get dependencies appropriate for that.
Some dependencies are only compatible for that machine. This means that if you run `mix deps.get`
on the vagrant machine you can only use those kinds of dependencies on the vagrant machine and not
on the host. And vice versa.








