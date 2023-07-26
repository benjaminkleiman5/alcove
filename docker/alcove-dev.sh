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

content_alcove="
                log_level='DEBUG'
                data_dir='data/'
                [secure]
                key='./etc/alcove/ssl/ssl.key'
                cert='./etc/alcove/ssl/ssl.crt'
                [rsync]
                [rsync.retry]
                [notifications]
                summary_schedule='0,1,2,3,4,5,6;[17:01]'
                email_to[]='your.email@gmail.com'
                email_from='your.email@gmail.com'
                [notifications.smtp]
                host='smtp.gmail.com'
                port=587
                user='your.email@gmail.com'
                pass='your_password'
                [notifications.sms]
                [notifications.slack]"
file_path_alcove="config/alcove.ini"

content="
         name=alcove-dev-container
         host=localhost
         backup_directories[] = /backup-test"
file_path="config/machines/machine.ini"

echo "$content" > "$file_path"

npx gulp




