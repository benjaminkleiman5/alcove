#!/bin/sh

# Makes it so that the script will immediately exit if a command fails
set -e

cd /opt/alcove

mkdir -p /etc/alcove/ssl

# On first run of the container, setup the environment
if [ ! -f node_modules/ready ]; then
  # Install / compile modules
  sudo chmod 777 /opt/alcove/node_modules
  npm install --dev
  # Finish install
  touch node_modules/ready
fi

# Ensure permissions work
echo "Ensuring 'data', 'logs', 'etc', and 'public/style.css' are writeable..."
sudo chmod 777 /opt/alcove/data
sudo chmod 777 /opt/alcove/logs
sudo chmod 777 /opt/alcove/etc
sudo chmod 777 /opt/alcove/public/css/style.css

mkdir -p config
mkdir -p config/machines
mkdir -p /var/log/alcove
chmod 777 /var/log/alcove

#want to put this inside of an if block so we aren't creating a config file everytime ideally

content_alcove="ip='127.0.0.1'
port='$PORT'
log_dir='/var/log/alcove'
log_level='ERROR'
data_dir='data/'

                ; Allow the web server to initiate sessions even if it is likely that the
                ; session ID will be sent over plaintext (not configured with HTTPS enabled,
                ; and no forward proxy detected that is using HTTPS). It might be required
                ; to enable this if you have a broken forward proxy that is unable to set
                ; the 'X-Forwarded-Proto' header.
                ;
                ; ** Use with caution **
                ; This setting enables the system to operate in a manner that could allow
                ; for trivial session hijacking to occur...
                ;allow_insecure=false
[secure]
key='/etc/alcove/ssl/ssl.key'
cert='/etc/alcove/ssl/ssl.crt'
[rsync]
max_simultaneous='$MAX_SIMULTANEOUS'
identity='/home/node/.ssh/id_rsa'
user='root'
[rsync.retry]
max_attempts='$MAX_ATTEMPTS'
time='$TIME'
multiplier='$MULTIPLIER'
[notifications]
summary_schedule='$SUMMARY_SCHEDULE'
email_to[]='$EMAIL_TO'
email_from='$EMAIL_FROM'
[notifications.smtp]
host='$HOST'
port='$PORTS'
user='$USER'
pass='$PASS'
[notifications.sms]
[notifications.slack]
"
content_machine="name='$NAME'
host='$MACHINE_HOST'
schedule='$SCHEDULE'"

file_path="config/alcove.ini"

echo "$content_alcove" > "$file_path"

file_path="config/machines/machine.ini"

echo "$content_machine" > "$file_path"

npx gulp




