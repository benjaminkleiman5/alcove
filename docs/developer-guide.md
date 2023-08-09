# Developer Guide

The goal of this guide is to help developers:

1. Learn how to set up a development environment
2. Explore the structure and control flow of Alcove

## Setting Up A Development Environment

This section will explain step-by-step how to set up a development environment for Alcove.

### About Docker

Alcove uses Docker to ensure that each developer's environment is the same. Docker does this using images and containers. Containers are kind of like virtual machines in that they contain an operating system, dependencies, and project configurations. However, they have several advantages that are tangential to this guide. For more information, read this [article](https://www.docker.com/resources/what-container). Images are a way to distribute containers by creating a blueprint for what operating system to use, what dependencies to install, and what shell commands to run. If you come from an object-oriented background, you can think of images as classes and containers as instances of a class.

### Using Docker

You can download Docker here:

- [Linux](https://hub.docker.com/search?q=&type=edition&offering=community&operating_system=linux)
- [MacOS](https://download.docker.com/mac/stable/Docker.dmg)
- [Windows](https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe)

### Configuration
Make a copy of the dotenv.example file and name it .env. Configure the file as specified in the example.

### Starting up Alcove
Change your directory to the "docker" directory. Then, run this command to build the base image.
```shell script
docker build -t alcove-base -f DockerfileBase .
```
In the docker directory, run the start.sh script. A backup will start automatically one minute after you start up the script.


Now, you're done setting up the Alcove development environment. 

## A Tour of Alcove

This section will give a brief overview of how Alcove works.

### Control Flow

Execution of the backup system begins in `app.js`. The first thing that Alcove does is parse the system and machine configuration files. It is designed to fail liberally, so the system will refuse to start with a configuration error instead of crashing later on.

After that, Alcove configures logging.

Next, Alcove connects to the database. As mentioned already, the database is an SQLite file stored at `<data_dir>/events.db` (if you followed the guide above, this will be `<project_root>/data/events.db`.

Then, Alcove starts the main process. The core functionality of the backup system is contained in `<project_root>/lib/system.js`. This includes scheduling backups and generating summary emails.

Finally, the monitoring system starts up at `https://localhost:3000`. This allows users to see whether recent backups have succeeded and when backups of each machine are available. The monitoring system is a basic Express app stored in `<project_root>/app` using a MVC architecture.

### The Backup Process

Alcove schedules backups in `<project_root>/lib/system.js` by reading the schedule for each machine configuration. Then, Alcove generates "buckets", which are times when there should be backups. At each time indicated on the schedule, Alcove will check if the most recent bucket is empty. If it is, Alcove will start a backup of that machine. The actual backup process is handled in `<project_root>/lib/rsync.js`. Alcove will also delete any old buckets and their associated backups based on the schedule for that machine.

## Where do I go from here?

Before beginning work on Alcove, you should read the [design guide](design-guide.md). This guide explains much of the thinking behind why Alcove works the way it does.

In addition, you should read this [article](https://nvie.com/posts/a-successful-git-branching-model/) about GitFlow. Alcove uses GitFlow to maintain a simple version history.

You should also take note of two other docs:

- The exit codes [guide](exit-codes.md) explains what each exit code means.
- The SMS [guide](sms-guide.md) explains how to set up SMS notifications (in addition to regular email notifications).

At this point, you are ready to begin development of Alcove. Make sure to check out the outstanding issues [here](https://github.com/bioneos/alcove/issues).