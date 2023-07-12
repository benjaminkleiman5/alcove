#!/bin/sh

#Makes it so that the script will immediately exit if a command fails
set -e

# Run SSH daemon in the foreground. Starts the SSH server process and keeps it active.
#
# Sources where this is used:
# https://forums.docker.com/t/how-to-run-a-service-in-an-image/68224
# https://dev.to/s1ntaxe770r/how-to-setup-ssh-within-a-docker-container-i5i
#/usr/sbin/sshd -D



