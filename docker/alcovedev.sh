#!/bin/sh

#Makes it so that the script will immediately exit if a command fails
set -e
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
echo "$content_alcove" > "$file_path_alcove"
content="
         name=alpha

         host=localhost

         backup_directories[] = /backup-test

         ignore_extensions[] = .testignored

         ignore_files[] = /backup-test/ignored
         ignore_files[] = /backup-test/ignore-me.txt"

# File path
file_path="config/machines/machine.ini"

echo "$content" > "$file_path"

# Run SSH daemon in the foreground. Starts the SSH server process and keeps it active.
#
# Sources where this is used:
# https://forums.docker.com/t/how-to-run-a-service-in-an-image/68224
# https://dev.to/s1ntaxe770r/how-to-setup-ssh-within-a-docker-container-i5i
#/usr/sbin/sshd -D



