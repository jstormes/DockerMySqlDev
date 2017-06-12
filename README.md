# DockerMySqlDev
Scripts for quickly setting up a temporary MySQL databases for development.

## Quick start Windows

* Install Docker
* Clone this repo
* Right Click on the `bin\start-mysql-dev.ps1` file
* Run with PowerShell
* See the PowerShell console for how to connect to the database

## Quick start OS X and Linux

* Install Docker
* Clone this repo
* Run the `bin/start-mysql-dev.sh` file
* See the console for how to connect to the database

## Usage

Clone this repo and replace the `DOCKER_HUB_IMAGE` in `start-mysql-dev.sh` and
`start-mysql-dev.ps1` with the version of MySQL or MariaDB you are using in 
your production system.

Replace the scripts in `sql/base` with scripts to load your starting/test 
database.  You can test your startup script by re-running `mysql_run_dir`
from the command line inside the container.

Publish your new repo to your team.  This will give them a starting database
for development.  If you use appropriate [re-run safe syntax](https://www.stormes.net/deploying-mysql-updates/), you can use 
this same technique for deploying your production database changes.

By adding these scripts into your source code, you can include a development/test
MySQL server with your code.  You can track database schema changes along side source
code changes in the source control system.

## Advanced Options

The `*.sql` scripts are run in `sort -V` order in each of the following 
directories:

* `sql/pre`
* `sql/base`
* `sql/seed`
* `sql/post`

You can used a modified version of this technique for production omitting 
the appropriate directories.  This will just publish database changes to 
production.

Put data for bug regression testing in the `sql/seed` directory to speed regression
testing by developers.  Skip the `sql/seed` directory for production deployments. 

To run multiple MySQL containers at the same time on the same machine, you have to
change the `CONTAINER_NAME` and `EXTERNAL_MYSQL_PORT` in the `start-mysql-dev.ps1` and
`start-mysql-dev.sh` files.

## Blogpost

[MySQL in Docker for FasterDevelopment and Testing](https://www.stormes.net/using-docker-mysql-faster-development/)

## Screencast 

(TBD)