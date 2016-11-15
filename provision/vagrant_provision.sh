#!/bin/sh

echo "INFO: Starting box, setting up basics"
ERLANG_VERSION=1:19.1.5
ELIXIR_VERSION=1.3.3-1
NODE_VERSION=6.9.1-1nodesource1~trusty1
POSTGRES_VERSION=9.5
POSTGRES_DB_PASS=postgres

# set the session to be noninteractive
export DEBIAN_FRONTEND="noninteractive"

# update apt-get
apt-get update

# Set language and locale
apt-get install -y language-pack-en > /dev/null
locale-gen --purge en_US.UTF-8
echo "LC_ALL='en_US.UTF-8'" >> /etc/environment
dpkg-reconfigure locales > /dev/null



# install basics
apt-get -q install -y build-essential daemon ntp inotify-tools \
	imagemagick  > /dev/null





# Postgres
echo "INFO: Installing and configuring Postgres"
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > \
	/etc/apt/sources.list.d/postgres.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
	apt-key add -
apt-get update
apt-get -y install postgresql-$POSTGRES_VERSION \
	postgresql-client-$POSTGRES_VERSION \
	postgresql-contrib-$POSTGRES_VERSION 2>&1


# configure Postgres
# INSECURE!!!
cp /vagrant/psql/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
cp /vagrant/psql/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
service postgresql restart

# rebuild the database
echo "INFO: Setting up the database..."
# INSECURE!!!
su - postgres -c "psql -c \"ALTER USER postgres with encrypted password '$POSTGRES_DB_PASS';\""

service postgresql restart

# Install Erlang
echo "INFO: Installing Erlang"
echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" >> \
	/etc/apt/sources.list
wget --quiet -O - http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | \
	apt-key add -
apt-get update
apt-get install -y esl-erlang=$ERLANG_VERSION


# Install nodejs and npm
echo "INFO: Installing nodejs and npm..."
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get install -y nodejs #=$NODE_VERSION
npm install npm@latest -g


# Install Elixir
echo "INFO: Installing Elixir"
apt-get install -y elixir=$ELIXIR_VERSION


# Install local Elixir hex and rebar for the vagrant user, and Phoenix
echo "INFO: Installing hex and rebar for vagrant user"

su - vagrant -c 'cd /var/www/trains_elixir/ && mix local.hex --force'
su - vagrant -c 'cd /var/www/trains_elixir/ && mix local.rebar --force'
su - vagrant -c 'cd /var/www/trains_elixir/ && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force'



# init logs
mkdir -p /var/log/trains_elixir/
touch /var/log/trains_elixir/info.log


# Install Phoenix
echo "INFO: Install Phoenix project..."
su - vagrant -c 'mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force'



# Create "trains_elixir" project
echo "INFO: Creating 'trains_elixir' project..."
mkdir -p /var/www/trains_elixir/
chown -R vagrant:vagrant /var/www/trains_elixir/
# rm -rf /var/www/*
# su - vagrant -c 'cd /var/www/ && echo "no" | mix phoenix.new trains_elixir'
su - vagrant -c 'cd /var/www/trains_elixir/ && mix local.hex --force'
su - vagrant -c 'cd /var/www/trains_elixir/ && mix local.rebar --force'
su - vagrant -c 'cd /var/www/trains_elixir/ && mix deps.get'
su - vagrant -c 'cd /var/www/trains_elixir/ && mix ecto.drop'
su - vagrant -c 'cd /var/www/trains_elixir/ && mix ecto.create && mix ecto.migrate'


echo "INFO: Installing 'trains_elixir' npm modules..."
su - vagrant -c 'cd /var/www/trains_elixir/ && npm cache clean'
su - vagrant -c 'cd /var/www/trains_elixir/ && npm install --loglevel=error --no-bin-links'

echo "INFO: Launching 'trains_elixir'..."
su - vagrant -c 'cd /var/www/trains_elixir/ && mix run priv/repo/seeds.exs'
su - vagrant -c 'cd /var/www/trains_elixir/ && elixir --detached -S mix phoenix.server'

# update file location database
updatedb
