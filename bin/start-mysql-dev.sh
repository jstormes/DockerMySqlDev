#!/usr/bin/env bash
# This script starts a MySql docker container, then starts a
# bash shell in the container.
#
# When the user exits the bash shell it stops the container.
#
#
Container_Name="mysql-dev"
MYSQL_ROOT_PASSWORD="mypassword"
MYSQL_DATABASE_NAME="employees"
EXTERNAL_MYSQL_PORT="4000"
DOCKER_HUB_IMAGE="mysql:5.5"  # Other Options include "mariadb", "mysql"

docker -v >/dev/null 2>&1 ||
{
    echo >&2 "Docker not installed, the 'docker' command is required to run this scrip.";
    exit 1;
}

project_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"

docker run --detach --rm --name=${Container_Name} -h ${Container_Name} -v "$project_root":/opt/project -w /opt/project \
    -p ${EXTERNAL_MYSQL_PORT}:3306 \
    -e="MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" -e="MYSQL_DATABASE_NAME=$MYSQL_DATABASE_NAME" \
    -e="EXTERNAL_MYSQL_PORT=$EXTERNAL_MYSQL_PORT" ${DOCKER_HUB_IMAGE}
docker exec -it ${Container_Name} bash -c 'exec bash /opt/project/bin/bashrc'
docker stop ${Container_Name}
